From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [PATCH] cs46xx DAC volume's mechanism rewrite, minor bugfixes
Date: Sun, 10 Nov 2002 20:38:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DCEB5A4.4090600@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070609020008030804060500"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070609020008030804060500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

This patch changes the way the DAC volume are set on DSP SCB tasks. I 
would like to know
if maybe this fixes the "bass"  problem that some users have experienced 
with the cs46xx driver.

Still some more attempts to have AC3 through IEC958, but no success yet ...

Summary:
- DAC volume mechanism  rewrite (added cs46xx_dsp_set_dac_volume (...) 
in dsp_spos.c)
- IEC958 input volume mechanism rewrite (added 
cs46xx_dsp_set_iec958_volume (...) in dsp_spos.c)
- Enable IEC958 hw if not done in cs46xx_iec958_pre_open (...)
- Added "AC3 Mode Switch" in mixer, when enabled appropiate status
bit's (non-audio, profesional) are set in IEC958 stream and PCM channel 
is locked to 48Khz
- Typo fix in constant name DSP_SDPIF... -> DSP_SPDIF...
- Some code cleanups

/Benny

--------------070609020008030804060500
Content-Type: text/plain;
 name="cs46xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx.patch"

diff --exclude=Makefile --exclude=CVS -Naur alsa-kernel/include/cs46xx_dsp_spos.h ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h
--- alsa-kernel/include/cs46xx_dsp_spos.h	Mon Nov  4 19:49:48 2002
+++ ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h	Sun Nov 10 14:35:17 2002
@@ -60,9 +60,10 @@
 #define DSP_PCM_LFE_CHANNEL     4
 #define DSP_IEC958_CHANNEL      5
 
-#define DSP_SDPIF_STATUS_OUTPUT_ENABLED 1
-#define DSP_SDPIF_STATUS_PLAYBACK_OPEN  2
-#define DSP_SDPIF_STATUS_HW_ENABLED     4
+#define DSP_SPDIF_STATUS_OUTPUT_ENABLED 1
+#define DSP_SPDIF_STATUS_PLAYBACK_OPEN  2
+#define DSP_SPDIF_STATUS_HW_ENABLED     4
+#define DSP_SPDIF_STATUS_AC3_MODE       8
 
 struct _dsp_module_desc_t;
 
@@ -155,6 +156,8 @@
 
 	/* Main PCM playback mixer */
 	dsp_scb_descriptor_t * master_mix_scb;
+	u16 dac_volume_right;
+	u16 dac_volume_left;
 
 	/* Rear PCM playback mixer */
 	dsp_scb_descriptor_t * rear_mix_scb;
@@ -191,7 +194,8 @@
 	/* SPDIF status */
 	int spdif_status_out;
 	int spdif_status_in;
-	u32 spdif_input_volume;
+	u16 spdif_input_volume_right;
+	u16 spdif_input_volume_left;
 
 	/* SPDIF input sample rate converter */
 	dsp_scb_descriptor_t * spdif_in_src;
@@ -221,4 +225,3 @@
 } dsp_spos_instance_t;
 
 #endif /* __DSP_SPOS_H__ */
-
diff --exclude=Makefile --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Mon Nov  4 19:49:57 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sun Nov 10 15:10:22 2002
@@ -952,7 +952,9 @@
 			snd_cs46xx_playback_transfer(substream, 0);
 
 		/* raise playback volume */
-		snd_cs46xx_poke(chip, (cpcm->pcm_channel->pcm_reader_scb->address + 0xE) << 2, 0x80008000);
+		cs46xx_dsp_scb_set_volume (chip,cpcm->pcm_channel->pcm_reader_scb,
+					   chip->dsp_spos_instance->dac_volume_right,
+					   chip->dsp_spos_instance->dac_volume_left);
 #else
 		if (substream->runtime->periods != CS46XX_FRAGS)
 			snd_cs46xx_playback_transfer(substream, 0);
@@ -966,8 +968,9 @@
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-        /* mute channel */
-		snd_cs46xx_poke(chip, (cpcm->pcm_channel->pcm_reader_scb->address + 0xE) << 2, 0xffffffff);
+		/* mute channel */
+		cs46xx_dsp_scb_set_volume (chip,cpcm->pcm_channel->pcm_reader_scb,0,0);
+
 		if (!cpcm->pcm_channel->unlinked)
 			cs46xx_dsp_pcm_unlink(chip,cpcm->pcm_channel);
 #else
