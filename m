From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [PATCH] cs46xx, independant rear PCM channel, IEC958 PCM channel
Date: Tue, 29 Oct 2002 08:55:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DBE3EDA.80900@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090804060704000507060108"
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
--------------090804060704000507060108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

First, this stuff is still very experimental, it should work very well 
with a
Game Theater XP course that's card I've got and the only cs46xx sound 
card I can
test with.

I've got some reports that stuffs dont seems to work very well with
the Santa Cruz card, course for some unknown reason the driver dont
manage to raise GPIO 7 and 9 on the secondary codec that
enables the rear output, you probably will see the message
"cs46xx_setup_eapd_slot() Failure to write the GPIO pins for
slot 12. " and that will probably freeze you computer
for a while too.

In this patch, for the Santa Cruz the amplifier and the GPIO's are
setup on init, then not touched anymore, like it's done for the
Hercules XP card with hope and a little of luck maybe that
works better.

Finally, this patch contains the following changes:
- Rear PCM channel
- IEC958 PCM channel, in hope that I'm close to get raw AC3 working soon
- Turn on Amplifier and setup EGPIO for Santa Cruz card on init
- Cleanup's in voyectra_setup_eapd_slot(...) (hope it's not broken ...)

PS. If you have time to help testing this patch, dont forget to turn on
all debuging stuff, that always helps to find bugs ...

/Benny


--------------090804060704000507060108
Content-Type: text/plain;
 name="cs46xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx.patch"

diff --exclude=CVS -Naur alsa-kernel/include/cs46xx.h ../cvs/alsa-kernel/include/cs46xx.h
--- alsa-kernel/include/cs46xx.h	Fri Aug 23 17:51:18 2002
+++ ../cvs/alsa-kernel/include/cs46xx.h	Tue Oct 29 00:50:21 2002
@@ -196,80 +196,6 @@
 #define BA1_OMNI_MEM                            0x000E0000
 
 
-
-
-/*
- * The following define the offsets of the AC97 shadow registers, which appear
- * as a virtual extension to the base address register zero memory range.
- */
-#define AC97_REG_OFFSET_MASK                    0x0000007EL
-#define AC97_CODEC_NUMBER_MASK                  0x00003000L
-
-#define BA0_AC97_RESET                          0x00001000L
-#define BA0_AC97_MASTER_VOLUME                  0x00001002L
-#define BA0_AC97_HEADPHONE_VOLUME               0x00001004L
-#define BA0_AC97_MASTER_VOLUME_MONO             0x00001006L
-#define BA0_AC97_MASTER_TONE                    0x00001008L
-#define BA0_AC97_PC_BEEP_VOLUME                 0x0000100AL
-#define BA0_AC97_PHONE_VOLUME                   0x0000100CL
-#define BA0_AC97_MIC_VOLUME                     0x0000100EL
-#define BA0_AC97_LINE_IN_VOLUME                 0x00001010L
-#define BA0_AC97_CD_VOLUME                      0x00001012L
-#define BA0_AC97_VIDEO_VOLUME                   0x00001014L
-#define BA0_AC97_AUX_VOLUME                     0x00001016L
-#define BA0_AC97_PCM_OUT_VOLUME                 0x00001018L
-#define BA0_AC97_RECORD_SELECT                  0x0000101AL
-#define BA0_AC97_RECORD_GAIN                    0x0000101CL
-#define BA0_AC97_RECORD_GAIN_MIC                0x0000101EL
-#define BA0_AC97_GENERAL_PURPOSE                0x00001020L
-#define BA0_AC97_3D_CONTROL                     0x00001022L
-#define BA0_AC97_MODEM_RATE                     0x00001024L
-#define BA0_AC97_POWERDOWN                      0x00001026L
-#define BA0_AC97_EXT_AUDIO_ID                   0x00001028L
-#define BA0_AC97_EXT_AUDIO_POWER                0x0000102AL
-#define BA0_AC97_PCM_FRONT_DAC_RATE             0x0000102CL
-#define BA0_AC97_PCM_SURR_DAC_RATE              0x0000102EL
-#define BA0_AC97_PCM_LFE_DAC_RATE               0x00001030L
-#define BA0_AC97_PCM_LR_ADC_RATE                0x00001032L
-#define BA0_AC97_MIC_ADC_RATE                   0x00001034L
-#define BA0_AC97_6CH_VOL_C_LFE                  0x00001036L
-#define BA0_AC97_6CH_VOL_SURROUND               0x00001038L
-#define BA0_AC97_RESERVED_3A                    0x0000103AL
-#define BA0_AC97_EXT_MODEM_ID                   0x0000103CL
-#define BA0_AC97_EXT_MODEM_POWER                0x0000103EL
-#define BA0_AC97_LINE1_CODEC_RATE               0x00001040L
-#define BA0_AC97_LINE2_CODEC_RATE               0x00001042L
-#define BA0_AC97_HANDSET_CODEC_RATE             0x00001044L
-#define BA0_AC97_LINE1_CODEC_LEVEL              0x00001046L
-#define BA0_AC97_LINE2_CODEC_LEVEL              0x00001048L
-#define BA0_AC97_HANDSET_CODEC_LEVEL            0x0000104AL
-#define BA0_AC97_GPIO_PIN_CONFIG                0x0000104CL
-#define BA0_AC97_GPIO_PIN_TYPE                  0x0000104EL
-#define BA0_AC97_GPIO_PIN_STICKY                0x00001050L
-#define BA0_AC97_GPIO_PIN_WAKEUP                0x00001052L
-#define BA0_AC97_GPIO_PIN_STATUS                0x00001054L
-#define BA0_AC97_MISC_MODEM_AFE_STAT            0x00001056L
-#define BA0_AC97_RESERVED_58                    0x00001058L
-#define BA0_AC97_CRYSTAL_REV_N_FAB_ID           0x0000105AL
-#define BA0_AC97_TEST_AND_MISC_CTRL             0x0000105CL
-#define BA0_AC97_AC_MODE                        0x0000105EL
-#define BA0_AC97_MISC_CRYSTAL_CONTROL           0x00001060L
-#define BA0_AC97_LINE1_HYPRID_CTRL              0x00001062L
-#define BA0_AC97_VENDOR_RESERVED_64             0x00001064L
-#define BA0_AC97_VENDOR_RESERVED_66             0x00001066L
-#define BA0_AC97_SPDIF_CONTROL                  0x00001068L
-#define BA0_AC97_VENDOR_RESERVED_6A             0x0000106AL
-#define BA0_AC97_VENDOR_RESERVED_6C             0x0000106CL
-#define BA0_AC97_VENDOR_RESERVED_6E             0x0000106EL
-#define BA0_AC97_VENDOR_RESERVED_70             0x00001070L
-#define BA0_AC97_VENDOR_RESERVED_72             0x00001072L
-#define BA0_AC97_VENDOR_RESERVED_74             0x00001074L
-#define BA0_AC97_CAL_ADDRESS                    0x00001076L
-#define BA0_AC97_CAL_DATA                       0x00001078L
-#define BA0_AC97_VENDOR_RESERVED_7A             0x0000107AL
-#define BA0_AC97_VENDOR_ID1                     0x0000107CL
-#define BA0_AC97_VENDOR_ID2                     0x0000107EL
-
 /*
  *  The following defines are for the flags in the host interrupt status
  *  register.
@@ -1790,6 +1716,7 @@
 	struct pci_dev *pci;
 	snd_card_t *card;
 	snd_pcm_t *pcm;
+
 	snd_rawmidi_t *rmidi;
 	snd_rawmidi_substream_t *midi_input;
 	snd_rawmidi_substream_t *midi_output;
@@ -1814,12 +1741,15 @@
 	struct pm_dev *pm_dev;
 #endif
 #ifdef CONFIG_SND_CS46XX_DEBUG_GPIO
-  int current_gpio;
+    int current_gpio;
 #endif
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	struct semaphore spos_mutex;
 
 	dsp_spos_instance_t * dsp_spos_instance;
+
+	snd_pcm_t *pcm_rear;
+	snd_pcm_t *pcm_iec958;
 #else /* for compatibility */
 	cs46xx_pcm_t *playback_pcm;
 	unsigned int play_ctl;
