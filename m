From: thomas charbonnel <thomas@undata.org>
Subject: [PATCH] hdsp fixes #2
Date: Thu, 27 Jan 2005 21:38:53 +0100
Message-ID: <1106858333.11185.17.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xBrw6M0G8/I0s8VyPp/k"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
List-Id: alsa-devel@alsa-project.org


--=-xBrw6M0G8/I0s8VyPp/k
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

This new patch against hdsp.c replaces the first one, with two more
entries in the changelog. 
hdsp.h and ALSA-Documentation.txt should still be patched with the
patches I sent yesterday.
Nando: this one should fix also the metering weirdnesses people were
seeing in hdspmixer, I hope you didn't build all those packages yet...
Takashi: this one is signed :)
I'd like to hear reports from users on ppc with this patch - anyone ?

Thomas


ChangeLog:
* init sequence cleanup and firmware upload related bugfixes
* more robust revision detection scheme
  (should transparently handle new revisions)
* allow hdsploader and the kernel fw loader to coexist
  this is useful for cardbus user who compiled the driver in-kernel
  (userspace may not be ready to upload the firmware when the card
   is probed)
* removed confusing and obsolete passthru option (was interfering
  with the mixer when opening the device for capture or playback)
  this change requires a recompile of the userspace tools against
  the patched hdsp.h
* removed confusing and obsolete line_outs_monitor module param
* made precise_ptr the default behaviour, and runtime tweakable
  (removed corresponding module param)
* add an alsa ctl to disable the use of the midi tasklet, and
  process midi data in the interrupt handler
  (using the tasklet is still the default)
  this is mainly intended for users of Ingo Molnar's RT patch
* metering fix for Multiface/Digiface users (closes ALSA BUG #0000801)
* small endianness fix
* ALSA-Configuration.txt HDSP entry update
* error messages cleanup

Signed-off-by: Thomas Charbonnel <thomas@undata.org>



--=-xBrw6M0G8/I0s8VyPp/k
Content-Disposition: attachment; filename=hdsp.c.patch
Content-Type: text/x-patch; name=hdsp.c.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- hdsp.c.old	2005-01-24 20:14:38.000000000 +0100
+++ hdsp.c	2005-01-27 20:32:55.000000000 +0100
@@ -47,8 +47,6 @@
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
-static int precise_ptr[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0 }; /* Enable precise pointer */
-static int line_outs_monitor[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0}; /* Send all inputs/playback to line outs */
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for RME Hammerfall DSP interface.");
@@ -56,10 +54,6 @@
 MODULE_PARM_DESC(id, "ID string for RME Hammerfall DSP interface.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable/disable specific Hammerfall DSP soundcards.");
-module_param_array(precise_ptr, bool, NULL, 0444);
-MODULE_PARM_DESC(precise_ptr, "Enable precise pointer (doesn't work reliably).");
-module_param_array(line_outs_monitor, bool, NULL, 0444);
-MODULE_PARM_DESC(line_outs_monitor, "Send all input and playback streams to line outs by default.");
 MODULE_AUTHOR("Paul Davis <paul@linuxaudiosystems.com>, Marcus Andersson, Thomas Charbonnel <thomas@undata.org>");
 MODULE_DESCRIPTION("RME Hammerfall DSP");
 MODULE_LICENSE("GPL");
@@ -445,6 +439,7 @@
 	snd_pcm_substream_t  *playback_substream;
         hdsp_midi_t           midi[2];
 	struct tasklet_struct midi_tasklet;
+	int		      use_midi_tasklet;
 	int                   precise_ptr;
 	u32                   control_register;	     /* cached value */
 	u32                   control2_register;     /* cached value */
@@ -472,7 +467,6 @@
 	pid_t                 capture_pid;
 	pid_t                 playback_pid;
 	int                   running;
-        int                   passthru;              /* non-zero if doing pass-thru */
 	int                   system_sample_rate;
 	char                 *channel_map;
 	int                   dev;
@@ -659,13 +653,13 @@
 
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
 		
-		snd_printk ("loading firmware\n");
+		snd_printk ("Hammerfall-DSP: loading firmware\n");
 
 		hdsp_write (hdsp, HDSP_control2Reg, HDSP_S_PROGRAM);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
 		
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
-			snd_printk ("timeout waiting for download preparation\n");
+			snd_printk ("Hammerfall-DSP: timeout waiting for download preparation\n");
 			return -EIO;
 		}
 		
@@ -674,7 +668,7 @@
 		for (i = 0; i < 24413; ++i) {
 			hdsp_write(hdsp, HDSP_fifoData, hdsp->firmware_cache[i]);
 			if (hdsp_fifo_wait (hdsp, 127, HDSP_LONG_WAIT)) {
-				snd_printk ("timeout during firmware loading\n");
+				snd_printk ("Hammerfall-DSP: timeout during firmware loading\n");
 				return -EIO;
 			}
 		}
@@ -687,7 +681,7 @@
 		}
 		
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
-			snd_printk ("timeout at end of firmware loading\n");
+			snd_printk ("Hammerfall-DSP: timeout at end of firmware loading\n");
 		    	return -EIO;
 		}
 
@@ -697,11 +691,11 @@
 		hdsp->control2_register = 0;
 #endif
 		hdsp_write (hdsp, HDSP_control2Reg, hdsp->control2_register);