@@ -1020,36 +1023,27 @@
 	return result;
 }
 
-static int snd_cs46xx_playback_hw_params(snd_pcm_substream_t * substream,
-					 snd_pcm_hw_params_t * hw_params)
+static int _cs46xx_adjust_sample_rate (cs46xx_t *chip, cs46xx_pcm_t *cpcm,
+				       int sample_rate) 
 {
-	/*cs46xx_t *chip = snd_pcm_substream_chip(substream);*/
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	cs46xx_pcm_t *cpcm;
-	int err;
-	cs46xx_t *chip = snd_pcm_substream_chip(substream);
-	int sample_rate = params_rate(hw_params);
-	int period_size = params_period_size(hw_params);
-	cpcm = snd_magic_cast(cs46xx_pcm_t, runtime->private_data, return -ENXIO);
-
-#ifdef CONFIG_SND_CS46XX_NEW_DSP
-	down (&chip->spos_mutex);
-
-	snd_assert (cpcm->pcm_channel != NULL);
-
+	/* if this is the only PCMReaderSCB child under current
+	   SrcTask then there no need to re-create pcm-channel */
 	if ( cpcm->pcm_channel->src_scb->ref_count == 1 &&
 	     cpcm->pcm_channel->sample_rate != sample_rate &&
 	     /* never set a 0 khz sample rate */
 	     sample_rate) {
 		/* sample rate not set or we can reuse
 		   the same SRC*/
-
 		cs46xx_dsp_set_src_sample_rate (chip,cpcm->pcm_channel->src_scb,sample_rate);
 		cpcm->pcm_channel->sample_rate = sample_rate;
 	} 
 
-	if (cpcm->pcm_channel->sample_rate != runtime->rate &&
-	    cpcm->pcm_channel->src_scb->ref_count != 1) {
+	/* if there is more then 1 PCMReaderSCB child's under current
+	   SrcTask then we must recreate channel */
+	if (cpcm->pcm_channel->sample_rate != sample_rate &&
+	    cpcm->pcm_channel->src_scb->ref_count != 1 &&
+	    /* never set a 0 khz sample rate */
+	    sample_rate) {
 		int unlinked = cpcm->pcm_channel->unlinked;
 		cs46xx_dsp_destroy_pcm_channel (chip,cpcm->pcm_channel);
 
@@ -1065,6 +1059,34 @@
 		cpcm->pcm_channel->sample_rate = sample_rate;
 	}
 
+	return 0;
+}
+static int snd_cs46xx_playback_hw_params(snd_pcm_substream_t * substream,
+					 snd_pcm_hw_params_t * hw_params)
+{
+	/*cs46xx_t *chip = snd_pcm_substream_chip(substream);*/
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	cs46xx_pcm_t *cpcm;
+	int err;
+	cs46xx_t *chip = snd_pcm_substream_chip(substream);
+	int sample_rate = params_rate(hw_params);
+	int period_size = params_period_size(hw_params);
+	cpcm = snd_magic_cast(cs46xx_pcm_t, runtime->private_data, return -ENXIO);
+
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+	down (&chip->spos_mutex);
+
+	snd_assert (cpcm->pcm_channel != NULL);
+
+	/* if IEC958 is opened in AC3 mode dont adjust SRCTask is not
+	   used so dont adjust sample rate */
+	if (cpcm->pcm_channel->pcm_channel_id != DSP_IEC958_CHANNEL ||
+	    !(chip->dsp_spos_instance->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE)) {
+		if (_cs46xx_adjust_sample_rate (chip,cpcm,sample_rate)) {
+			return -ENXIO;
+		}
+	}
+
 	if (cs46xx_dsp_pcm_channel_set_period (chip,cpcm->pcm_channel,period_size * 4)) {
 		 up (&chip->spos_mutex);
 		 return -EINVAL;
@@ -1825,7 +1847,7 @@
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 32767;
+	uinfo->value.integer.max = 0x7fff;
 	return 0;
 }
 
@@ -1847,26 +1869,9 @@
 			    (0xffff - ucontrol->value.integer.value[1]));
 	unsigned int old = snd_cs46xx_peek(chip, reg);
 	int change = (old != val);
+
 	if (change) {
 		snd_cs46xx_poke(chip, reg, val);
-#ifdef CONFIG_SND_CS46XX_NEW_DSP
-		/* NOTE: this updates the current left and right volume
-		   that should be automatically updated by the DSP and
-		   not touched by the host. But for some strange reason
-		   the DSP only updates the right channel volume, so with
-		   this dirty hack we force updating the right and left
-		   channel volume. 
-		*/
-		snd_cs46xx_poke(chip, reg + 4, val);
-
-		/* shadow the SPDIF input volume */
-		if (reg == (ASYNCRX_SCB_ADDR + 0xE) << 2) {
-			/* FIXME: I known this is uggly ...
-			   any other suggestion ? 
-			*/
-			chip->dsp_spos_instance->spdif_input_volume = val;
-		}
-#endif
 	}
 
 	return change;
@@ -1874,6 +1879,57 @@
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 
+static int snd_cs46xx_vol_dac_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	cs46xx_t *chip = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = chip->dsp_spos_instance->dac_volume_right;
+	ucontrol->value.integer.value[1] = chip->dsp_spos_instance->dac_volume_left;
+
+	return 0;
+}
+
+static int snd_cs46xx_vol_dac_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	cs46xx_t *chip = snd_kcontrol_chip(kcontrol);
+	int change = 0;
+
+	if (chip->dsp_spos_instance->dac_volume_right != ucontrol->value.integer.value[0] ||
+	    chip->dsp_spos_instance->dac_volume_left != ucontrol->value.integer.value[1]) {
+		cs46xx_dsp_set_dac_volume(chip,
+					  ucontrol->value.integer.value[0],
+					  ucontrol->value.integer.value[1]);
+		change = 1;
+	}
+
+	return change;
+}
+
+static int snd_cs46xx_vol_iec958_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	cs46xx_t *chip = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = chip->dsp_spos_instance->spdif_input_volume_right;
+	ucontrol->value.integer.value[1] = chip->dsp_spos_instance->spdif_input_volume_left;
+	return 0;
+}
+
+static int snd_cs46xx_vol_iec958_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	cs46xx_t *chip = snd_kcontrol_chip(kcontrol);
+	int change = 0;
+
+	if (chip->dsp_spos_instance->spdif_input_volume_right != ucontrol->value.integer.value[0] ||
+	    chip->dsp_spos_instance->spdif_input_volume_left != ucontrol->value.integer.value[1]) {
+		cs46xx_dsp_set_iec958_volume (chip,
+					      ucontrol->value.integer.value[0],
+					      ucontrol->value.integer.value[1]);
+		change = 1;
+	}
+
+	return change;
+}
+
 static int snd_mixer_boolean_info(snd_kcontrol_t *kcontrol, 
 				  snd_ctl_elem_info_t *uinfo)
 {
@@ -1891,7 +1947,7 @@
 	int reg = kcontrol->private_value;
 
 	if (reg == CS46XX_MIXER_SPDIF_OUTPUT_ELEMENT)
-		ucontrol->value.integer.value[0] = (chip->dsp_spos_instance->spdif_status_out & DSP_SDPIF_STATUS_OUTPUT_ENABLED);
+		ucontrol->value.integer.value[0] = (chip->dsp_spos_instance->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED);
 	else
 		ucontrol->value.integer.value[0] = chip->dsp_spos_instance->spdif_status_in;
 
@@ -1907,13 +1963,13 @@
 	switch (kcontrol->private_value) {
 	case CS46XX_MIXER_SPDIF_OUTPUT_ELEMENT:
 		down (&chip->spos_mutex);
-		change = (chip->dsp_spos_instance->spdif_status_out & DSP_SDPIF_STATUS_OUTPUT_ENABLED);
+		change = (chip->dsp_spos_instance->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED);
 		if (ucontrol->value.integer.value[0] && !change) 
 			cs46xx_dsp_enable_spdif_out(chip);
 		else if (change && !ucontrol->value.integer.value[0])
 			cs46xx_dsp_disable_spdif_out(chip);
 
-		res = (change != (chip->dsp_spos_instance->spdif_status_out & DSP_SDPIF_STATUS_OUTPUT_ENABLED));
+		res = (change != (chip->dsp_spos_instance->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED));
 		up (&chip->spos_mutex);
 		break;
 	case CS46XX_MIXER_SPDIF_INPUT_ELEMENT:
@@ -1979,6 +2035,35 @@
 	return 0;
 }
 
+static int snd_cs46xx_iec958_ac3_mode_get(snd_kcontrol_t *kcontrol, 
+					  snd_ctl_elem_value_t *ucontrol) 
+{
+	cs46xx_t *chip = snd_kcontrol_chip(kcontrol);
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+
+	if (!ins->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE) 
+		ucontrol->value.integer.value[0] = 1;
+	else
+		ucontrol->value.integer.value[0] = 0;
+
+	return 0;
+}
+
+static int snd_cs46xx_iec958_ac3_mode_put(snd_kcontrol_t *kcontrol, 
+                                      snd_ctl_elem_value_t *ucontrol) 
+{
+	cs46xx_t *chip = snd_kcontrol_chip(kcontrol);
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+	int old = ins->spdif_status_out;
+
+	if (ucontrol->value.integer.value[0]) 
+		ins->spdif_status_out |= DSP_SPDIF_STATUS_AC3_MODE;
+	else
+		ins->spdif_status_out &= ~DSP_SPDIF_STATUS_AC3_MODE;
+
+	return (old != ins->spdif_status_out);
+}
+
 static int snd_cs46xx_pcm_capture_put(snd_kcontrol_t *kcontrol, 
                                       snd_ctl_elem_value_t *ucontrol)
 {
@@ -2013,7 +2098,7 @@
 }
 
 /*
- *	Game Theatre XP card - EGPIO[0] is used to select SDPIF input optical or coaxial.
+ *	Game Theatre XP card - EGPIO[0] is used to select SPDIF input optical or coaxial.
  */ 
 static int snd_herc_spdif_select_put(snd_kcontrol_t *kcontrol, 
                                        snd_ctl_elem_value_t *ucontrol)
@@ -2111,13 +2196,13 @@
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "DAC Volume",
 	.info = snd_cs46xx_vol_info,
+#ifndef CONFIG_SND_CS46XX_NEW_DSP
 	.get = snd_cs46xx_vol_get,
 	.put = snd_cs46xx_vol_put,
-
-#ifndef CONFIG_SND_CS46XX_NEW_DSP
 	.private_value = BA1_PVOL,
 #else
-	.private_value = (MASTERMIX_SCB_ADDR + 0xE) << 2,
+	.get = snd_cs46xx_vol_dac_get,
+	.put = snd_cs46xx_vol_dac_put,
 #endif
 },
 