@@ -1832,6 +1762,8 @@
 		      cs46xx_t **rcodec);
 
 int snd_cs46xx_pcm(cs46xx_t *chip, int device, snd_pcm_t **rpcm);
+int snd_cs46xx_pcm_rear(cs46xx_t *chip, int device, snd_pcm_t **rpcm);
+int snd_cs46xx_pcm_iec958(cs46xx_t *chip, int device, snd_pcm_t **rpcm);
 int snd_cs46xx_mixer(cs46xx_t *chip);
 int snd_cs46xx_midi(cs46xx_t *chip, int device, snd_rawmidi_t **rmidi);
 void snd_cs46xx_gameport(cs46xx_t *chip);
diff --exclude=CVS -Naur alsa-kernel/include/cs46xx_dsp_spos.h ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h
--- alsa-kernel/include/cs46xx_dsp_spos.h	Fri Aug 23 17:51:18 2002
+++ ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h	Mon Oct 21 23:16:51 2002
@@ -54,6 +54,12 @@
 #define DSP_MAX_PCM_CHANNELS 32
 #define DSP_MAX_SRC_NR       6
 
+#define DSP_PCM_MAIN_CHANNEL    1
+#define DSP_PCM_REAR_CHANNEL    2
+#define DSP_PCM_CENTER_CHANNEL  3
+#define DSP_PCM_LFE_CHANNEL     4
+#define DSP_IEC958_CHANNEL      5
+
 struct _dsp_module_desc_t;
 
 typedef struct _symbol_entry_t {
@@ -129,6 +135,8 @@
 	u32 unlinked;
 	dsp_scb_descriptor_t * pcm_reader_scb;
 	dsp_scb_descriptor_t * src_scb;
+	dsp_scb_descriptor_t * mixer_scb;
+    int pcm_channel_id;
 
 	void * private_data;
 } pcm_channel_descriptor_t;
@@ -141,8 +149,12 @@
 
 	segment_desc_t code;
 
-	/* PCM playback */
+	/* Main PCM playback mixer */
 	dsp_scb_descriptor_t * master_mix_scb;
+
+    /* Rear PCM playback mixer */
+    dsp_scb_descriptor_t * rear_mix_scb;
+
 	int npcm_channels;
 	int nsrc_scb;
 	pcm_channel_descriptor_t pcm_channels[DSP_MAX_PCM_CHANNELS];
@@ -190,6 +202,12 @@
 
 	/* reference snooper */
 	dsp_scb_descriptor_t * ref_snoop_scb;
+
+	/* SPDIF output  PCM reference  */
+	dsp_scb_descriptor_t * spdif_pcm_input_scb;
+
+    /* asynch TX task */
+    dsp_scb_descriptor_t * asynch_tx_scb;
 
 	/* record sources */
 	dsp_scb_descriptor_t * pcm_input;
diff --exclude=CVS -Naur alsa-kernel/pci/ac97/ac97_codec.c ../cvs/alsa-kernel/pci/ac97/ac97_codec.c
--- alsa-kernel/pci/ac97/ac97_codec.c	Wed Sep 18 12:58:33 2002
+++ ../cvs/alsa-kernel/pci/ac97/ac97_codec.c	Sun Oct 20 19:15:04 2002
@@ -966,7 +966,7 @@
 		reg = AC97_CENTER_LFE_MASTER;
 		mask = 0x0080;
 		break;