-		snd_printk ("finished firmware loading\n");
+		snd_printk ("Hammerfall-DSP: finished firmware loading\n");
 		
 	}
 	if (hdsp->state & HDSP_InitializationComplete) {
-		snd_printk("firmware loaded from cache, restoring defaults\n");
+		snd_printk("Hammerfall-DSP: firmware loaded from cache, restoring defaults\n");
 		spin_lock_irqsave(&hdsp->lock, flags);
 		snd_hdsp_set_defaults(hdsp);
 		spin_unlock_irqrestore(&hdsp->lock, flags); 
@@ -714,16 +708,6 @@
 
 static int hdsp_get_iobox_version (hdsp_t *hdsp)
 {
-	int err;
-	
-	if (hdsp_check_for_iobox (hdsp)) {
-		return -EIO;
-	}
-
-	if ((err = snd_hdsp_enable_io(hdsp)) < 0) {
-		return err;
-	}
-		
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
 	
 		hdsp_write (hdsp, HDSP_control2Reg, HDSP_PROGRAM);
@@ -759,7 +743,7 @@
 {
 	if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return 0;
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
-		snd_printk("firmware not present.\n");
+		snd_printk("Hammerfall-DSP: firmware not present.\n");
 		hdsp->state &= ~HDSP_FirmwareLoaded;
 		return -EIO;
 	}
@@ -787,7 +771,7 @@
 		udelay (100);
 	}
 
-	snd_printk ("wait for FIFO status <= %d failed after %d iterations\n",
+	snd_printk ("Hammerfall-DSP: wait for FIFO status <= %d failed after %d iterations\n",
 		    count, timeout);
 	return -1;
 }
@@ -922,7 +906,7 @@
 	default:
 		break;
 	}
-	snd_printk ("unknown spdif frequency status; bits = 0x%x, status = 0x%x\n", rate_bits, status);
+	snd_printk ("Hammerfall-DSP: unknown spdif frequency status; bits = 0x%x, status = 0x%x\n", rate_bits, status);
 	return 0;
 }
 
@@ -1008,7 +992,7 @@
 	if (!(hdsp->control_register & HDSP_ClockModeMaster)) {	
 		if (called_internally) {
 			/* request from ctl or card initialization */
-			snd_printk("device is not running as a clock master: cannot set sample rate.\n");
+			snd_printk("Hammerfall-DSP: device is not running as a clock master: cannot set sample rate.\n");
 			return -1;
 		} else {		
 			/* hw_param request while in AutoSync mode */
@@ -1016,11 +1000,11 @@
 			int spdif_freq = hdsp_spdif_sample_rate(hdsp);
 		
 			if ((spdif_freq == external_freq*2) && (hdsp_autosync_ref(hdsp) >= HDSP_AUTOSYNC_FROM_ADAT1)) {
-				snd_printk("Detected ADAT in double speed mode\n");
+				snd_printk("Hammerfall-DSP: Detected ADAT in double speed mode\n");
 			} else if (hdsp->io_type == H9632 && (spdif_freq == external_freq*4) && (hdsp_autosync_ref(hdsp) >= HDSP_AUTOSYNC_FROM_ADAT1)) {
-				snd_printk("Detected ADAT in quad speed mode\n");			
+				snd_printk("Hammerfall-DSP: Detected ADAT in quad speed mode\n");			
 			} else if (rate != external_freq) {
-				snd_printk("No AutoSync source for requested rate\n");
+				snd_printk("Hammerfall-DSP: No AutoSync source for requested rate\n");
 				return -1;
 			}		
 		}	
@@ -1102,7 +1086,7 @@
 	}
 
 	if (reject_if_open && (hdsp->capture_pid >= 0 || hdsp->playback_pid >= 0)) {
-		snd_printk ("cannot change speed mode (capture PID = %d, playback PID = %d)\n",
+		snd_printk ("Hammerfall-DSP: cannot change speed mode (capture PID = %d, playback PID = %d)\n",
 			    hdsp->capture_pid,
 			    hdsp->playback_pid);
 		return -EBUSY;
@@ -1143,68 +1127,6 @@
 	return 0;
 }
 
-static void hdsp_set_thru(hdsp_t *hdsp, int channel, int enable)
-{
-
-	hdsp->passthru = 0;
-
-	if (channel < 0) {
-
-		int i;
-
-		/* set thru for all channels */
-
-		if (enable) {
-			for (i = 0; i < hdsp->max_channels; i++) {
-				hdsp_write_gain (hdsp, hdsp_input_to_output_key(hdsp,i,i), UNITY_GAIN);
-			}
-		} else {
-			for (i = 0; i < hdsp->max_channels; i++) {
-				hdsp_write_gain (hdsp, hdsp_input_to_output_key(hdsp,i,i), MINUS_INFINITY_GAIN);
-			}
-		}
-
-	} else {
-		int mapped_channel;
-
-		snd_assert(channel < hdsp->max_channels, return);
-
-		mapped_channel = hdsp->channel_map[channel];
-
-		snd_assert(mapped_channel > -1, return);
-
-		if (enable) {
-			hdsp_write_gain (hdsp, hdsp_input_to_output_key(hdsp,mapped_channel,mapped_channel), UNITY_GAIN);
-		} else {
-			hdsp_write_gain (hdsp, hdsp_input_to_output_key(hdsp,mapped_channel,mapped_channel), MINUS_INFINITY_GAIN);
-		}
-	}
-}
-
-static int hdsp_set_passthru(hdsp_t *hdsp, int onoff)
-{
-	if (onoff) {
-		hdsp_set_thru(hdsp, -1, 1);
-		hdsp_reset_hw_pointer(hdsp);
-		hdsp_silence_playback(hdsp);
-
-		/* we don't want interrupts, so do a
-		   custom version of hdsp_start_audio().
-		*/
-
-		hdsp->control_register |= (HDSP_Start|HDSP_AudioInterruptEnable|hdsp_encode_latency(7));
-
-		hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
-		hdsp->passthru = 1;
-	} else {
-		hdsp_set_thru(hdsp, -1, 0);
-		hdsp_stop_audio(hdsp);		
-		hdsp->passthru = 0;
-	}
-
-	return 0;
-}
-
 /*----------------------------------------------------------------------------
    MIDI
   ----------------------------------------------------------------------------*/
@@ -1345,6 +1267,7 @@
 		}
 	} else {
 		hdsp->control_register &= ~ie;
+		tasklet_kill(&hdsp->midi_tasklet);
 	}
 
 	hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