@@ -2158,6 +2243,13 @@
 },
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "IEC 958 AC3 Mode Switch",
+	.info = snd_mixer_boolean_info,
+	.get = snd_cs46xx_iec958_ac3_mode_get,
+	.put = snd_cs46xx_iec958_ac3_mode_put,
+},
+{
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "IEC 958 Input Switch",
 	.info = snd_mixer_boolean_info,
 	.get = snd_cs46xx_iec958_get,
@@ -2168,8 +2260,8 @@
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "IEC 958 Input Volume",
 	.info = snd_cs46xx_vol_info,
-	.get = snd_cs46xx_vol_get,
-	.put = snd_cs46xx_vol_put,
+	.get = snd_cs46xx_vol_iec958_get,
+	.put = snd_cs46xx_vol_iec958_put,
 	.private_value = (ASYNCRX_SCB_ADDR + 0xE) << 2,
 },
 #endif
diff --exclude=Makefile --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.h ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h
--- alsa-kernel/pci/cs46xx/cs46xx_lib.h	Mon Nov  4 19:49:57 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h	Sun Nov 10 02:18:12 2002
@@ -217,4 +217,6 @@
 							       int period_size);
 int                        cs46xx_dsp_pcm_ostream_set_period (cs46xx_t * chip,
 							      int period_size);