-	case AC97_SURROUND_MASTER:
+	case AC97_SURROUND_MASTER:      
 		if ((ac97->ext_id & 0x80) == 0)
 			return 0;
 		break;
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx.c
--- alsa-kernel/pci/cs46xx/cs46xx.c	Sun Oct 27 11:16:26 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx.c	Sun Oct 27 11:11:42 2002
@@ -110,6 +110,14 @@
 		snd_card_free(card);
 		return err;
 	}
+    if ((err = snd_cs46xx_pcm_rear(chip,1, NULL)) < 0) {
+        snd_card_free(card);
+        return err;
+    }
+    if ((err = snd_cs46xx_pcm_iec958(chip,2,NULL)) < 0) {
+        snd_card_free(card);
+        return err;
+    }
 	if ((err = snd_cs46xx_mixer(chip)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -132,6 +140,7 @@
 		snd_card_free(card);
 		return err;
 	}
+
 	pci_set_drvdata(pci, chip);
 	dev++;
 	return 0;
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Mon Sep 30 19:50:51 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Tue Oct 29 01:38:55 2002
@@ -15,8 +15,8 @@
  *  TODO:
  *    - Secondary CODEC on some soundcards
  *    - SPDIF input support for other sample rates then 48khz
- *    - Independent PCM channels for rear output
  *    - Posibility to mix the SPDIF output with analog sources.
+ *    - PCM channels for Center and LFE on secondary codec
  *
  *  NOTE: with CONFIG_SND_CS46XX_NEW_DSP unset uses old DSP image (which
  *        is default configuration), no SPDIF, no secondary codec, no
@@ -269,23 +269,37 @@
 				   unsigned short val)
 {
 	cs46xx_t *chip = snd_magic_cast(cs46xx_t, ac97->private_data, return);
+#ifndef CONFIG_SND_CS46XX_NEW_DSP
 	int val2 = 0;
+#endif
 	int codec_index = -1;
 
 	/* UGGLY: nr_ac97_codecs == 0 primery codec detection is in progress */
 	if (ac97 == chip->ac97[CS46XX_PRIMARY_CODEC_INDEX] || chip->nr_ac97_codecs == 0)
 		codec_index = CS46XX_PRIMARY_CODEC_INDEX;
-	/* UGGLY: nr_ac97_codecs == 0 secondary codec detection is in progress */
+	/* UGGLY: nr_ac97_codecs == 1 secondary codec detection is in progress */
 	else  if (ac97 == chip->ac97[CS46XX_SECONDARY_CODEC_INDEX] || chip->nr_ac97_codecs == 1)
 		codec_index = CS46XX_SECONDARY_CODEC_INDEX;
 	else
 		snd_assert(0,return);
+
+#ifndef CONFIG_SND_CS46XX_NEW_DSP
 	chip->active_ctrl(chip, 1);
+
 	if (reg == AC97_CD)
 		val2 = snd_cs46xx_codec_read(chip, AC97_CD, codec_index);
+#endif
 
 	snd_cs46xx_codec_write(chip, reg, val, codec_index);
 
+#ifndef CONFIG_SND_CS46XX_NEW_DSP
+    /* Benny: I've not found *one* soundcard where
+       this code below could do any sense, and
+       with the HW mixering it's anyway broken, with
+       more then 1 PCM stream the amplifier will not
+       be turned off by unmuting CD channel. So just
+       lets skip it.
+    */
 	
 	/*
 	 *	Adjust power if the mixer is selected/deselected according
@@ -323,6 +337,7 @@
 	}
 
 	chip->active_ctrl(chip, -1);
+#endif
 }
 
 
@@ -994,7 +1009,23 @@
 		runtime->dma_area = cpcm->hw_area;
 		runtime->dma_addr = cpcm->hw_addr;
 		runtime->dma_bytes = cpcm->hw_size;
-		substream->ops = &snd_cs46xx_playback_ops;
+
+        snd_assert (cpcm->pcm_channel != NULL);
+
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+        if (cpcm->pcm_channel->pcm_channel_id == DSP_PCM_MAIN_CHANNEL) {
+          substream->ops = &snd_cs46xx_playback_ops;
+        } else if (cpcm->pcm_channel->pcm_channel_id == DSP_PCM_REAR_CHANNEL) {
+          substream->ops = &snd_cs46xx_playback_rear_ops;
+        } else if (cpcm->pcm_channel->pcm_channel_id == DSP_IEC958_CHANNEL) {
+          substream->ops = &snd_cs46xx_playback_iec958_ops;
+        } else {
+          snd_assert(0);
+        }
+#else
+        substream->ops = &snd_cs46xx_playback_ops;
+#endif
+
 	} else {
 		if (runtime->dma_area == cpcm->hw_area) {
 			runtime->dma_area = NULL;
@@ -1003,7 +1034,23 @@
 		}
 		if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
 			return err;
-		substream->ops = &snd_cs46xx_playback_indirect_ops;
+
+        snd_assert (cpcm->pcm_channel != NULL);
+
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+        if (cpcm->pcm_channel->pcm_channel_id == DSP_PCM_MAIN_CHANNEL) {
+          substream->ops = &snd_cs46xx_playback_indirect_ops;
+        } else if (cpcm->pcm_channel->pcm_channel_id == DSP_PCM_REAR_CHANNEL) {
+          substream->ops = &snd_cs46xx_playback_indirect_rear_ops;
+        } else if (cpcm->pcm_channel->pcm_channel_id == DSP_IEC958_CHANNEL) {
+          substream->ops = &snd_cs46xx_playback_indirect_iec958_ops;
+        } else {
+          snd_assert(0);
+        }
+#else
+        substream->ops = &snd_cs46xx_playback_indirect_ops;
+#endif
+
 	}
 
 	return 0;
@@ -1054,7 +1101,9 @@
 		int unlinked = cpcm->pcm_channel->unlinked;
 		cs46xx_dsp_destroy_pcm_channel (chip,cpcm->pcm_channel);
 
-		if ( (cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, runtime->rate, cpcm, cpcm->hw_addr)) == NULL) {
+		if ( (cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, runtime->rate, cpcm, 
+                                                                 cpcm->hw_addr,
+                                                                 cpcm->pcm_channel->pcm_channel_id)) == NULL) {
 			snd_printk(KERN_ERR "cs46xx: failed to re-create virtual PCM channel\n");
 			up (&chip->spos_mutex);
 			return -ENXIO;
@@ -1320,7 +1369,7 @@
 		snd_magic_kfree(cpcm);
 }
 
-static int snd_cs46xx_playback_open(snd_pcm_substream_t * substream)
+static int _cs46xx_playback_open_channel (snd_pcm_substream_t * substream,int pcm_channel_id)
 {
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
 	cs46xx_pcm_t * cpcm;
@@ -1342,7 +1391,7 @@
 	cpcm->substream = substream;
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	down (&chip->spos_mutex);
-	cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, runtime->rate, cpcm, cpcm->hw_addr);
+	cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, runtime->rate, cpcm, cpcm->hw_addr,pcm_channel_id);
 
 	if (cpcm->pcm_channel == NULL) {
 		snd_printk(KERN_ERR "cs46xx: failed to create virtual PCM channel\n");
@@ -1365,6 +1414,40 @@
 	return 0;
 }
 
+static int snd_cs46xx_playback_open(snd_pcm_substream_t * substream) {
+  snd_printd("open front channel\n");
+  return _cs46xx_playback_open_channel(substream,DSP_PCM_MAIN_CHANNEL);
+}
+
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+static int snd_cs46xx_playback_open_rear(snd_pcm_substream_t * substream) {
+  snd_printd("open rear channel\n");
+
+  return _cs46xx_playback_open_channel(substream,DSP_PCM_REAR_CHANNEL);
+}
+
+static int snd_cs46xx_playback_open_iec958(snd_pcm_substream_t * substream) {
+  cs46xx_t *chip = snd_pcm_substream_chip(substream);
+
+  snd_printd("open raw iec958 channel\n");
+  cs46xx_iec958_pre_open (chip);
+
+  return _cs46xx_playback_open_channel(substream,DSP_IEC958_CHANNEL);
+}
+
+static int snd_cs46xx_playback_close(snd_pcm_substream_t * substream);
+
+static int snd_cs46xx_playback_close_iec958(snd_pcm_substream_t * substream) {
+  int err;
+  cs46xx_t *chip = snd_pcm_substream_chip(substream);
+  
+  err = snd_cs46xx_playback_close(substream);
+  cs46xx_iec958_post_close (chip);
+
+  return err;
+}
+#endif
+
 static int snd_cs46xx_capture_open(snd_pcm_substream_t * substream)
 {
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
@@ -1422,11 +1505,60 @@
 	return 0;
 }
 
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+snd_pcm_ops_t snd_cs46xx_playback_rear_ops = {
+	.open =			snd_cs46xx_playback_open_rear,
+	.close =		snd_cs46xx_playback_close,
+	.ioctl =		snd_pcm_lib_ioctl,
+	.hw_params =	snd_cs46xx_playback_hw_params,
+	.hw_free =		snd_cs46xx_playback_hw_free,
+	.prepare =		snd_cs46xx_playback_prepare,
+	.trigger =		snd_cs46xx_playback_trigger,
+	.pointer =		snd_cs46xx_playback_direct_pointer,
+};
+
+snd_pcm_ops_t snd_cs46xx_playback_indirect_rear_ops = {
+	.open =			snd_cs46xx_playback_open_rear,
+	.close =		snd_cs46xx_playback_close,
+	.ioctl =		snd_pcm_lib_ioctl,
+	.hw_params =		snd_cs46xx_playback_hw_params,
+	.hw_free =		snd_cs46xx_playback_hw_free,
+	.prepare =		snd_cs46xx_playback_prepare,
+	.trigger =		snd_cs46xx_playback_trigger,
+	.copy =			snd_cs46xx_playback_copy,
+	.pointer =		snd_cs46xx_playback_indirect_pointer,
+};
+
+snd_pcm_ops_t snd_cs46xx_playback_iec958_ops = {
+	.open =			snd_cs46xx_playback_open_iec958,
+	.close =		snd_cs46xx_playback_close_iec958,
+	.ioctl =		snd_pcm_lib_ioctl,
+	.hw_params =	snd_cs46xx_playback_hw_params,
+	.hw_free =		snd_cs46xx_playback_hw_free,
+	.prepare =		snd_cs46xx_playback_prepare,
+	.trigger =		snd_cs46xx_playback_trigger,
+	.pointer =		snd_cs46xx_playback_direct_pointer,
+};
+
+snd_pcm_ops_t snd_cs46xx_playback_indirect_iec958_ops = {
+	.open =			snd_cs46xx_playback_open_iec958,
+	.close =		snd_cs46xx_playback_close_iec958,
+	.ioctl =		snd_pcm_lib_ioctl,
+	.hw_params =	snd_cs46xx_playback_hw_params,
+	.hw_free =		snd_cs46xx_playback_hw_free,
+	.prepare =		snd_cs46xx_playback_prepare,
+	.trigger =		snd_cs46xx_playback_trigger,
+	.copy =			snd_cs46xx_playback_copy,
+	.pointer =		snd_cs46xx_playback_indirect_pointer,
+};
+
+#endif
+
 snd_pcm_ops_t snd_cs46xx_playback_ops = {
 	.open =			snd_cs46xx_playback_open,
 	.close =		snd_cs46xx_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
-	.hw_params =		snd_cs46xx_playback_hw_params,
+	.hw_params =	snd_cs46xx_playback_hw_params,
 	.hw_free =		snd_cs46xx_playback_hw_free,
 	.prepare =		snd_cs46xx_playback_prepare,
 	.trigger =		snd_cs46xx_playback_trigger,
@@ -1475,6 +1607,20 @@
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
+static void snd_cs46xx_pcm_rear_free(snd_pcm_t *pcm)
+{
+	cs46xx_t *chip = snd_magic_cast(cs46xx_t, pcm->private_data, return);
+	chip->pcm_rear = NULL;
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static void snd_cs46xx_pcm_iec958_free(snd_pcm_t *pcm)
+{
+	cs46xx_t *chip = snd_magic_cast(cs46xx_t, pcm->private_data, return);
+	chip->pcm_iec958 = NULL;
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 #define MAX_PLAYBACK_CHANNELS	(DSP_MAX_PCM_CHANNELS - 1)
 #else
@@ -1490,6 +1636,7 @@
 		*rpcm = NULL;
 	if ((err = snd_pcm_new(chip->card, "CS46xx", device, MAX_PLAYBACK_CHANNELS, 1, &pcm)) < 0)
 		return err;
+
 	pcm->private_data = chip;
 	pcm->private_free = snd_cs46xx_pcm_free;
 
@@ -1505,13 +1652,72 @@
 
 	if (rpcm)
 		*rpcm = pcm;
+
+	return 0;
+}
+
+
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+int __devinit snd_cs46xx_pcm_rear(cs46xx_t *chip, int device, snd_pcm_t ** rpcm) {
+	snd_pcm_t *pcm;
+	int err;
+
+	if (rpcm)
+		*rpcm = NULL;
+
+	if ((err = snd_pcm_new(chip->card, "CS46xx - Rear", device, MAX_PLAYBACK_CHANNELS, 0, &pcm)) < 0)
+		return err;
+
+	pcm->private_data = chip;
+	pcm->private_free = snd_cs46xx_pcm_rear_free;
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_cs46xx_playback_rear_ops);
+
+	/* global setup */
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "CS46xx - Rear");
+	chip->pcm_rear = pcm;
+
+	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
+
+	if (rpcm)
+		*rpcm = pcm;
+
 	return 0;
 }
 