@@ -2741,16 +2664,32 @@
 	return 0;
 }
 
-#define HDSP_PASSTHRU(xname, xindex) \
+#define HDSP_LINE_OUT(xname, xindex) \
 { .iface = SNDRV_CTL_ELEM_IFACE_HWDEP, \
   .name = xname, \
   .index = xindex, \
-  .info = snd_hdsp_info_passthru, \
-  .put = snd_hdsp_put_passthru, \
-  .get = snd_hdsp_get_passthru \
+  .info = snd_hdsp_info_line_out, \
+  .get = snd_hdsp_get_line_out, \
+  .put = snd_hdsp_put_line_out \
+}
+
+static int hdsp_line_out(hdsp_t *hdsp)
+{
+	return (hdsp->control_register & HDSP_LineOut) ? 1 : 0;
+}
+
+static int hdsp_set_line_output(hdsp_t *hdsp, int out)
+{
+	if (out) {
+		hdsp->control_register |= HDSP_LineOut;
+	} else {
+		hdsp->control_register &= ~HDSP_LineOut;
+	}
+	hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
+	return 0;
 }
 
-static int snd_hdsp_info_passthru(snd_kcontrol_t * kcontrol, snd_ctl_elem_info_t * uinfo)
+static int snd_hdsp_info_line_out(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 1;
@@ -2759,61 +2698,106 @@
 	return 0;
 }
 