+int                        cs46xx_dsp_set_dac_volume (cs46xx_t * chip,u16 right,u16 left);
+int                        cs46xx_dsp_set_iec958_volume (cs46xx_t * chip,u16 right,u16 left);
 #endif /* __CS46XX_LIB_H__ */
diff --exclude=Makefile --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c
--- alsa-kernel/pci/cs46xx/dsp_spos.c	Mon Nov  4 19:49:57 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c	Sun Nov 10 14:37:34 2002
@@ -257,7 +257,10 @@
 	ins->spdif_in_sample_rate = 48000;
 
 	/* maximize volume */
-	ins->spdif_input_volume = 0x80008000;
+	ins->dac_volume_right = 0x8000;
+	ins->dac_volume_left = 0x8000;
+	ins->spdif_input_volume_right = 0x8000;
+	ins->spdif_input_volume_left = 0x8000;
 
 	return ins;
 }
@@ -1549,7 +1552,7 @@
 	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 << 12));
 
 	/* monitor state */
-	ins->spdif_status_out |= DSP_SDPIF_STATUS_HW_ENABLED;
+	ins->spdif_status_out |= DSP_SPDIF_STATUS_HW_ENABLED;
 
 	return 0;
 }
@@ -1585,8 +1588,10 @@
 	cs46xx_src_link(chip,ins->spdif_in_src);
 
 	/* restore SPDIF input volume */