+int __devinit snd_cs46xx_pcm_iec958(cs46xx_t *chip, int device, snd_pcm_t ** rpcm) {
+	snd_pcm_t *pcm;
+	int err;
+
+	if (rpcm)
+		*rpcm = NULL;
+
+	if ((err = snd_pcm_new(chip->card, "CS46xx - IEC958", device, 1, 0, &pcm)) < 0)
+		return err;
+
+	pcm->private_data = chip;
+	pcm->private_free = snd_cs46xx_pcm_iec958_free;
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_cs46xx_playback_iec958_ops);
+
+	/* global setup */
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "CS46xx - IEC958");
+	chip->pcm_rear = pcm;
+
+	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
+
+	if (rpcm)
+		*rpcm = pcm;
+
+    return 0;
+}
+#endif
+
 /*
  *  Mixer routines
  */
-
 static void snd_cs46xx_mixer_free_ac97(ac97_t *ac97)
 {
 	cs46xx_t *chip = snd_magic_cast(cs46xx_t, ac97->private_data, return);
@@ -1927,6 +2133,47 @@
 	.put = snd_herc_spdif_select_put,
 },
 };
+
+
+static void snd_cs46xx_sec_codec_reset (ac97_t * ac97) {
+  signed long end_time;
+  int err;
+
+  /* reset to defaults */
+  snd_ac97_write(ac97, AC97_RESET, 0);	
+
+  /* set codec in extended mode */
+  snd_cs46xx_ac97_write(ac97,AC97_CSR_ACMODE,0x3);
+
+  udelay(50);
+
+  /* it's necessary to wait awhile until registers are accessible after RESET */
+  /* because the PCM or MASTER volume registers can be modified, */
+  /* the REC_GAIN register is used for tests */
+  end_time = jiffies + HZ;
+  do {
+    unsigned short ext_mid;
+    
+    /* use preliminary reads to settle the communication */
+    snd_ac97_read(ac97, AC97_RESET);
+    snd_ac97_read(ac97, AC97_VENDOR_ID1);
+    snd_ac97_read(ac97, AC97_VENDOR_ID2);
+    /* modem? */
+    ext_mid = snd_ac97_read(ac97, AC97_EXTENDED_MID);
+    if (ext_mid != 0xffff && (ext_mid & 1) != 0)
+      return;
+
+    /* test if we can write to the record gain volume register */
+    snd_ac97_write_cache(ac97, AC97_REC_GAIN, 0x8a05);
+    if ((err = snd_ac97_read(ac97, AC97_REC_GAIN)) == 0x8a05)
+      return;
+
+    set_current_state(TASK_UNINTERRUPTIBLE);
+    schedule_timeout(HZ/100);
+  } while (time_after_eq(end_time, jiffies));
+
+  snd_printk("CS46xx secondary codec dont respond!\n");  
+}
 #endif
 
 int __devinit snd_cs46xx_mixer(cs46xx_t *chip)
