From: Benny Sjostrand <gorm@cucumelo.org>
Subject: preliminary [PATCH] cs46xx independant PCM - Rear channel
Date: Sun, 20 Oct 2002 20:03:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB2F00B.3020706@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000807020101020905020701"
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
--------------000807020101020905020701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

With this patch it should be possible to play a indpendent PCM stream to 
the "Rear" channel
on a cs46xx based HW.
Well, I guess I dont need to tell you that this patch probably works 
fine with a Game Thater XP card,
and probably some touches are neeeded for other cs46xx based soundcards.

The DSP will send the main PCM stream to the codec on slot 3 and 4, and for
the Rear channel it send the PCM stream it uses slot 7 and 8, which works
fine in a dual cs4294 combination setting the secondary codec in 
extended mode.

With other combinations probably we need experiment a little bit to find
out how configure the codecs.

NOTE: sound is no longer duplicated in main and rear channels, so you need
to run something like "aplay -D hw:0,1" to feed some sound in rear 
channel now.

Still left to have PCM channels for Center and LFE, and here I would
need some suggestion how to proceed. Is it possible in some how
to create a Mono PCM channel for this purpose with the ALSA API ??

/Benny


--------------000807020101020905020701
Content-Type: text/plain;
 name="cs46xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx.patch"

diff -Naur --exclude=CVS alsa-kernel/include/cs46xx.h ../cvs/alsa-kernel/include/cs46xx.h
--- alsa-kernel/include/cs46xx.h	Fri Aug 23 17:51:18 2002
+++ ../cvs/alsa-kernel/include/cs46xx.h	Sat Oct 19 21:23:11 2002
@@ -1790,6 +1790,7 @@
 	struct pci_dev *pci;
 	snd_card_t *card;
 	snd_pcm_t *pcm;
+
 	snd_rawmidi_t *rmidi;
 	snd_rawmidi_substream_t *midi_input;
 	snd_rawmidi_substream_t *midi_output;
@@ -1814,12 +1815,15 @@
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
@@ -1832,6 +1836,8 @@
 		      cs46xx_t **rcodec);
 
 int snd_cs46xx_pcm(cs46xx_t *chip, int device, snd_pcm_t **rpcm);
+int snd_cs46xx_pcm_rear(cs46xx_t *chip, int device, snd_pcm_t **rpcm);
+int snd_cs46xx_pcm_iec958(cs46xx_t *chip, int device, snd_pcm_t **rpcm);
 int snd_cs46xx_mixer(cs46xx_t *chip);
 int snd_cs46xx_midi(cs46xx_t *chip, int device, snd_rawmidi_t **rmidi);
 void snd_cs46xx_gameport(cs46xx_t *chip);
diff -Naur --exclude=CVS alsa-kernel/include/cs46xx_dsp_spos.h ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h
--- alsa-kernel/include/cs46xx_dsp_spos.h	Fri Aug 23 17:51:18 2002
+++ ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h	Sun Oct 20 13:14:12 2002
@@ -54,6 +54,9 @@
 #define DSP_MAX_PCM_CHANNELS 32
 #define DSP_MAX_SRC_NR       6
 
+#define DSP_PCM_MAIN_CHANNEL 1
+#define DSP_PCM_REAR_CHANNEL 2
+
 struct _dsp_module_desc_t;
 
 typedef struct _symbol_entry_t {
@@ -129,6 +132,8 @@
 	u32 unlinked;
 	dsp_scb_descriptor_t * pcm_reader_scb;
 	dsp_scb_descriptor_t * src_scb;
+	dsp_scb_descriptor_t * mixer_scb;
+    int pcm_channel_id;
 
 	void * private_data;
 } pcm_channel_descriptor_t;
@@ -141,8 +146,12 @@
 
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
diff -Naur --exclude=CVS alsa-kernel/pci/ac97/ac97_codec.c ../cvs/alsa-kernel/pci/ac97/ac97_codec.c
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
diff -Naur --exclude=CVS alsa-kernel/pci/cs46xx/cs46xx.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx.c
--- alsa-kernel/pci/cs46xx/cs46xx.c	Thu Aug 15 14:13:09 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx.c	Sun Oct 20 19:41:42 2002
@@ -110,6 +110,10 @@
 		snd_card_free(card);
 		return err;
 	}
+    if ((err = snd_cs46xx_pcm_rear(chip,1, NULL)) < 0) {
+        snd_card_free(card);
+        return err;
+    }
 	if ((err = snd_cs46xx_mixer(chip)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -132,6 +136,7 @@
 		snd_card_free(card);
 		return err;
 	}
+
 	pci_set_drvdata(pci, chip);
 	dev++;
 	return 0;
diff -Naur --exclude=CVS alsa-kernel/pci/cs46xx/cs46xx_lib.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Mon Sep 30 19:50:51 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sun Oct 20 19:21:05 2002
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
@@ -994,7 +994,21 @@
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
@@ -1003,7 +1017,21 @@
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
+        } else {
+          snd_assert(0);
+        }
+#else
+        substream->ops = &snd_cs46xx_playback_indirect_ops;
+#endif
+
 	}
 
 	return 0;