-static int snd_hdsp_get_passthru(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+static int snd_hdsp_get_line_out(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	hdsp_t *hdsp = snd_kcontrol_chip(kcontrol);
-
+	
 	spin_lock_irq(&hdsp->lock);
-	ucontrol->value.integer.value[0] = hdsp->passthru;
+	ucontrol->value.integer.value[0] = hdsp_line_out(hdsp);
 	spin_unlock_irq(&hdsp->lock);
 	return 0;
 }
 
-static int snd_hdsp_put_passthru(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+static int snd_hdsp_put_line_out(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	hdsp_t *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	int err = 0;
-
+	
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
-
 	val = ucontrol->value.integer.value[0] & 1;
 	spin_lock_irq(&hdsp->lock);
-	change = (ucontrol->value.integer.value[0] != hdsp->passthru);
-	if (change)
-		err = hdsp_set_passthru(hdsp, val);
+	change = (int)val != hdsp_line_out(hdsp);
+	hdsp_set_line_output(hdsp, val);
 	spin_unlock_irq(&hdsp->lock);
-	return err ? err : change;
+	return change;
 }
 
-#define HDSP_LINE_OUT(xname, xindex) \
+#define HDSP_PRECISE_POINTER(xname, xindex) \
 { .iface = SNDRV_CTL_ELEM_IFACE_HWDEP, \
   .name = xname, \
   .index = xindex, \
-  .info = snd_hdsp_info_line_out, \
-  .get = snd_hdsp_get_line_out, \
-  .put = snd_hdsp_put_line_out \
+  .info = snd_hdsp_info_precise_pointer, \
+  .get = snd_hdsp_get_precise_pointer, \
+  .put = snd_hdsp_put_precise_pointer \
 }
 
-static int hdsp_line_out(hdsp_t *hdsp)
+static int hdsp_set_precise_pointer(hdsp_t *hdsp, int precise)
 {
-	return (hdsp->control_register & HDSP_LineOut) ? 1 : 0;
+	if (precise) {
+		hdsp->precise_ptr = 1;
+	} else {
+		hdsp->precise_ptr = 0;
+	}
+	return 0;
 }
 
-static int hdsp_set_line_output(hdsp_t *hdsp, int out)
+static int snd_hdsp_info_precise_pointer(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
-	if (out) {
-		hdsp->control_register |= HDSP_LineOut;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int snd_hdsp_get_precise_pointer(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	hdsp_t *hdsp = snd_kcontrol_chip(kcontrol);
+	
+	spin_lock_irq(&hdsp->lock);
+	ucontrol->value.integer.value[0] = hdsp->precise_ptr;
+	spin_unlock_irq(&hdsp->lock);
+	return 0;
+}
+
+static int snd_hdsp_put_precise_pointer(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	hdsp_t *hdsp = snd_kcontrol_chip(kcontrol);
+	int change;
+	unsigned int val;
+	
+	if (!snd_hdsp_use_is_exclusive(hdsp))
+		return -EBUSY;
+	val = ucontrol->value.integer.value[0] & 1;
+	spin_lock_irq(&hdsp->lock);
+	change = (int)val != hdsp->precise_ptr;
+	hdsp_set_precise_pointer(hdsp, val);
+	spin_unlock_irq(&hdsp->lock);
+	return change;
+}
+
+#define HDSP_USE_MIDI_TASKLET(xname, xindex) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_HWDEP, \
+  .name = xname, \
+  .index = xindex, \
+  .info = snd_hdsp_info_use_midi_tasklet, \
+  .get = snd_hdsp_get_use_midi_tasklet, \
+  .put = snd_hdsp_put_use_midi_tasklet \
+}
+
+static int hdsp_set_use_midi_tasklet(hdsp_t *hdsp, int use_tasklet)
+{
+	if (use_tasklet) {
+		hdsp->use_midi_tasklet = 1;
 	} else {
-		hdsp->control_register &= ~HDSP_LineOut;
+		hdsp->use_midi_tasklet = 0;
 	}
-	hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
 	return 0;
 }
 
-static int snd_hdsp_info_line_out(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+static int snd_hdsp_info_use_midi_tasklet(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 1;
@@ -2822,17 +2806,17 @@
 	return 0;
 }
 
-static int snd_hdsp_get_line_out(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+static int snd_hdsp_get_use_midi_tasklet(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	hdsp_t *hdsp = snd_kcontrol_chip(kcontrol);
 	
 	spin_lock_irq(&hdsp->lock);
-	ucontrol->value.integer.value[0] = hdsp_line_out(hdsp);
+	ucontrol->value.integer.value[0] = hdsp->use_midi_tasklet;
 	spin_unlock_irq(&hdsp->lock);
 	return 0;
 }
 
-static int snd_hdsp_put_line_out(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+static int snd_hdsp_put_use_midi_tasklet(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	hdsp_t *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
@@ -2842,8 +2826,8 @@
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
 	spin_lock_irq(&hdsp->lock);
-	change = (int)val != hdsp_line_out(hdsp);
-	hdsp_set_line_output(hdsp, val);
+	change = (int)val != hdsp->use_midi_tasklet;
+	hdsp_set_use_midi_tasklet(hdsp, val);
 	spin_unlock_irq(&hdsp->lock);
 	return change;
 }
@@ -3139,8 +3123,9 @@
 HDSP_WC_SYNC_CHECK("Word Clock Lock Status", 0),
 HDSP_SPDIF_SYNC_CHECK("SPDIF Lock Status", 0),
 HDSP_ADATSYNC_SYNC_CHECK("ADAT Sync Lock Status", 0),
-HDSP_PASSTHRU("Passthru", 0),
 HDSP_LINE_OUT("Line Out", 0),
+HDSP_PRECISE_POINTER("Precise Pointer", 0),
+HDSP_USE_MIDI_TASKLET("Use Midi Tasklet", 0),
 };
 
 static snd_kcontrol_new_t snd_hdsp_96xx_aeb = HDSP_AEB("Analog Extension Board", 0);
@@ -3240,11 +3225,11 @@
 	snd_iprintf(buffer, "Status register: 0x%x\n", status);
 	snd_iprintf(buffer, "Status2 register: 0x%x\n", status2);
 	snd_iprintf(buffer, "FIFO status: %d\n", hdsp_read(hdsp, HDSP_fifoStatus) & 0xff);
-
 	snd_iprintf(buffer, "MIDI1 Output status: 0x%x\n", hdsp_read(hdsp, HDSP_midiStatusOut0));
 	snd_iprintf(buffer, "MIDI1 Input status: 0x%x\n", hdsp_read(hdsp, HDSP_midiStatusIn0));
 	snd_iprintf(buffer, "MIDI2 Output status: 0x%x\n", hdsp_read(hdsp, HDSP_midiStatusOut1));
 	snd_iprintf(buffer, "MIDI2 Input status: 0x%x\n", hdsp_read(hdsp, HDSP_midiStatusIn1));
+	snd_iprintf(buffer, "Use Midi Tasklet: %s\n", hdsp->use_midi_tasklet ? "on" : "off");
 
 	snd_iprintf(buffer, "\n");
 
@@ -3252,7 +3237,7 @@
 
 	snd_iprintf(buffer, "Buffer Size (Latency): %d samples (2 periods of %lu bytes)\n", x, (unsigned long) hdsp->period_bytes);
 	snd_iprintf(buffer, "Hardware pointer (frames): %ld\n", hdsp_hw_pointer(hdsp));
-	snd_iprintf(buffer, "Passthru: %s\n", hdsp->passthru ? "yes" : "no");
+	snd_iprintf(buffer, "Precise pointer: %s\n", hdsp->precise_ptr ? "on" : "off");
 	snd_iprintf(buffer, "Line out: %s\n", (hdsp->control_register & HDSP_LineOut) ? "on" : "off");
 
 	snd_iprintf(buffer, "Firmware version: %d\n", (status2&HDSP_version0)|(status2&HDSP_version1)<<1|(status2&HDSP_version2)<<2);
@@ -3612,40 +3597,6 @@
 		}
 	}
 	
-	if ((hdsp->io_type != H9652) && line_outs_monitor[hdsp->dev]) {
-		
-		int lineouts_base;
-		
-		snd_printk ("sending all inputs and playback streams to line outs.\n");
-
-		/* route all inputs to the line outs for easy monitoring. send
-		   odd numbered channels to right, even to left.
-		*/
-		if (hdsp->io_type == H9632) {
-			/* this is the phones/analog output */
-			lineouts_base = 10;
-		} else {
-			lineouts_base = 26;
-		}
-		
-		for (i = 0; i < hdsp->max_channels; i++) {
-			if (i & 1) { 
-				if (hdsp_write_gain (hdsp, hdsp_input_to_output_key (hdsp, i, lineouts_base), UNITY_GAIN) ||
-				    hdsp_write_gain (hdsp, hdsp_playback_to_output_key (hdsp, i, lineouts_base), UNITY_GAIN)) {
-				    return -EIO;
-				}    
-			} else {
-				if (hdsp_write_gain (hdsp, hdsp_input_to_output_key (hdsp, i, lineouts_base+1), UNITY_GAIN) ||
-				    hdsp_write_gain (hdsp, hdsp_playback_to_output_key (hdsp, i, lineouts_base+1), UNITY_GAIN)) {
-				    
-				    return -EIO;
-				}
-			}
-		}
-	}
-
-	hdsp->passthru = 0;
-
 	/* H9632 specific defaults */
 	if (hdsp->io_type == H9632) {
 		hdsp->control_register |= (HDSP_DAGainPlus4dBu | HDSP_ADGainPlus4dBu | HDSP_PhoneGain0dB);
@@ -3709,21 +3660,29 @@
 	}
 	
 	if (midi0 && midi0status) {
-		/* we disable interrupts for this input until processing is done */
-		hdsp->control_register &= ~HDSP_Midi0InterruptEnable;
-		hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
-		hdsp->midi[0].pending = 1;
-		schedule = 1;
+		if (hdsp->use_midi_tasklet) {
+			/* we disable interrupts for this input until processing is done */
+			hdsp->control_register &= ~HDSP_Midi0InterruptEnable;
+			hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
+			hdsp->midi[0].pending = 1;
+			schedule = 1;
+		} else {
+			snd_hdsp_midi_input_read (&hdsp->midi[0]);
+		}
 	}
 	if (midi1 && midi1status) {
-		/* we disable interrupts for this input until processing is done */
-		hdsp->control_register &= ~HDSP_Midi1InterruptEnable;
-		hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
-		hdsp->midi[1].pending = 1;
-		schedule = 1;
+		if (hdsp->use_midi_tasklet) {
+			/* we disable interrupts for this input until processing is done */
+			hdsp->control_register &= ~HDSP_Midi1InterruptEnable;
+			hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
+			hdsp->midi[1].pending = 1;
+			schedule = 1;
+		} else {
+			snd_hdsp_midi_input_read (&hdsp->midi[0]);
+		}
 	}
-	if (schedule)
-	    tasklet_hi_schedule(&hdsp->midi_tasklet);
+	if (hdsp->use_midi_tasklet && schedule)
+		tasklet_hi_schedule(&hdsp->midi_tasklet);
 	return IRQ_HANDLED;
 }
 
@@ -3838,10 +3797,10 @@
 	if (hdsp_check_for_firmware(hdsp)) {
 		if (hdsp->state & HDSP_FirmwareCached) {
 			if (snd_hdsp_load_firmware_from_cache(hdsp) != 0) {
-				snd_printk("Firmware loading from cache failed, please upload manually.\n");
+				snd_printk("Hammerfall-DSP: Firmware loading from cache failed, please upload manually.\n");
 			}
 		} else {
-			snd_printk("No firmware loaded nor cached, please upload firmware.\n");
+			snd_printk("Hammerfall-DSP: No firmware loaded nor cached, please upload firmware.\n");
 		}
 		return -EIO;
 	}
@@ -3957,10 +3916,10 @@
 	if (hdsp_check_for_firmware(hdsp)) {
 		if (hdsp->state & HDSP_FirmwareCached) {
 			if (snd_hdsp_load_firmware_from_cache(hdsp) != 0) {
-				snd_printk("Firmware loading from cache failed, please upload manually.\n");
+				snd_printk("Hammerfall-DSP: Firmware loading from cache failed, please upload manually.\n");
 			}
 		} else {
-			snd_printk("No firmware loaded nor cached, please upload firmware.\n");
+			snd_printk("Hammerfall-DSP: No firmware loaded nor cached, please upload firmware.\n");
 		}
 		return -EIO;
 	}
@@ -4035,10 +3994,10 @@
 	if (hdsp_check_for_firmware(hdsp)) {
 		if (hdsp->state & HDSP_FirmwareCached) {
 			if (snd_hdsp_load_firmware_from_cache(hdsp) != 0) {
-				snd_printk("Firmware loading from cache failed, please upload manually.\n");
+				snd_printk("Hammerfall-DSP: Firmware loading from cache failed, please upload manually.\n");
 			}
 		} else {
-			snd_printk("No firmware loaded nor cached, please upload firmware.\n");
+			snd_printk("Hammerfall-DSP: No firmware loaded nor cached, please upload firmware.\n");
 		}
 		return -EIO;
 	}
@@ -4057,7 +4016,11 @@
 				 SNDRV_PCM_INFO_NONINTERLEAVED |
 				 SNDRV_PCM_INFO_SYNC_START |
 				 SNDRV_PCM_INFO_DOUBLE),
+#ifdef SNDRV_BIG_ENDIAN
+	.formats =		SNDRV_PCM_FMTBIT_S32_BE,
+#else
 	.formats =		SNDRV_PCM_FMTBIT_S32_LE,
+#endif
 	.rates =		(SNDRV_PCM_RATE_32000 |
 				 SNDRV_PCM_RATE_44100 | 
 				 SNDRV_PCM_RATE_48000 | 
@@ -4082,7 +4045,11 @@
 				 SNDRV_PCM_INFO_MMAP_VALID |
 				 SNDRV_PCM_INFO_NONINTERLEAVED |
 				 SNDRV_PCM_INFO_SYNC_START),
+#ifdef SNDRV_BIG_ENDIAN
+	.formats =		SNDRV_PCM_FMTBIT_S32_BE,
+#else
 	.formats =		SNDRV_PCM_FMTBIT_S32_LE,
+#endif
 	.rates =		(SNDRV_PCM_RATE_32000 |
 				 SNDRV_PCM_RATE_44100 | 
 				 SNDRV_PCM_RATE_48000 | 
@@ -4290,10 +4257,10 @@
 	if (hdsp_check_for_firmware(hdsp)) {
 		if (hdsp->state & HDSP_FirmwareCached) {
 			if (snd_hdsp_load_firmware_from_cache(hdsp) != 0) {
-				snd_printk("Firmware loading from cache failed, please upload manually.\n");
+				snd_printk("Hammerfall-DSP: Firmware loading from cache failed, please upload manually.\n");
 			}
 		} else {
-			snd_printk("No firmware loaded nor cached, please upload firmware.\n");
+			snd_printk("Hammerfall-DSP: No firmware loaded nor cached, please upload firmware.\n");
 		}
 		return -EIO;
 	}
@@ -4306,11 +4273,6 @@
 	runtime->dma_area = hdsp->playback_buffer;
 	runtime->dma_bytes = HDSP_DMA_AREA_BYTES;
 
-	if (hdsp->capture_substream == NULL) {
-		hdsp_stop_audio(hdsp);
-		hdsp_set_thru(hdsp, -1, 0);
-	}
-
 	hdsp->playback_pid = current->pid;
 	hdsp->playback_substream = substream;
 
@@ -4373,10 +4335,10 @@
 	if (hdsp_check_for_firmware(hdsp)) {
 		if (hdsp->state & HDSP_FirmwareCached) {
 			if (snd_hdsp_load_firmware_from_cache(hdsp) != 0) {
-				snd_printk("Firmware loading from cache failed, please upload manually.\n");
+				snd_printk("Hammerfall-DSP: Firmware loading from cache failed, please upload manually.\n");
 			}
 		} else {
-			snd_printk("No firmware loaded nor cached, please upload firmware.\n");
+			snd_printk("Hammerfall-DSP: No firmware loaded nor cached, please upload firmware.\n");
 		}
 		return -EIO;
 	}
@@ -4389,11 +4351,6 @@
 	runtime->dma_area = hdsp->capture_buffer;
 	runtime->dma_bytes = HDSP_DMA_AREA_BYTES;
 
-	if (hdsp->playback_substream == NULL) {
-		hdsp_stop_audio(hdsp);
-		hdsp_set_thru(hdsp, -1, 0);
-	}
-
 	hdsp->capture_pid = current->pid;
 	hdsp->capture_substream = substream;
 
@@ -4553,12 +4510,12 @@
 	}
 	for (i = 0; i < 26; ++i) {
 		if (copy_u64_le(&peak_rms->playback_rms[i],
-				hdsp->iobase + HDSP_playbackRmsLevel + i * 8,
-				hdsp->iobase + HDSP_playbackRmsLevel + i * 8 + 4))
+				hdsp->iobase + HDSP_playbackRmsLevel + i * 8 + 4,
+				hdsp->iobase + HDSP_playbackRmsLevel + i * 8))
 			return -EFAULT;
 		if (copy_u64_le(&peak_rms->input_rms[i], 
-				hdsp->iobase + HDSP_inputRmsLevel + i * 8,
-				hdsp->iobase + HDSP_inputRmsLevel + i * 8 + 4))
+				hdsp->iobase + HDSP_inputRmsLevel + i * 8 + 4,
+				hdsp->iobase + HDSP_inputRmsLevel + i * 8))
 			return -EFAULT;
 	}
 	return 0;
