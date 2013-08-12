From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [PATCH] Add PM support to the rme96 driver
Date: Mon, 12 Aug 2013 18:29:44 +0200
Message-ID: <52090D78.70601@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070100030508000303060409"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 5185A2617B8
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 18:29:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070100030508000303060409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi everybody!

The attached patch adds PM support to the rme96 driver,
it should be applied after v2 of the patch adding pcm stream
synchronization support posted on 2013-08-08.

It does work perfectly here on an RME Digi96/8 PAD:

After connecting analog output and analog input executing

     #! /bin/sh
     #
     arecord  -D hw:0,0 -d 62 testout.wav  &
     aplay  -D hw:0,0 -d 60 testin.wav

produces an almost perfect recording even
when the test machine is suspended / hibernated
and resumed several times.

cu,
  Knut

--------------070100030508000303060409
Content-Type: text/x-patch;
 name="0001-alsa-rme96-Add-PM-support-to-the-rme96-driver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alsa-rme96-Add-PM-support-to-the-rme96-driver.patch"

>From 7305b056cbb4de562018483b91cf90c677df317f Mon Sep 17 00:00:00 2001
From: Knut Petersen <Knut_Petersen@t-online.de>
Date: Mon, 12 Aug 2013 18:00:30 +0200
Subject: [PATCH] alsa/rme96: Add PM support to the rme96 driver

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>
---
 sound/pci/rme96.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 35651c5..6e0a6e1 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -232,6 +232,13 @@ struct rme96 {
 
 	u8 rev; /* card revision number */
 
+#ifdef CONFIG_PM
+	u32 playback_pointer;
+	u32 capture_pointer;
+	void *playback_suspend_buffer;
+	void *capture_suspend_buffer;
+#endif
+
 	struct snd_pcm_substream *playback_substream;
 	struct snd_pcm_substream *capture_substream;
 
@@ -363,6 +370,9 @@ static struct snd_pcm_hardware snd_rme96_playback_spdif_info =
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_SYNC_START |
+#ifdef CONFIG_PM
+			      SNDRV_PCM_INFO_RESUME |
+#endif
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -393,6 +403,9 @@ static struct snd_pcm_hardware snd_rme96_capture_spdif_info =
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_SYNC_START |
+#ifdef CONFIG_PM
+			      SNDRV_PCM_INFO_RESUME |
+#endif
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -423,6 +436,9 @@ static struct snd_pcm_hardware snd_rme96_playback_adat_info =
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_SYNC_START |
+#ifdef CONFIG_PM
+			      SNDRV_PCM_INFO_RESUME |
+#endif
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -449,6 +465,9 @@ static struct snd_pcm_hardware snd_rme96_capture_adat_info =
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_SYNC_START |
+#ifdef CONFIG_PM
+			      SNDRV_PCM_INFO_RESUME |
+#endif
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -1387,6 +1406,7 @@ snd_rme96_playback_trigger(struct snd_pcm_substream *substream,
 		}
 		break;
 
+	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 		if (RME96_ISPLAYING(rme96)) {
 			if (substream != rme96->playback_substream) {
@@ -1402,6 +1422,7 @@ snd_rme96_playback_trigger(struct snd_pcm_substream *substream,
 		}
 		break;
 
+	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (!RME96_ISPLAYING(rme96)) {
 			snd_rme96_trigger(rme96, sync ? RME96_RESUME_BOTH : RME96_RESUME_PLAYBACK);
@@ -1441,6 +1462,7 @@ snd_rme96_capture_trigger(struct snd_pcm_substream *substream,
 		}
 		break;
 
+	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 		if (RME96_ISRECORDING(rme96)) {
 			if (substream != rme96->capture_substream) {
@@ -1456,6 +1478,7 @@ snd_rme96_capture_trigger(struct snd_pcm_substream *substream,
 		}
 		break;
 
+	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (!RME96_ISRECORDING(rme96)) {
 			snd_rme96_trigger(rme96, sync ? RME96_RESUME_BOTH : RME96_RESUME_CAPTURE);
@@ -1556,6 +1579,14 @@ snd_rme96_free(void *private_data)
 		pci_release_regions(rme96->pci);
 		rme96->port = 0;
 	}
+#ifdef CONFIG_PM
+	if (rme96->playback_suspend_buffer) {  
+		kfree(rme96->playback_suspend_buffer);
+	}
+	if (rme96->capture_suspend_buffer) {  
+		kfree(rme96->capture_suspend_buffer);
+	}
+#endif
 	pci_disable_device(rme96->pci);
 }
 
@@ -2354,6 +2385,76 @@ snd_rme96_create_switches(struct snd_card *card,
  * Card initialisation
  */
 
+#ifdef CONFIG_PM
+
+static int
+snd_rme96_suspend(struct pci_dev *pci,
+		  pm_message_t state)
+{
+	struct snd_card *card = pci_get_drvdata(pci);
+	struct rme96 *rme96 = card->private_data;
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+	snd_pcm_suspend(rme96->playback_substream);
+	snd_pcm_suspend(rme96->capture_substream);
+
+	/* save capture & playback pointers */
+	rme96->playback_pointer = readl(rme96->iobase + RME96_IO_GET_PLAY_POS) & RME96_RCR_AUDIO_ADDR_MASK;
+	rme96->capture_pointer = readl(rme96->iobase + RME96_IO_GET_REC_POS) & RME96_RCR_AUDIO_ADDR_MASK;
+
+	/* save playback and capture buffers */
+	memcpy_fromio(rme96->playback_suspend_buffer,rme96->iobase + RME96_IO_PLAY_BUFFER,RME96_BUFFER_SIZE);
+	memcpy_fromio(rme96->capture_suspend_buffer,rme96->iobase + RME96_IO_REC_BUFFER,RME96_BUFFER_SIZE);
+ 
+	/* disable the DAC  */
+	rme96->areg &= ~RME96_AR_DAC_EN;
+	writel(rme96->areg, rme96->iobase + RME96_IO_ADDITIONAL_REG);
+
+	pci_disable_device(pci);
+	pci_save_state(pci);
+
+	return 0;
+}
+
+static int
+snd_rme96_resume(struct pci_dev *pci)
+{
+	struct snd_card *card = pci_get_drvdata(pci);
+	struct rme96 *rme96 = card->private_data;
+
+	pci_restore_state(pci);
+	pci_enable_device(pci);
+
+	/* reset playback and record buffer pointers */
+	writel(0, rme96->iobase + RME96_IO_SET_PLAY_POS + rme96->playback_pointer);
+	writel(0, rme96->iobase + RME96_IO_SET_REC_POS + rme96->capture_pointer);
+
+	/* restore playback and capture buffers */
+	memcpy_toio(rme96->iobase + RME96_IO_PLAY_BUFFER,rme96->playback_suspend_buffer,RME96_BUFFER_SIZE);
+	memcpy_toio(rme96->iobase + RME96_IO_REC_BUFFER,rme96->capture_suspend_buffer,RME96_BUFFER_SIZE);
+
+	/* reset the ADC */
+	writel(rme96->areg | RME96_AR_PD2,
+	       rme96->iobase + RME96_IO_ADDITIONAL_REG);
+	writel(rme96->areg, rme96->iobase + RME96_IO_ADDITIONAL_REG);	
+
+	/* reset and enable DAC, restore analog volume */
+	snd_rme96_reset_dac(rme96);
+	rme96->areg |= RME96_AR_DAC_EN;
+	writel(rme96->areg, rme96->iobase + RME96_IO_ADDITIONAL_REG);
+	if (RME96_HAS_ANALOG_OUT(rme96)) {
+		/* msleep(1) is the  documented AD1852 minimum */
+		msleep(3);
+		snd_rme96_apply_dac_volume(rme96);
+	}
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+
+	return 0;
+}
+
+#endif
+
 static void snd_rme96_card_free(struct snd_card *card)
 {
 	snd_rme96_free(card->private_data);
@@ -2390,6 +2491,19 @@ snd_rme96_probe(struct pci_dev *pci,
 		return err;
 	}
 	
+#ifdef CONFIG_PM
+	rme96->playback_suspend_buffer = kmalloc(RME96_BUFFER_SIZE, GFP_KERNEL);
+	if (!rme96->playback_suspend_buffer) {
+	snd_printk(KERN_ERR "Failed to allocate playback suspend buffer!\n");
+		return -ENOMEM;
+	}
+	rme96->capture_suspend_buffer = kmalloc(RME96_BUFFER_SIZE, GFP_KERNEL);
+	if (!rme96->capture_suspend_buffer) {
+		snd_printk(KERN_ERR "Failed to allocate capture suspend buffer!\n");
+	return -ENOMEM;
+	}
+#endif
+
 	strcpy(card->driver, "Digi96");
 	switch (rme96->pci->device) {
 	case PCI_DEVICE_ID_RME_DIGI96:
@@ -2433,6 +2547,10 @@ static struct pci_driver rme96_driver = {
 	.id_table = snd_rme96_ids,
 	.probe = snd_rme96_probe,
 	.remove = snd_rme96_remove,
+#ifdef CONFIG_PM
+	.suspend = snd_rme96_suspend,
+	.resume = snd_rme96_resume,
+#endif
 };
 
 module_pci_driver(rme96_driver);
-- 
1.8.1.4


--------------070100030508000303060409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070100030508000303060409--