-	snd_cs46xx_poke(chip, (ASYNCRX_SCB_ADDR + 0xE) << 2, ins->spdif_input_volume);
-	snd_cs46xx_poke(chip, (ASYNCRX_SCB_ADDR + 0xF) << 2, ins->spdif_input_volume);
+	cs46xx_dsp_scb_set_volume (chip,ins->spdif_in_src,
+				   ins->spdif_input_volume_right,
+				   ins->spdif_input_volume_left);
+
 	spin_unlock_irq(&chip->reg_lock);
 
 	/* set SPDIF input sample rate and unmute
@@ -1716,6 +1721,44 @@
 		snd_printk(KERN_ERR "dsp_spos: SPIOWriteTask not responding\n");
 		return -EBUSY;
 	}
+
+	return 0;
+}
+
+int cs46xx_dsp_set_dac_volume (cs46xx_t * chip,u16 right,u16 left)
+{
+	int i;
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+
+	down(&chip->spos_mutex);
+
+	ins->dac_volume_right = right;
+	ins->dac_volume_left = left;
+
+	for (i = 0; i < DSP_MAX_PCM_CHANNELS; ++i) {
+		if (ins->pcm_channels[i].active &&
+		    !ins->pcm_channels[i].unlinked) {
+			cs46xx_dsp_scb_set_volume (chip,ins->pcm_channels[i].pcm_reader_scb,
+						   right,left);
+			
+		}
+	}
+
+	up(&chip->spos_mutex);
+
+	return 0;
+}
+
+int cs46xx_dsp_set_iec958_volume (cs46xx_t * chip,u16 right,u16 left) {
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+
+	down(&chip->spos_mutex);
+	cs46xx_dsp_scb_set_volume (chip,ins->spdif_in_src,
+				   right,left);
+
+	ins->spdif_input_volume_right = right;
+	ins->spdif_input_volume_left = left;
+	up(&chip->spos_mutex);
 
 	return 0;
 }
diff --exclude=Makefile --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos.h ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h
--- alsa-kernel/pci/cs46xx/dsp_spos.h	Mon Nov  4 19:49:57 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h	Sun Nov 10 17:03:50 2002
@@ -76,6 +76,7 @@
 #define MIX_SAMPLE_BUF2          0x2D00
 #define MIX_SAMPLE_BUF3          0x2E00
 #define MIX_SAMPLE_BUF4          0x2F00
+#define MIX_SAMPLE_BUF5          0x3000
 
 /* Task stack address */
 #define HFG_STACK                0x066A
@@ -127,6 +128,7 @@
 #define SCBfuncEntryPtr      0xA
 #define SRCCorPerGof         0x2
 #define SRCPhiIncr6Int26Frac 0xd
+#define SCBVolumeCtrl        0xe
 
 /* conf */
 #define UseASER1Input 1
@@ -190,6 +192,14 @@
 			(scb->address + SCBsubListPtr) << 2,
 			(scb->sub_list_ptr->address << 0x10) |
 			(scb->next_scb_ptr->address));	
+}
+
+static inline void cs46xx_dsp_scb_set_volume (cs46xx_t * chip,dsp_scb_descriptor_t * scb,
+					      u16 right,u16 left) {
+	unsigned int val = ((0xffff - right) << 16 | (0xffff - left));	
+
+	snd_cs46xx_poke(chip, (scb->address + SCBVolumeCtrl) << 2, val);
+	snd_cs46xx_poke(chip, (scb->address + SCBVolumeCtrl + 1) << 2, val);
 }
 
 #endif /* __DSP_SPOS_H__ */