@@ -2001,11 +2248,16 @@
 	/* well, one codec only ... */
 	goto _end;
  _ok2:
+    /* set secondary codec in extended mode */
+
+    /* use custom reset to set secondary codec in
+       extended mode */
+    ac97.reset = snd_cs46xx_sec_codec_reset;
+
 	if ((err = snd_ac97_mixer(card, &ac97, &chip->ac97[CS46XX_SECONDARY_CODEC_INDEX])) < 0)
 		return err;
 	chip->nr_ac97_codecs = 2;
-    
-	/* add cs4630 mixer controls */
+
  _end:
 
 	/* dosoundcard specific mixer setup */
@@ -2016,6 +2268,7 @@
     
 #endif /* CONFIG_SND_CS46XX_NEW_DSP */
 
+	/* add cs4630 mixer controls */
 	for (idx = 0; idx < sizeof(snd_cs46xx_controls) / 
 		     sizeof(snd_cs46xx_controls[0]); idx++) {
 		snd_kcontrol_t *kctl;
@@ -2831,40 +3084,44 @@
 	}
 
 	modem_power = snd_cs46xx_codec_read (chip, 
-					     BA0_AC97_EXT_MODEM_POWER,
+					     AC97_EXTENDED_MSTATUS,
 					     CS46XX_SECONDARY_CODEC_INDEX);
 	modem_power &=0xFEFF;
 
 	snd_cs46xx_codec_write(chip, 
-			       BA0_AC97_EXT_MODEM_POWER, modem_power,
+			       AC97_EXTENDED_MSTATUS, modem_power,
 			       CS46XX_SECONDARY_CODEC_INDEX);
 
 	/*
 	 * Set GPIO pin's 7 and 8 so that they are configured for output.
 	 */
 	pin_config = snd_cs46xx_codec_read (chip, 
-					    BA0_AC97_GPIO_PIN_CONFIG,
+					    AC97_GPIO_CFG,
 					    CS46XX_SECONDARY_CODEC_INDEX);
 	pin_config &=0x27F;
 
 	snd_cs46xx_codec_write(chip, 
-			       BA0_AC97_GPIO_PIN_CONFIG, pin_config,
+			       AC97_GPIO_CFG, pin_config,
 			       CS46XX_SECONDARY_CODEC_INDEX);
     
 	/*
 	 * Set GPIO pin's 7 and 8 so that they are compatible with CMOS logic.
 	 */
 
