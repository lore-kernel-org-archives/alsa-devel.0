From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [PATCH] rme96 add stream synchronization and PM
 support
Date: Thu, 15 Aug 2013 08:01:05 +0200
Message-ID: <520C6EA1.8090608@t-online.de>
References: <51FF9C55.80701@t-online.de> <51FFA643.7060504@ladisch.de>
 <52013579.7020304@t-online.de> <s5h4nb2asg5.wl%tiwai@suse.de>
 <52037864.9000205@t-online.de> <s5h61vacb25.wl%tiwai@suse.de>
 <520A0B2C.7060500@t-online.de> <s5hy585x4e3.wl%tiwai@suse.de>
 <520AA125.5010803@t-online.de> <s5hd2pgs45i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020908010605020805060800"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout03.t-online.de (mailout03.t-online.de [194.25.134.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 09E6E261A65
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 08:01:12 +0200 (CEST)
In-Reply-To: <s5hd2pgs45i.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020908010605020805060800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.2013 17:06, Takashi Iwai wrote:
> Please resubmit only the second patch with the fixes.

Ah, yes. That should have been obvious.

After a 2nd thought I believe that  it is an even better idea
not to abort but to handle that error condition graciously.

cu,
  Knut

--------------020908010605020805060800
Content-Type: text/x-patch;
 name="0001-alsa-rme96-Add-PM-support-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-alsa-rme96-Add-PM-support-v2.patch"

>From b0d42bb60a11ba82d26850a4a2ed0aad89d7df79 Mon Sep 17 00:00:00 2001
From: Knut Petersen <Knut_Petersen@t-online.de>
Date: Thu, 15 Aug 2013 07:39:36 +0200
Subject: [PATCH] alsa/rme96: Add PM support v2

Without proper power management handling, the first use
of a Digi96/8 anytime after a suspend / resume cycle will
start playback with distortions.

v2: If vmalloc() of playback and/or capture suspend buffer
fails, do not abort but snd_printk() a warning. Later on,
during resume, zero out hardware buffers if restoring is
impossible beause of unavailable suspend buffers.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>
---
 sound/pci/rme96.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 3eb0bdd..73934e9 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -239,6 +239,13 @@ struct rme96 {
 
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
 
@@ -370,6 +377,7 @@ static struct snd_pcm_hardware snd_rme96_playback_spdif_info =
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_SYNC_START |
+			      SNDRV_PCM_INFO_RESUME |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -400,6 +408,7 @@ static struct snd_pcm_hardware snd_rme96_capture_spdif_info =
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_SYNC_START |
+			      SNDRV_PCM_INFO_RESUME |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -430,6 +439,7 @@ static struct snd_pcm_hardware snd_rme96_playback_adat_info =
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_SYNC_START |
+			      SNDRV_PCM_INFO_RESUME |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -456,6 +466,7 @@ static struct snd_pcm_hardware snd_rme96_capture_adat_info =
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_SYNC_START |
+			      SNDRV_PCM_INFO_RESUME |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -1386,6 +1397,7 @@ snd_rme96_playback_trigger(struct snd_pcm_substream *substream,
 		}
 		break;
 
+	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 		if (RME96_ISPLAYING(rme96)) {
 			if (substream != rme96->playback_substream)
@@ -1401,6 +1413,7 @@ snd_rme96_playback_trigger(struct snd_pcm_substream *substream,
 						 : RME96_STOP_PLAYBACK);
 		break;
 
+	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (!RME96_ISPLAYING(rme96))
 			snd_rme96_trigger(rme96, sync ? RME96_RESUME_BOTH
@@ -1441,6 +1454,7 @@ snd_rme96_capture_trigger(struct snd_pcm_substream *substream,
 		}
 		break;
 
+	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 		if (RME96_ISRECORDING(rme96)) {
 			if (substream != rme96->capture_substream)
@@ -1456,6 +1470,7 @@ snd_rme96_capture_trigger(struct snd_pcm_substream *substream,
 						 : RME96_STOP_CAPTURE);
 		break;
 
+	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (!RME96_ISRECORDING(rme96))
 			snd_rme96_trigger(rme96, sync ? RME96_RESUME_BOTH
@@ -1556,6 +1571,10 @@ snd_rme96_free(void *private_data)
 		pci_release_regions(rme96->pci);
 		rme96->port = 0;
 	}
+#ifdef CONFIG_PM
+	vfree(rme96->playback_suspend_buffer);
+	vfree(rme96->capture_suspend_buffer);
+#endif
 	pci_disable_device(rme96->pci);
 }
 
@@ -2354,6 +2373,95 @@ snd_rme96_create_switches(struct snd_card *card,
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
+	rme96->playback_pointer = readl(rme96->iobase + RME96_IO_GET_PLAY_POS)
+				  & RME96_RCR_AUDIO_ADDR_MASK;
+	rme96->capture_pointer = readl(rme96->iobase + RME96_IO_GET_REC_POS)
+				 & RME96_RCR_AUDIO_ADDR_MASK;
+
+	/* save playback and capture buffers */
+	if (rme96->playback_suspend_buffer)
+		memcpy_fromio(rme96->playback_suspend_buffer,
+			      rme96->iobase + RME96_IO_PLAY_BUFFER,
+			      RME96_BUFFER_SIZE);
+	if (rme96->capture_suspend_buffer)
+		memcpy_fromio(rme96->capture_suspend_buffer,
+			      rme96->iobase + RME96_IO_REC_BUFFER,
+			      RME96_BUFFER_SIZE);
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
+	writel(0, rme96->iobase + RME96_IO_SET_PLAY_POS
+		  + rme96->playback_pointer);
+	writel(0, rme96->iobase + RME96_IO_SET_REC_POS
+		  + rme96->capture_pointer);
+
+	/* restore playback and capture buffers */
+	if (rme96->playback_suspend_buffer)
+		memcpy_toio(rme96->iobase + RME96_IO_PLAY_BUFFER,
+			    rme96->playback_suspend_buffer, RME96_BUFFER_SIZE);
+	else
+		memset_io(rme96->iobase + RME96_IO_PLAY_BUFFER,
+			  0, RME96_BUFFER_SIZE);
+	if (rme96->capture_suspend_buffer)
+		memcpy_toio(rme96->iobase + RME96_IO_REC_BUFFER,
+			    rme96->capture_suspend_buffer, RME96_BUFFER_SIZE);
+	else
+		memset_io(rme96->iobase + RME96_IO_REC_BUFFER,
+			  0, RME96_BUFFER_SIZE);
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
+		usleep_range(3000, 10000);
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
@@ -2390,6 +2498,15 @@ snd_rme96_probe(struct pci_dev *pci,
 		return err;
 	}
 	
+#ifdef CONFIG_PM
+	rme96->playback_suspend_buffer = vmalloc(RME96_BUFFER_SIZE);
+	if (!rme96->playback_suspend_buffer)
+		snd_printk(KERN_WARNING "no playback suspend buffer\n");
+	rme96->capture_suspend_buffer = vmalloc(RME96_BUFFER_SIZE);
+	if (!rme96->capture_suspend_buffer)
+		snd_printk(KERN_WARNING "no capture suspend buffer\n");
+#endif
+
 	strcpy(card->driver, "Digi96");
 	switch (rme96->pci->device) {
 	case PCI_DEVICE_ID_RME_DIGI96:
@@ -2433,6 +2550,10 @@ static struct pci_driver rme96_driver = {
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


--------------020908010605020805060800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020908010605020805060800--