diff --exclude=Makefile --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c
--- alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Mon Nov  4 19:49:57 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Sun Nov 10 17:55:24 2002
@@ -603,7 +603,7 @@
 		src_buffer_addr << 0x10,
 		0x04000000,
 		{ 
-			0xffff,0xffff,
+			0x8000,0x8000,
 			0xffff,0xffff
 		}
 	};
@@ -658,7 +658,7 @@
 		/* D */ 0,
 		{
 			/* E */ 0x8000,0x8000,
-			/* F */ 0x8000,0x8000
+			/* F */ 0xffff,0xffff
 		}
 	};
 
@@ -825,7 +825,7 @@
 		0x0058,0x0028,      /* Min Delta 7 dwords == 28 bytes */
 		/* : Max delta 25 dwords == 100 bytes */
 		0,hfg_scb_address,  /* Point to HFG task SCB */
-		0,0,				/* Initialize current Delta and Consumer ptr adjustment count */
+		0,0,		    /* Initialize current Delta and Consumer ptr adjustment count */
 		0,                  /* Initialize accumulated Phi to 0 */
 		0,0x2aab,           /* Const 1/3 */
     
@@ -840,13 +840,13 @@
     
 		RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_256, /* Stereo, 256 dword */
 		(asynch_buffer_address) << 0x10,  /* This should be automagically synchronized
-                                             to the producer pointer */
+                                                     to the producer pointer */
     
 		/* There is no correct initial value, it will depend upon the detected
 		   rate etc  */
 		0x18000000,                     /* Phi increment for approx 32k operation */
 		0x8000,0x8000,                  /* Volume controls are unused at this time */
-		0x8000,0x8000
+		0xffff,0xffff
 	};
   
 	scb = cs46xx_dsp_create_generic_scb(chip,scb_name,(u32 *)&asynch_fg_tx_scb,
@@ -1114,7 +1114,13 @@
 		snd_assert(0);
 		break;
 	case DSP_IEC958_CHANNEL:
+		snd_assert (ins->asynch_tx_scb != NULL, return NULL);
 		mixer_scb = ins->asynch_tx_scb;
+		if (ins->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE) {
+			snd_printdd ("IEC958 opened in AC3 mode\n");
+			/*src_scb = ins->asynch_tx_scb;
+			  ins->asynch_tx_scb->ref_count ++;*/
+		}
 		break;
 	default:
 		snd_assert (0);
@@ -1192,7 +1198,9 @@
 			return NULL;
 		}
 
-		cs46xx_dsp_set_src_sample_rate(chip,src_scb,sample_rate);
+		if (pcm_channel_id != DSP_IEC958_CHANNEL ||
+		    !(ins->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE))
+			cs46xx_dsp_set_src_sample_rate(chip,src_scb,sample_rate);
 
 		ins->nsrc_scb ++;
 	} 
@@ -1454,14 +1462,16 @@
 	spin_lock_irqsave(&chip->reg_lock, flags);
 
 	/* mute SCB */
-	snd_cs46xx_poke(chip, (src->address + 0xE) << 2, 0xffffffff);
+	/* cs46xx_dsp_scb_set_volume (chip,src,0,0); */
+
 	snd_cs46xx_poke(chip, (src->address + SRCCorPerGof) << 2,
 	  ((correctionPerSec << 16) & 0xFFFF0000) | (correctionPerGOF & 0xFFFF));
 
 	snd_cs46xx_poke(chip, (src->address + SRCPhiIncr6Int26Frac) << 2, phiIncr);
 
 	/* raise volume */
-	snd_cs46xx_poke(chip, (src->address + 0xE) << 2, 0x80008000);
+	/* cs46xx_dsp_scb_set_volume (chip,src,0x7fff,0x7fff); */
+	
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
@@ -1495,7 +1505,7 @@
 	snd_assert (src->parent_scb_ptr != NULL,  return -EINVAL );
 
 	/* mute SCB */
-	snd_cs46xx_poke(chip, (src->address + 0xE) << 2, 0xffffffff);
+	cs46xx_dsp_scb_set_volume (chip,src,0,0);
 
 	_dsp_unlink_scb (chip,src);
 