@@ -4574,7 +4531,7 @@
 		hdsp_peak_rms_t __user *peak_rms = (hdsp_peak_rms_t __user *)arg;
 
 		if (!(hdsp->state & HDSP_FirmwareLoaded)) {
-			snd_printk(KERN_ERR "firmware needs to be uploaded to the card.\n");
+			snd_printk(KERN_ERR "Hammerfall-DSP: firmware needs to be uploaded to the card.\n");
 			return -EINVAL;
 		}
 
@@ -4593,7 +4550,7 @@
 		int i;
 		
 		if (!(hdsp->state & HDSP_FirmwareLoaded)) {
-			snd_printk("Firmware needs to be uploaded to the card.\n");	
+			snd_printk("Hammerfall-DSP: Firmware needs to be uploaded to the card.\n");	
 			return -EINVAL;
 		}
 		spin_lock_irqsave(&hdsp->lock, flags);
@@ -4618,7 +4575,6 @@
 		info.clock_source = (unsigned char)hdsp_clock_source(hdsp);
 		info.autosync_ref = (unsigned char)hdsp_autosync_ref(hdsp);
 		info.line_out = (unsigned char)hdsp_line_out(hdsp);
-		info.passthru = (unsigned char)hdsp->passthru;
 		if (hdsp->io_type == H9632) {
 			info.da_gain = (unsigned char)hdsp_da_gain(hdsp);
 			info.ad_gain = (unsigned char)hdsp_ad_gain(hdsp);
@@ -4661,7 +4617,6 @@
 		}
 		break;
 	}