-	logic_type = snd_cs46xx_codec_read(chip, BA0_AC97_GPIO_PIN_TYPE,
+	logic_type = snd_cs46xx_codec_read(chip, AC97_GPIO_POLARITY,
 					   CS46XX_SECONDARY_CODEC_INDEX);
 	logic_type &=0x27F;
-	snd_cs46xx_codec_write (chip, BA0_AC97_GPIO_PIN_TYPE, logic_type,
+	snd_cs46xx_codec_write (chip, AC97_GPIO_POLARITY, logic_type,
 				CS46XX_SECONDARY_CODEC_INDEX);
 
 	valid_slots = snd_cs46xx_peekBA0(chip, BA0_ACOSV);
 	valid_slots |= 0x200;
 	snd_cs46xx_pokeBA0(chip, BA0_ACOSV, valid_slots);
 
+	valid_slots = snd_cs46xx_peekBA0(chip, BA0_ACOSV2);
+	valid_slots |= 0x200;
+	snd_cs46xx_pokeBA0(chip, BA0_ACOSV2, valid_slots);
+
 	/*
 	 * Fill slots 12 with the correct value for the GPIO pins. 
 	 */
@@ -2981,6 +3238,18 @@
 	}
 }
 
+static void voyectra_mixer_init (cs46xx_t *chip)
+{
+  snd_printdd ("initializing Voyectra mixer\n");
+
+  /* turnon Amplifier and leave it on */
+  chip->amplifier_ctrl(chip, 1);
+  
+  /* Enable SPDIF out */
+  snd_cs46xx_pokeBA0(chip, BA0_EGPIODR, EGPIODR_GPOE0);
+  snd_cs46xx_pokeBA0(chip, BA0_EGPIOPTR, EGPIODR_GPOE0);
+}
+
 static void hercules_mixer_init (cs46xx_t *chip)
 {
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
@@ -3113,7 +3382,7 @@
 
 static struct cs_card_type __initdata cards[] = {
 	{0x1489, 0x7001, "Genius Soundmaker 128 value", NULL, amp_none, NULL, NULL},
-	{0x5053, 0x3357, "Voyetra", NULL, amp_voyetra, NULL, NULL},
+	{0x5053, 0x3357, "Voyetra", NULL, amp_voyetra, NULL, voyectra_mixer_init},
 	{0x1071, 0x6003, "Mitac MI6020/21", NULL, amp_voyetra, NULL, NULL},
 	{0x14AF, 0x0050, "Hercules Game Theatre XP", NULL, amp_hercules, NULL, hercules_mixer_init},
 	{0x1681, 0x0050, "Hercules Game Theatre XP", NULL, amp_hercules, NULL, hercules_mixer_init},
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.h ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h
--- alsa-kernel/pci/cs46xx/cs46xx_lib.h	Mon Aug 26 18:02:05 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h	Sun Oct 20 23:59:35 2002
@@ -51,6 +51,10 @@
 extern snd_pcm_ops_t snd_cs46xx_playback_indirect_ops;
 extern snd_pcm_ops_t snd_cs46xx_capture_ops;
 extern snd_pcm_ops_t snd_cs46xx_capture_indirect_ops;
+extern snd_pcm_ops_t snd_cs46xx_playback_rear_ops;
+extern snd_pcm_ops_t snd_cs46xx_playback_indirect_rear_ops;
+extern snd_pcm_ops_t snd_cs46xx_playback_iec958_ops;
+extern snd_pcm_ops_t snd_cs46xx_playback_indirect_iec958_ops;
 
 
 /*
@@ -185,7 +189,8 @@
                                                           dsp_scb_descriptor_t * snoop_scb,
                                                           dsp_scb_descriptor_t * parent_scb,
                                                           int scb_child_type);
-pcm_channel_descriptor_t * cs46xx_dsp_create_pcm_channel (cs46xx_t * chip,u32 sample_rate, void * private_data, u32 hw_dma_addr);
+pcm_channel_descriptor_t * cs46xx_dsp_create_pcm_channel (cs46xx_t * chip,u32 sample_rate, void * private_data, u32 hw_dma_addr,
+                                                          int pcm_channel_id);
 void                       cs46xx_dsp_destroy_pcm_channel (cs46xx_t * chip,
                                                            pcm_channel_descriptor_t * pcm_channel);
 void                       cs46xx_dsp_set_src_sample_rate(cs46xx_t * chip,dsp_scb_descriptor_t * src, 
@@ -196,4 +201,6 @@
                                                      u16 addr,char * scb_name);
 int                         cs46xx_src_unlink(cs46xx_t *chip,dsp_scb_descriptor_t * src);
 int                         cs46xx_src_link(cs46xx_t *chip,dsp_scb_descriptor_t * src);
+int                         cs46xx_iec958_pre_open (cs46xx_t *chip);
+int                         cs46xx_iec958_post_close (cs46xx_t *chip);
 #endif /* __CS46XX_LIB_H__ */
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c
--- alsa-kernel/pci/cs46xx/dsp_spos.c	Sat Oct  5 11:11:49 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c	Mon Oct 21 23:28:13 2002
@@ -1017,6 +1017,7 @@
 	dsp_scb_descriptor_t * codec_in_scb;
 	dsp_scb_descriptor_t * src_task_scb;
 	dsp_scb_descriptor_t * master_mix_scb;
+	dsp_scb_descriptor_t * rear_mix_scb;
 	dsp_scb_descriptor_t * record_mix_scb;
 	dsp_scb_descriptor_t * write_back_scb;
 	dsp_scb_descriptor_t * vari_decimate_scb;
@@ -1309,18 +1310,29 @@
 
 	/* create secondary CODEC output */
 	sec_codec_out_scb = cs46xx_dsp_create_codec_out_scb(chip,"CodecOutSCB_II",0x0010,0x0040,
-							    OUTPUTSNOOP_SCB_ADDR,
+							    REAR_MIXER_SCB_ADDR,
 							    SEC_CODECOUT_SCB_ADDR,codec_in_scb,
 							    SCB_ON_PARENT_NEXT_SCB);
 	if (!sec_codec_out_scb) goto _fail_end;
 
+
+	/* create the rear PCM channel  mixer SCB */
+	rear_mix_scb = cs46xx_dsp_create_mix_only_scb(chip,"RearMixerSCB",
+                                                  MIX_SAMPLE_BUF3,
+                                                  REAR_MIXER_SCB_ADDR,
+                                                  sec_codec_out_scb,
+                                                  SCB_ON_PARENT_SUBLIST_SCB);
+	ins->rear_mix_scb = rear_mix_scb;
+	if (!rear_mix_scb) goto _fail_end;
+
 	/* the magic snooper */
 	magic_snoop_scb = cs46xx_dsp_create_magic_snoop_scb (chip,"MagicSnoopSCB_I",OUTPUTSNOOP_SCB_ADDR,
 							     OUTPUT_SNOOP_BUFFER,
 							     codec_out_scb,
 							     sec_codec_out_scb,
-							     SCB_ON_PARENT_SUBLIST_SCB);
+							     SCB_ON_PARENT_NEXT_SCB);
 
+    
 	if (!magic_snoop_scb) goto _fail_end;
 	ins->ref_snoop_scb = magic_snoop_scb;
 
@@ -1329,10 +1341,11 @@
 	asynch_tx_scb = cs46xx_dsp_create_asynch_fg_tx_scb(chip,"AsynchFGTxSCB",ASYNCTX_SCB_ADDR,
 							   SPDIFO_SCB_INST,
 							   SPDIFO_IP_OUTPUT_BUFFER1,
-							   magic_snoop_scb,
+							   master_mix_scb,
 							   SCB_ON_PARENT_NEXT_SCB);
 
 	if (!asynch_tx_scb) goto _fail_end;
+    ins->asynch_tx_scb = asynch_tx_scb;
 
 	/* pcm input */
 	pcm_serial_input_task = cs46xx_dsp_create_pcm_serial_input_scb(chip,"PCMSerialInput_II",
@@ -1341,13 +1354,13 @@
 								       SCB_ON_PARENT_SUBLIST_SCB);
   
 	if (!pcm_serial_input_task) goto _fail_end;
+    ins->spdif_pcm_input_scb = pcm_serial_input_task; 
 
 	/* SP IO access */
 	if (!cs46xx_dsp_create_spio_write_scb(chip,"SPIOWriteSCB",SPIOWRITE_SCB_ADDR,
 					      asynch_tx_scb,
 					      SCB_ON_PARENT_NEXT_SCB))
 		goto _fail_end;
-
 
 	/* SPDIF input sampel rate converter */
 	src_task_scb = cs46xx_dsp_create_src_task_scb(chip,"SrcTaskSCB_SPDIFI",
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos.h ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h
--- alsa-kernel/pci/cs46xx/dsp_spos.h	Mon Aug 19 12:53:13 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h	Mon Oct 21 20:55:07 2002
@@ -73,7 +73,9 @@
 #define SPDIFI_IP_OUTPUT_BUFFER1 0x0E00
 #define SPDIFO_IP_OUTPUT_BUFFER1 0x1000
 #define MIX_SAMPLE_BUF1          0x1400
-#define MIX_SAMPLE_BUF2          0x3000
+#define MIX_SAMPLE_BUF2          0x2D00
+#define MIX_SAMPLE_BUF3          0x2E00
+#define MIX_SAMPLE_BUF4          0x2F00
 
 /* Task stack address */
 #define HFG_STACK                0x066A
@@ -104,6 +106,8 @@
 #define OUTPUTSNOOPII_SCB_ADDR   0x150
 #define PCMSERIALIN_PCM_SCB_ADDR 0x160
 #define RECORD_MIXER_SCB_ADDR    0x170
+#define REAR_MIXER_SCB_ADDR      0x180
+#define SPDIF_MIXER_SCB_ADDR     0x190
 
 /* hyperforground SCB's*/
 #define HFG_TREE_SCB             0xBA0
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c
--- alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Sat Oct  5 11:11:49 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Mon Oct 21 22:36:55 2002
@@ -1093,15 +1093,40 @@
 };
 
 
-pcm_channel_descriptor_t * cs46xx_dsp_create_pcm_channel (cs46xx_t * chip,u32 sample_rate, void * private_data, u32 hw_dma_addr)
+pcm_channel_descriptor_t * cs46xx_dsp_create_pcm_channel (cs46xx_t * chip,
+                                                          u32 sample_rate, void * private_data, 
+                                                          u32 hw_dma_addr,
+                                                          int pcm_channel_id)
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
-	dsp_scb_descriptor_t * src_scb = NULL,* pcm_scb;
+	dsp_scb_descriptor_t * src_scb = NULL,* pcm_scb, * mixer_scb = NULL;
 	/*dsp_scb_descriptor_t * pcm_parent_scb;*/
 	char scb_name[DSP_MAX_SCB_NAME];
 	int i,pcm_index = -1, insert_point, src_index = -1;
 	unsigned long flags;
 
+    switch (pcm_channel_id) {
+    case DSP_PCM_MAIN_CHANNEL:
+      mixer_scb = ins->master_mix_scb;
+      break;
+    case DSP_PCM_REAR_CHANNEL:
+      mixer_scb = ins->rear_mix_scb;
+      break;
+    case DSP_PCM_CENTER_CHANNEL:
+      /* TODO */
+      snd_assert(0);
+      break;
+    case DSP_PCM_LFE_CHANNEL:
+      /* TODO */
+      snd_assert(0);
+      break;
+    case DSP_IEC958_CHANNEL:
+      mixer_scb = ins->asynch_tx_scb;
+      break;
+    default:
+      snd_assert (0);
+      return NULL;
+    }
 	/* default sample rate is 44100 */
 	if (!sample_rate) sample_rate = 44100;
 
@@ -1114,7 +1139,9 @@
 		if (i == CS46XX_DSP_CAPTURE_CHANNEL) continue;
 
 		if (ins->pcm_channels[i].active) {
-			if (!src_scb && ins->pcm_channels[i].sample_rate == sample_rate) {
+			if (!src_scb && 
+                ins->pcm_channels[i].sample_rate == sample_rate &&
+                ins->pcm_channels[i].mixer_scb == mixer_scb) {
 				src_scb = ins->pcm_channels[i].src_scb;
 				ins->pcm_channels[i].src_scb->ref_count ++;
 				src_index = ins->pcm_channels[i].src_slot;
@@ -1148,11 +1175,11 @@
 		snd_assert (src_index != -1,return NULL);
 
 		/* we need to create a new SRC SCB */
-		if (ins->master_mix_scb->sub_list_ptr == ins->the_null_scb) {
-			src_parent_scb = ins->master_mix_scb;
+		if (mixer_scb->sub_list_ptr == ins->the_null_scb) {
+			src_parent_scb = mixer_scb;
 			insert_point = SCB_ON_PARENT_SUBLIST_SCB;
 		} else {
-			src_parent_scb = find_next_free_scb(chip,ins->master_mix_scb->sub_list_ptr);
+			src_parent_scb = find_next_free_scb(chip,mixer_scb->sub_list_ptr);
 			insert_point = SCB_ON_PARENT_NEXT_SCB;
 		}
 
@@ -1180,7 +1207,8 @@
   
 	snprintf (scb_name,DSP_MAX_SCB_NAME,"PCMReader_SCB%d",pcm_index);
 
-	snd_printdd( "dsp_spos: creating PCM \"%s\"\n",scb_name);
+	snd_printdd( "dsp_spos: creating PCM \"%s\" (%d)\n",scb_name,
+                 pcm_channel_id);
 
 	pcm_scb = cs46xx_dsp_create_pcm_reader_scb(chip,scb_name,
 						   pcm_reader_buffer_addr[pcm_index],
@@ -1206,6 +1234,8 @@
 	ins->pcm_channels[pcm_index].src_slot = src_index;
 	ins->pcm_channels[pcm_index].active = 1;
 	ins->pcm_channels[pcm_index].pcm_slot = pcm_index;
+    ins->pcm_channels[pcm_index].mixer_scb = mixer_scb;
+    ins->pcm_channels[pcm_index].pcm_channel_id = pcm_channel_id;
 	ins->npcm_channels ++;
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
@@ -1431,4 +1461,39 @@
 			(parent_scb->next_scb_ptr->address));
   
 	return 0;
+}
+
+int cs46xx_iec958_pre_open (cs46xx_t *chip) {
+  dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+
+  snd_assert (ins->spdif_pcm_input_scb != NULL);
+  snd_assert (ins->asynch_tx_scb->sub_list_ptr == ins->spdif_pcm_input_scb);
+
+  /*cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 << 12) | (1 << 2)); */
+
+  _dsp_unlink_scb (chip,ins->spdif_pcm_input_scb);
+  return 0;
+}
+
+int cs46xx_iec958_post_close (cs46xx_t *chip) {
+  dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+
+  snd_assert (ins->spdif_pcm_input_scb != NULL);
+  snd_assert (ins->asynch_tx_scb->sub_list_ptr == ins->the_null_scb);
+  snd_assert (ins->spdif_pcm_input_scb->parent_scb_ptr == NULL);
+
+  /* relink the SPDIF output PCM ref */
+  ins->asynch_tx_scb->sub_list_ptr = ins->spdif_pcm_input_scb;
+  ins->spdif_pcm_input_scb->parent_scb_ptr = ins->asynch_tx_scb;
+
+
+  /* cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 << 12)); */
+
+  /* update entry in DSP RAM */
+  snd_cs46xx_poke(chip,
+                  (ins->asynch_tx_scb->address + SCBsubListPtr) << 2,
+                  (ins->asynch_tx_scb->sub_list_ptr->address << 0x10) |
+                  (ins->asynch_tx_scb->next_scb_ptr->address));
+
+  return 0;
 }

--------------090804060704000507060108--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