@@ -1530,16 +1540,16 @@
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 
-	if ( ! (ins->spdif_status_out & DSP_SDPIF_STATUS_PLAYBACK_OPEN) ) {
+	if ( ! (ins->spdif_status_out & DSP_SPDIF_STATUS_HW_ENABLED) ) {
 		cs46xx_dsp_enable_spdif_hw (chip);
 	}
 
 	/* dont touch anything if SPDIF is open */
-	if ( ins->spdif_status_out & DSP_SDPIF_STATUS_PLAYBACK_OPEN) {
+	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) {
 		/* when cs46xx_iec958_post_close(...) is called it
 		   will call this function if necesary depending on
 		   this bit */
-		ins->spdif_status_out |= DSP_SDPIF_STATUS_OUTPUT_ENABLED;
+		ins->spdif_status_out |= DSP_SPDIF_STATUS_OUTPUT_ENABLED;
 
 		return -EBUSY;
 	}
@@ -1569,7 +1579,7 @@
 	if (!ins->spdif_pcm_input_scb) return -ENOMEM;
 
 	/* monitor state */
-	ins->spdif_status_out |= DSP_SDPIF_STATUS_OUTPUT_ENABLED;
+	ins->spdif_status_out |= DSP_SPDIF_STATUS_OUTPUT_ENABLED;
 
 	return 0;
 }
@@ -1579,8 +1589,8 @@
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 
 	/* dont touch anything if SPDIF is open */
-	if ( ins->spdif_status_out & DSP_SDPIF_STATUS_PLAYBACK_OPEN) {
-		ins->spdif_status_out &= ~DSP_SDPIF_STATUS_OUTPUT_ENABLED;
+	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) {
+		ins->spdif_status_out &= ~DSP_SPDIF_STATUS_OUTPUT_ENABLED;
 		return -EBUSY;
 	}
 
@@ -1600,7 +1610,7 @@
 	_dsp_clear_sample_buffer(chip,SPDIFO_IP_OUTPUT_BUFFER1,256);
 
 	/* monitor state */
-	ins->spdif_status_out  &= ~DSP_SDPIF_STATUS_OUTPUT_ENABLED;
+	ins->spdif_status_out  &= ~DSP_SPDIF_STATUS_OUTPUT_ENABLED;
 
 
 	return 0;
@@ -1610,12 +1620,17 @@
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 
-	if ( ins->spdif_status_out & DSP_SDPIF_STATUS_OUTPUT_ENABLED ) {
+	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED ) {
 		/* remove AsynchFGTxSCB and and PCMSerialInput_II */
 		cs46xx_dsp_disable_spdif_out (chip);
 
 		/* save state */
-		ins->spdif_status_out |= DSP_SDPIF_STATUS_OUTPUT_ENABLED;
+		ins->spdif_status_out |= DSP_SPDIF_STATUS_OUTPUT_ENABLED;
+	}
+	
+	/* if not enabled already */
+	if (ins->spdif_status_out & DSP_SPDIF_STATUS_HW_ENABLED) {
+		cs46xx_dsp_enable_spdif_hw (chip);
 	}
 
 	/* Create the asynch. transfer task  for playback */
@@ -1625,10 +1640,12 @@
 								ins->master_mix_scb,
 								SCB_ON_PARENT_NEXT_SCB);
 
-	/* cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 15) | 
-	   (1 << 14) | (1 << 2) | (1 << 3)); */
 
-	ins->spdif_status_out  |= DSP_SDPIF_STATUS_PLAYBACK_OPEN;
+	if (ins->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE) 
+		/* set left (13), right validity bit (12) , and non-audio(1) and profsional bit (0) */
+		cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 << 12) | (1 << 1) | 1);
+
+	ins->spdif_status_out  |= DSP_SPDIF_STATUS_PLAYBACK_OPEN;
 
 	return 0;
 }
@@ -1639,16 +1656,17 @@
 
 	snd_assert (ins->asynch_tx_scb != NULL, return -EINVAL);
 
-	ins->spdif_status_out  &= ~DSP_SDPIF_STATUS_PLAYBACK_OPEN;
+	ins->spdif_status_out  &= ~DSP_SPDIF_STATUS_PLAYBACK_OPEN;
 
-	/*cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 << 12));*/
+	/* restore settings */
+	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 << 12));
 	
 	/* deallocate stuff */
 	cs46xx_dsp_remove_scb (chip,ins->asynch_tx_scb);
 	ins->asynch_tx_scb = NULL;
 
 	/* restore state */
-	if ( ins->spdif_status_out & DSP_SDPIF_STATUS_OUTPUT_ENABLED ) {
+	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED ) {
 		cs46xx_dsp_enable_spdif_out (chip);
 	}
 	

--------------070609020008030804060500--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