-#ifndef HDSP_FW_LOADER
 	case SNDRV_HDSP_IOCTL_UPLOAD_FIRMWARE: {
 		hdsp_firmware_t __user *firmware;
 		u32 __user *firmware_data;
@@ -4674,7 +4629,7 @@
 		if (hdsp->state & (HDSP_FirmwareCached | HDSP_FirmwareLoaded))
 			return -EBUSY;
 
-		snd_printk("initializing firmware upload\n");
+		snd_printk("Hammerfall-DSP: initializing firmware upload\n");
 		firmware = (hdsp_firmware_t __user *)argp;
 
 		if (get_user(firmware_data, &firmware->firmware_data)) {
@@ -4696,18 +4651,20 @@
 		}
 		
 		if (!(hdsp->state & HDSP_InitializationComplete)) {
-			snd_hdsp_initialize_channels(hdsp);
-		
+			if ((err = snd_hdsp_enable_io(hdsp)) < 0) {
+				return err;
+			}
+			
+			snd_hdsp_initialize_channels(hdsp);		
 			snd_hdsp_initialize_midi_flush(hdsp);
 	    
 			if ((err = snd_hdsp_create_alsa_devices(hdsp->card, hdsp)) < 0) {
-				snd_printk("error creating alsa devices\n");
+				snd_printk("Hammerfall-DSP: error creating alsa devices\n");
 			    return err;
 			}
 		}
 		break;
 	}