@@ -1054,7 +1082,9 @@
 		int unlinked = cpcm->pcm_channel->unlinked;
 		cs46xx_dsp_destroy_pcm_channel (chip,cpcm->pcm_channel);
 
-		if ( (cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, runtime->rate, cpcm, cpcm->hw_addr)) == NULL) {
+		if ( (cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, runtime->rate, cpcm, 
+                                                                 cpcm->hw_addr,
+                                                                 cpcm->pcm_channel->pcm_channel_id)) == NULL) {
 			snd_printk(KERN_ERR "cs46xx: failed to re-create virtual PCM channel\n");
 			up (&chip->spos_mutex);
 			return -ENXIO;
@@ -1320,7 +1350,7 @@
 		snd_magic_kfree(cpcm);
 }
 
-static int snd_cs46xx_playback_open(snd_pcm_substream_t * substream)
+static int _cs46xx_playback_open_channel (snd_pcm_substream_t * substream,int pcm_channel_id)
 {
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
 	cs46xx_pcm_t * cpcm;
@@ -1342,7 +1372,7 @@
 	cpcm->substream = substream;
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	down (&chip->spos_mutex);
-	cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, runtime->rate, cpcm, cpcm->hw_addr);
+	cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, runtime->rate, cpcm, cpcm->hw_addr,pcm_channel_id);
 
 	if (cpcm->pcm_channel == NULL) {
 		snd_printk(KERN_ERR "cs46xx: failed to create virtual PCM channel\n");
@@ -1365,6 +1395,22 @@
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
+  return _cs46xx_playback_open_channel(substream,DSP_PCM_REAR_CHANNEL);
+}
+
+static int snd_cs46xx_playback_open_iec958(snd_pcm_substream_t * substream) {
+  return -EBUSY;
+}
+#endif
+
 static int snd_cs46xx_capture_open(snd_pcm_substream_t * substream)
 {
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
@@ -1422,11 +1468,35 @@
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
+snd_pcm_ops_t snd_cs46xx_playback_iec958_ops = {
+	.open =			snd_cs46xx_playback_open_iec958,
+	.close =		snd_cs46xx_playback_close,
+	.ioctl =		snd_pcm_lib_ioctl,
+	.hw_params =	snd_cs46xx_playback_hw_params,
+	.hw_free =		snd_cs46xx_playback_hw_free,
+	.prepare =		snd_cs46xx_playback_prepare,
+	.trigger =		snd_cs46xx_playback_trigger,
+	.pointer =		snd_cs46xx_playback_direct_pointer,
+};
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
@@ -1445,6 +1515,18 @@
 	.pointer =		snd_cs46xx_playback_indirect_pointer,
 };
 
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
 snd_pcm_ops_t snd_cs46xx_capture_ops = {
 	.open =			snd_cs46xx_capture_open,
 	.close =		snd_cs46xx_capture_close,
@@ -1475,6 +1557,20 @@
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
@@ -1490,6 +1586,7 @@
 		*rpcm = NULL;
 	if ((err = snd_pcm_new(chip->card, "CS46xx", device, MAX_PLAYBACK_CHANNELS, 1, &pcm)) < 0)
 		return err;
+
 	pcm->private_data = chip;
 	pcm->private_free = snd_cs46xx_pcm_free;
 
@@ -1505,13 +1602,72 @@
 
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
@@ -1927,6 +2083,47 @@
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
@@ -2001,11 +2198,18 @@
 	/* well, one codec only ... */
 	goto _end;
  _ok2:
+    /* set secondary codec in extended mode */
+    // snd_cs46xx_ac97_write(&ac97,AC97_CSR_ACMODE,0x3);
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
+    // snd_cs46xx_ac97_write(chip->ac97[CS46XX_SECONDARY_CODEC_INDEX],AC97_CSR_ACMODE,0x3);
  _end:
 
 	/* dosoundcard specific mixer setup */
@@ -2016,6 +2220,7 @@
     
 #endif /* CONFIG_SND_CS46XX_NEW_DSP */
 
+	/* add cs4630 mixer controls */
 	for (idx = 0; idx < sizeof(snd_cs46xx_controls) / 
 		     sizeof(snd_cs46xx_controls[0]); idx++) {
 		snd_kcontrol_t *kctl;
diff -Naur --exclude=CVS alsa-kernel/pci/cs46xx/cs46xx_lib.h ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h
--- alsa-kernel/pci/cs46xx/cs46xx_lib.h	Mon Aug 26 18:02:05 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h	Sun Oct 20 14:56:50 2002
@@ -51,6 +51,9 @@
 extern snd_pcm_ops_t snd_cs46xx_playback_indirect_ops;
 extern snd_pcm_ops_t snd_cs46xx_capture_ops;
 extern snd_pcm_ops_t snd_cs46xx_capture_indirect_ops;
+extern snd_pcm_ops_t snd_cs46xx_playback_rear_ops;
+extern snd_pcm_ops_t snd_cs46xx_playback_indirect_rear_ops;
+
 
 
 /*
@@ -185,7 +188,8 @@
                                                           dsp_scb_descriptor_t * snoop_scb,
                                                           dsp_scb_descriptor_t * parent_scb,
                                                           int scb_child_type);
-pcm_channel_descriptor_t * cs46xx_dsp_create_pcm_channel (cs46xx_t * chip,u32 sample_rate, void * private_data, u32 hw_dma_addr);
+pcm_channel_descriptor_t * cs46xx_dsp_create_pcm_channel (cs46xx_t * chip,u32 sample_rate, void * private_data, u32 hw_dma_addr,
+                                                          int pcm_channel_id);
 void                       cs46xx_dsp_destroy_pcm_channel (cs46xx_t * chip,
                                                            pcm_channel_descriptor_t * pcm_channel);
 void                       cs46xx_dsp_set_src_sample_rate(cs46xx_t * chip,dsp_scb_descriptor_t * src, 
diff -Naur --exclude=CVS alsa-kernel/pci/cs46xx/dsp_spos.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c
--- alsa-kernel/pci/cs46xx/dsp_spos.c	Sat Oct  5 11:11:49 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c	Sun Oct 20 15:02:00 2002
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
 
diff -Naur --exclude=CVS alsa-kernel/pci/cs46xx/dsp_spos.h ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h
--- alsa-kernel/pci/cs46xx/dsp_spos.h	Mon Aug 19 12:53:13 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h	Sun Oct 20 12:14:33 2002
@@ -73,7 +73,8 @@
 #define SPDIFI_IP_OUTPUT_BUFFER1 0x0E00
 #define SPDIFO_IP_OUTPUT_BUFFER1 0x1000
 #define MIX_SAMPLE_BUF1          0x1400
-#define MIX_SAMPLE_BUF2          0x3000
+#define MIX_SAMPLE_BUF2          0x2D00
+#define MIX_SAMPLE_BUF3          0x2E00
 
 /* Task stack address */
 #define HFG_STACK                0x066A
@@ -104,6 +105,7 @@
 #define OUTPUTSNOOPII_SCB_ADDR   0x150
 #define PCMSERIALIN_PCM_SCB_ADDR 0x160
 #define RECORD_MIXER_SCB_ADDR    0x170
+#define REAR_MIXER_SCB_ADDR      0x180
 
 /* hyperforground SCB's*/
 #define HFG_TREE_SCB             0xBA0
diff -Naur --exclude=CVS alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c
--- alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Sat Oct  5 11:11:49 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Sun Oct 20 14:43:25 2002
@@ -1093,15 +1093,29 @@
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
+    default:
+      snd_assert (0);
+      return NULL;
+    }
 	/* default sample rate is 44100 */
 	if (!sample_rate) sample_rate = 44100;
 
@@ -1114,7 +1128,9 @@
 		if (i == CS46XX_DSP_CAPTURE_CHANNEL) continue;
 
 		if (ins->pcm_channels[i].active) {
-			if (!src_scb && ins->pcm_channels[i].sample_rate == sample_rate) {
+			if (!src_scb && 
+                ins->pcm_channels[i].sample_rate == sample_rate &&
+                ins->pcm_channels[i].mixer_scb == mixer_scb) {
 				src_scb = ins->pcm_channels[i].src_scb;
 				ins->pcm_channels[i].src_scb->ref_count ++;
 				src_index = ins->pcm_channels[i].src_slot;
@@ -1148,11 +1164,11 @@
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
 
@@ -1180,7 +1196,8 @@
   
 	snprintf (scb_name,DSP_MAX_SCB_NAME,"PCMReader_SCB%d",pcm_index);
 
-	snd_printdd( "dsp_spos: creating PCM \"%s\"\n",scb_name);
+	snd_printdd( "dsp_spos: creating PCM \"%s\" (%d)\n",scb_name,
+                 pcm_channel_id);
 
 	pcm_scb = cs46xx_dsp_create_pcm_reader_scb(chip,scb_name,
 						   pcm_reader_buffer_addr[pcm_index],
@@ -1206,6 +1223,8 @@
 	ins->pcm_channels[pcm_index].src_slot = src_index;
 	ins->pcm_channels[pcm_index].active = 1;
 	ins->pcm_channels[pcm_index].pcm_slot = pcm_index;
+    ins->pcm_channels[pcm_index].mixer_scb = mixer_scb;
+    ins->pcm_channels[pcm_index].pcm_channel_id = pcm_channel_id;
 	ins->npcm_channels ++;
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 

--------------000807020101020905020701--



-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD
