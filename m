From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [PATCH] cs46xx some few corrections
Date: Tue, 10 Dec 2002 09:09:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF5A135.4090008@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060807040602070908070708"
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
--------------060807040602070908070708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

If the SPDIF input worked with rc6 it should work now with this patch, 
the SPDIF input "Source Rate Converter"-SCB
was muted all the time and that should fixed by now.
I discovered that AC3 almost works but get very easily out of sync in 
some how (got no solution for this yet)
Restarting the application about ~ 10 times, eg. with xine press 
PLAY-STOP PLAY-STOP ... until you get
sound.
There was/is actually a ring buffer problem in the cs46xx driver giving 
this kind of outputs (see my previous mail):
"Dec 8 13:40:16 cactus kernel: ALSA ../alsa-kernel/core/pcm_lib.c:176: 
BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x200"
That should actually be fixed this patch, I hope it's correct.

Sumary of changes:
- Some volume bug fixes
- SPDIF input fix.
- Clear sample buffer after closing IEC958 stream.
- Ring buffer fix (see my previous mail)
- Some other misses, corrections ....

/Benny

--------------060807040602070908070708
Content-Type: text/plain;
 name="cs46xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx.patch"

diff --exclude=Makefile --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Tue Dec 10 01:34:34 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Tue Dec 10 01:09:48 2002
@@ -849,7 +849,7 @@
 	cpcm->hw_io = ptr;
 	cpcm->hw_ready -= bytes;
 	cpcm->sw_io += bytes;
-	if (cpcm->sw_io > cpcm->sw_bufsize)
+	if (cpcm->sw_io >= cpcm->sw_bufsize)
 		cpcm->sw_io -= cpcm->sw_bufsize;
 	snd_cs46xx_playback_transfer(substream, 0);
 	return cpcm->sw_io >> cpcm->shift;
@@ -874,7 +874,7 @@
 	chip->capt.hw_io = ptr;
 	chip->capt.hw_ready += bytes;
 	chip->capt.sw_io += bytes;
-	if (chip->capt.sw_io > chip->capt.sw_bufsize)
+	if (chip->capt.sw_io >= chip->capt.sw_bufsize)
 		chip->capt.sw_io -= chip->capt.sw_bufsize;
 	snd_cs46xx_capture_transfer(substream, 0);
 	return chip->capt.sw_io >> chip->capt.shift;
@@ -1914,8 +1914,8 @@
 {
 	cs46xx_t *chip = snd_kcontrol_chip(kcontrol);
 
-	ucontrol->value.integer.value[0] = chip->dsp_spos_instance->spdif_input_volume_right;
-	ucontrol->value.integer.value[1] = chip->dsp_spos_instance->spdif_input_volume_left;
+	ucontrol->value.integer.value[0] = chip->dsp_spos_instance->spdif_input_volume_left;
+	ucontrol->value.integer.value[1] = chip->dsp_spos_instance->spdif_input_volume_right;
 	return 0;
 }
 
@@ -1924,8 +1924,8 @@
 	cs46xx_t *chip = snd_kcontrol_chip(kcontrol);
 	int change = 0;
 
-	if (chip->dsp_spos_instance->spdif_input_volume_right != ucontrol->value.integer.value[0] ||
-	    chip->dsp_spos_instance->spdif_input_volume_left != ucontrol->value.integer.value[1]) {
+	if (chip->dsp_spos_instance->spdif_input_volume_left  != ucontrol->value.integer.value[0] ||
+	    chip->dsp_spos_instance->spdif_input_volume_right!= ucontrol->value.integer.value[1]) {
 		cs46xx_dsp_set_iec958_volume (chip,
 					      ucontrol->value.integer.value[0],
 					      ucontrol->value.integer.value[1]);
@@ -2206,6 +2206,7 @@
 }
 
 #endif /* CONFIG_SND_CS46XX_NEW_DSP */
+
 
 #ifdef CONFIG_SND_CS46XX_DEBUG_GPIO
 static int snd_cs46xx_egpio_select_info(snd_kcontrol_t *kcontrol, 
diff --exclude=Makefile --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c
--- alsa-kernel/pci/cs46xx/dsp_spos.c	Tue Dec 10 01:34:34 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c	Tue Dec 10 01:10:35 2002
@@ -705,7 +705,7 @@
 
 		snd_iprintf(buffer,"%08X ",readl(dst + i));
 	}
-
+#if 0
 	snd_iprintf(buffer,"\nWRITE_BACK_BUF1: \n");
 	col = 0;
 	for (i = WRITE_BACK_BUF1;i < WRITE_BACK_BUF1 + 0x40; i += sizeof(u32),col ++) {
@@ -720,7 +720,22 @@
 
 		snd_iprintf(buffer,"%08X ",readl(dst + i));
 	}
+#endif
+
+	snd_iprintf(buffer,"\nSPDIFI_IP_OUTPUT_BUFFER1: \n");
+	col = 0;
+	for (i = SPDIFI_IP_OUTPUT_BUFFER1;i < SPDIFI_IP_OUTPUT_BUFFER1 + 0x80; i += sizeof(u32),col ++) {
+		if (col == 4) {
+			snd_iprintf(buffer,"\n");
+			col = 0;
+		}
 
+		if (col == 0) {
+			snd_iprintf(buffer, "%04X ",i);
+		}
+		
+		snd_iprintf(buffer,"%08X ",readl(dst + i));
+	}
 	snd_iprintf(buffer,"\n");
 }
 
@@ -1597,6 +1612,9 @@
 	/* reset FIFO ptr */
 	cs46xx_poke_via_dsp (chip,SP_SPDIN_FIFOPTR, 0x0);
 	cs46xx_src_link(chip,ins->spdif_in_src);
+
+	/* unmute SRC volume */
+	cs46xx_dsp_scb_set_volume (chip,ins->spdif_in_src,0x7fff,0x7fff);
 
 	spin_unlock_irq(&chip->reg_lock);
 
diff --exclude=Makefile --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos.h ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h
--- alsa-kernel/pci/cs46xx/dsp_spos.h	Sun Dec  8 13:21:55 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h	Tue Dec 10 00:42:21 2002
@@ -197,7 +197,7 @@
 		((val & 0x10) >> 1) |
 		((val & 0x20) >> 3) |
 		((val & 0x40) >> 5) |
-		((val & 0x80) >> 6);
+		((val & 0x80) >> 7);
 
 	return wrapped;
 
diff --exclude=Makefile --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c
--- alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Tue Dec 10 01:34:35 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Tue Dec 10 00:58:33 2002
@@ -1270,8 +1270,8 @@
 	}
 
 	if (pcm_channel_id == DSP_IEC958_CHANNEL && sample_rate == 48000) {
-		snd_assert (ins->spdif_pcm_input_scb = NULL);
-
+		snd_assert (ins->spdif_pcm_input_scb == NULL);
+		
 		/* a hack to make the skip the SRC and pass the stream 
 		   directly to the SPDIF task */
 		ins->spdif_pcm_input_scb = 
@@ -1281,7 +1281,7 @@
 							       ins->asynch_tx_scb,
 							       SCB_ON_PARENT_SUBLIST_SCB);		
 	}
-
+	
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	ins->pcm_channels[pcm_index].sample_rate = sample_rate;
 	ins->pcm_channels[pcm_index].pcm_reader_scb = pcm_scb;
@@ -1664,6 +1664,9 @@
 
 	cs46xx_dsp_remove_scb (chip,ins->asynch_tx_scb);
 	ins->asynch_tx_scb = NULL;
+
+	/* clear buffer to prevent any undesired noise */
+	_dsp_clear_sample_buffer(chip,SPDIFO_IP_OUTPUT_BUFFER1,256);
 
 	/* restore state */
 

--------------060807040602070908070708--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