-#endif
 	case SNDRV_HDSP_IOCTL_GET_MIXER: {
 		hdsp_mixer_t __user *mixer = (hdsp_mixer_t __user *)argp;
 		if (copy_to_user(mixer->matrix, hdsp->mixer_matrix, sizeof(unsigned short)*HDSP_MATRIX_MIXER_SIZE))
@@ -4794,6 +4751,7 @@
 	int i;
 	
 	if (hdsp_fifo_wait (hdsp, 0, 100)) {
+		snd_printk("Hammerfall-DSP: enable_io fifo_wait failed\n");
 		return -EIO;
 	}
 	
@@ -4859,24 +4817,24 @@
 	int err;
 	
 	if ((err = snd_hdsp_create_pcm(card, hdsp)) < 0) {
-		snd_printk("Error creating pcm interface\n");
+		snd_printk("Hammerfall-DSP: Error creating pcm interface\n");
 		return err;
 	}
 	
 
 	if ((err = snd_hdsp_create_midi(card, hdsp, 0)) < 0) {
-		snd_printk("Error creating first midi interface\n");
+		snd_printk("Hammerfall-DSP: Error creating first midi interface\n");
 		return err;
 	}
 
 
 	if ((err = snd_hdsp_create_midi(card, hdsp, 1)) < 0) {
-		snd_printk("Error creating second midi interface\n");
+		snd_printk("Hammerfall-DSP: Error creating second midi interface\n");
 		return err;
 	}
 
 	if ((err = snd_hdsp_create_controls(card, hdsp)) < 0) {
-		snd_printk("Error creating ctl interface\n");
+		snd_printk("Hammerfall-DSP: Error creating ctl interface\n");
 		return err;
 	}
 
@@ -4889,7 +4847,7 @@
 	hdsp->playback_substream = NULL;
 
 	if ((err = snd_hdsp_set_defaults(hdsp)) < 0) {
-		snd_printk("Error setting default values\n");
+		snd_printk("Hammerfall-DSP: Error setting default values\n");
 		return err;
 	}
 	
@@ -4898,7 +4856,7 @@
 			hdsp->port, hdsp->irq);
 	    
 		if ((err = snd_card_register(card)) < 0) {
-			snd_printk("error registering card\n");
+			snd_printk("Hammerfall-DSP: error registering card\n");
 			return err;
 		}
 		hdsp->state |= HDSP_InitializationComplete;
@@ -4923,9 +4881,7 @@
 		if (hdsp->io_type == H9652 || hdsp->io_type == H9632)
 			return 0;
 	}
-	if (hdsp_check_for_iobox (hdsp))
-		return -EIO;
-
+	
 	/* caution: max length of firmware filename is 30! */
 	switch (hdsp->io_type) {
 	case Multiface:
@@ -4941,16 +4897,16 @@
 			fwfile = "digiface_firmware_rev11.bin";
 		break;
 	default:
-		snd_printk(KERN_ERR "hdsp: invalid io_type %d\n", hdsp->io_type);
+		snd_printk(KERN_ERR "Hammerfall-DSP: invalid io_type %d\n", hdsp->io_type);
 		return -EINVAL;
 	}
 
 	if (request_firmware(&fw, fwfile, &hdsp->pci->dev)) {
-		snd_printk(KERN_ERR "hdsp: cannot load firmware %s\n", fwfile);
+		snd_printk(KERN_ERR "Hammerfall-DSP: cannot load firmware %s\n", fwfile);
 		return -ENOENT;
 	}
 	if (fw->size < sizeof(hdsp->firmware_cache)) {
-		snd_printk(KERN_ERR "hdsp: too short firmware size %d (expected %d)\n",
+		snd_printk(KERN_ERR "Hammerfall-DSP: too short firmware size %d (expected %d)\n",
 			   (int)fw->size, (int)sizeof(hdsp->firmware_cache));
 		release_firmware(fw);
 		return -EINVAL;
@@ -4969,17 +4925,25 @@
 	memcpy(hdsp->firmware_cache, fw->data, sizeof(hdsp->firmware_cache));
 #endif
 	release_firmware(fw);
-	
+		
 	hdsp->state |= HDSP_FirmwareCached;
 
 	if ((err = snd_hdsp_load_firmware_from_cache(hdsp)) < 0)
 		return err;
 		
 	if (!(hdsp->state & HDSP_InitializationComplete)) {
+		if ((err = snd_hdsp_enable_io(hdsp)) < 0) {
+			return err;
+		}
+
+		if ((err = snd_hdsp_create_hwdep(hdsp->card, hdsp)) < 0) {
+			snd_printk("Hammerfall-DSP: error creating hwdep device\n");
+			return err;
+		}
 		snd_hdsp_initialize_channels(hdsp);
 		snd_hdsp_initialize_midi_flush(hdsp);
 		if ((err = snd_hdsp_create_alsa_devices(hdsp->card, hdsp)) < 0) {
-			snd_printk("error creating alsa devices\n");
+			snd_printk("Hammerfall-DSP: error creating alsa devices\n");
 			return err;
 		}
 	}
@@ -4988,8 +4952,7 @@
 #endif
 
 static int __devinit snd_hdsp_create(snd_card_t *card,
-				     hdsp_t *hdsp,
-				     int precise_ptr)
+				     hdsp_t *hdsp)
 {
 	struct pci_dev *pci = hdsp->pci;
 	int err;
@@ -5019,6 +4982,7 @@
 	tasklet_init(&hdsp->midi_tasklet, hdsp_midi_tasklet, (unsigned long)hdsp);
 	
 	pci_read_config_word(hdsp->pci, PCI_CLASS_REVISION, &hdsp->firmware_rev);
+	hdsp->firmware_rev &= 0xff;
 	
 	/* From Martin Bjoernsen :
 	    "It is important that the card's latency timer register in
@@ -5032,27 +4996,17 @@
 	strcpy(card->driver, "H-DSP");
 	strcpy(card->mixername, "Xilinx FPGA");
 
-	switch (hdsp->firmware_rev & 0xff) {
-	case 0xa:
-	case 0xb:
-	case 0x32:
+	if (hdsp->firmware_rev < 0xa) {
+		return -ENODEV;
+	} else if (hdsp->firmware_rev < 0x64) {
 		hdsp->card_name = "RME Hammerfall DSP";
-		break;
-
-	case 0x64:
-	case 0x65:
-	case 0x68:
+	} else if (hdsp->firmware_rev < 0x96) {
 		hdsp->card_name = "RME HDSP 9652";
 		is_9652 = 1;
-		break;
-	case 0x96:
-	case 0x97:
+	} else {
 		hdsp->card_name = "RME HDSP 9632";
 		hdsp->max_channels = 16;
-		is_9632 = 1;
-		break;
-	default:
-		return -ENODEV;
+		is_9632 = 1;	
 	}
 
 	if ((err = pci_enable_device(pci)) < 0) {
@@ -5065,56 +5019,65 @@
 		return err;
 	hdsp->port = pci_resource_start(pci, 0);
 	if ((hdsp->iobase = ioremap_nocache(hdsp->port, HDSP_IO_EXTENT)) == NULL) {
-		snd_printk("unable to remap region 0x%lx-0x%lx\n", hdsp->port, hdsp->port + HDSP_IO_EXTENT - 1);
+		snd_printk("Hammerfall-DSP: unable to remap region 0x%lx-0x%lx\n", hdsp->port, hdsp->port + HDSP_IO_EXTENT - 1);
 		return -EBUSY;
 	}
 
 	if (request_irq(pci->irq, snd_hdsp_interrupt, SA_INTERRUPT|SA_SHIRQ, "hdsp", (void *)hdsp)) {
-		snd_printk("unable to use IRQ %d\n", pci->irq);
+		snd_printk("Hammerfall-DSP: unable to use IRQ %d\n", pci->irq);
 		return -EBUSY;
 	}
 
 	hdsp->irq = pci->irq;
-	hdsp->precise_ptr = precise_ptr;
+	hdsp->precise_ptr = 1;
+	hdsp->use_midi_tasklet = 1;
 
 	if ((err = snd_hdsp_initialize_memory(hdsp)) < 0) {
 		return err;
 	}
 	
-	if (!is_9652 && !is_9632 && hdsp_check_for_iobox (hdsp)) {
-		/* no iobox connected, we defer initialization */
-		snd_printk("card initialization pending : waiting for firmware\n");
-		if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0) {
-			return err;
+	if (!is_9652 && !is_9632) {
+		/* we wait 2 seconds to let freshly inserted cardbus cards do their hardware init */
+ 		if ((1000 / HZ) < 2000) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout((2000 * HZ + 999) / 1000);
+		} else {
+			mdelay(2000);
+		}
+
+		if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
+#ifdef HDSP_FW_LOADER
+			if ((err = hdsp_request_fw_loader(hdsp)) < 0) {
+				/* we don't fail as this can happen
+				   if userspace is not ready for
+				   firmware upload
+				*/
+				snd_printk("Hammerfall-DSP: couldn't get firmware from userspace. try using hdsploader\n");
+			} else {
+				/* init is complete, we return */
+				return 0;
+			}
+#endif
+			/* no iobox connected, we defer initialization */
+			snd_printk("Hammerfall-DSP: card initialization pending : waiting for firmware\n");
+			if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0) {
+				return err;
+			}
+			return 0;
+		} else {
+			snd_printk("Hammerfall-DSP: Firmware already present, initializing card.\n");	    
+			if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version1) {
+				hdsp->io_type = Multiface;
+			} else {
+				hdsp->io_type = Digiface;
+			}
 		}
-		return 0;
 	}
 	
 	if ((err = snd_hdsp_enable_io(hdsp)) != 0) {
 		return err;
 	}
 	
-	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
-#ifdef HDSP_FW_LOADER
-		if ((err = hdsp_request_fw_loader(hdsp)) < 0)
-			return err;
-#else
-		snd_printk("card initialization pending : waiting for firmware\n");
-		if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0) {
-			return err;
-		}
-		return 0;
-#endif
-	} 
-	
-	snd_printk("Firmware already loaded, initializing card.\n");
-	
-	if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version1) {
-		hdsp->io_type = Multiface;
-	} else {
-		hdsp->io_type = Digiface;
-	}
-
 	if (is_9652) {
 	        hdsp->io_type = H9652;
 	}
@@ -5143,6 +5106,7 @@
 {
 	if (hdsp->port) {
 		/* stop the audio, and cancel all interrupts */
+		tasklet_kill(&hdsp->midi_tasklet);
 		hdsp->control_register &= ~(HDSP_Start|HDSP_AudioInterruptEnable|HDSP_Midi0InterruptEnable|HDSP_Midi1InterruptEnable);
 		hdsp_write (hdsp, HDSP_controlRegister, hdsp->control_register);
 	}
@@ -5194,7 +5158,7 @@
 	hdsp->pci = pci;
 	snd_card_set_dev(card, &pci->dev);
 
-	if ((err = snd_hdsp_create(card, hdsp, precise_ptr[dev])) < 0) {
+	if ((err = snd_hdsp_create(card, hdsp)) < 0) {
 		snd_card_free(card);
 		return err;
 	}

--=-xBrw6M0G8/I0s8VyPp/k--



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
