From: linux@audioscience.com
Subject: [PATCH 5/7] Use adapter properties for stream buffer
 constraints. Default to less logging,
 remove VPRINTK3 Log buffer info in decimal.
Date: Tue, 23 Mar 2010 21:14:25 +1300
Message-ID: <1269332067-25959-6-git-send-email-linux@audioscience.com>
References: <1269332067-25959-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1269332067-25959-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/asihpi.c |  102 +++++++++++++++++++++++++++-----------------------
 1 files changed, 55 insertions(+), 47 deletions(-)

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index 4f82e9f..585d0c5 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -25,23 +25,17 @@
 #define REALLY_VERBOSE_LOGGING 0
 
 #if REALLY_VERBOSE_LOGGING
-#define VPRINTK1 printk
+#define VPRINTK1 snd_printd
 #else
 #define VPRINTK1(...)
 #endif
 
 #if REALLY_VERBOSE_LOGGING > 1
-#define VPRINTK2 printk
+#define VPRINTK2 snd_printd
 #else
 #define VPRINTK2(...)
 #endif
 
-#if REALLY_VERBOSE_LOGGING > 2
-#define VPRINTK3 printk
-#else
-#define VPRINTK3(...)
-#endif
-
 #ifndef ASI_STYLE_NAMES
 /* not sure how ALSA style name should look */
 #define ASI_STYLE_NAMES 1
@@ -56,7 +50,6 @@
 #include "adriver.h"
 #else
 /* building in kernel tree */
-#include <sound/driver.h>
 #endif
 
 #include <linux/pci.h>
@@ -154,9 +147,10 @@ struct snd_card_asihpi {
 	u32 hMixer;
 	struct clk_cache cc;
 
-	int support_mmap;
-	int support_grouping;
-	int support_mrx;
+	u16 support_mmap;
+	u16 support_grouping;
+	u16 support_mrx;
+	u16 update_interval_frames;
 	u16 in_max_chans;
 	u16 out_max_chans;
 };
@@ -396,14 +390,14 @@ static void snd_card_asihpi_pcm_samplerates(struct snd_card_asihpi *asihpi,
 					  HPI_SOURCENODE_CLOCK_SOURCE, 0, 0, 0,
 					  HPI_CONTROL_SAMPLECLOCK, &hControl);
 		if (err) {
-			printk(KERN_ERR "No local sampleclock, err %d\n", err);
+			snd_printk(KERN_ERR "No local sampleclock, err %d\n", err);
 		}
 
 		for (idx = 0; idx < 100; idx++) {
 			if (HPI_SampleClock_QueryLocalRate(phSubSys, hControl,
 					idx, &sampleRate)) {
 				if (!idx)
-					printk(KERN_ERR "Local rate query failed\n");
+					snd_printk(KERN_ERR "Local rate query failed\n");
 
 				break;
 			}
@@ -532,7 +526,7 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 	dpcm->bytes_per_sec = bytes_per_sec;
 	dpcm->pcm_size = params_buffer_bytes(params);
 	dpcm->pcm_count = params_period_bytes(params);
-	snd_printd(KERN_INFO "pcm_size x%x, pcm_count x%x, Bps %d\n",
+	snd_printd(KERN_INFO "pcm_size=%d, pcm_count=%d, Bps=%d\n",
 			dpcm->pcm_size, dpcm->pcm_count, bytes_per_sec);
 
 	dpcm->pcm_irq_pos = 0;
@@ -547,8 +541,8 @@ static void snd_card_asihpi_pcm_timer_start(struct snd_pcm_substream *
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 	int expiry;
 
-	/* wait longer the first time, for samples to propagate */
 	expiry = (dpcm->pcm_count * HZ / dpcm->bytes_per_sec);
+	/* wait longer the first time, for samples to propagate */
 	expiry = max(expiry, 20);
 	dpcm->timer.expires = jiffies + expiry;
 	dpcm->respawn_timer = 1;
@@ -590,13 +584,12 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 				* buffer is bigger it may contain even more
 				* data??
 				*/
-				unsigned int preload = ds->pcm_count*2;
-				VPRINTK2("Preload x%x\n", preload);
+				unsigned int preload = ds->pcm_count * 2;
+				VPRINTK2("Preload %d\n", preload);
 				HPI_HandleError(HPI_OutStreamWriteBuf(phSubSys, ds->hStream,
 						&s->runtime->dma_area[0],
 						preload,
 						&ds->Format));
-				ds->pcm_irq_pos = ds->pcm_irq_pos + preload;
 			}
 
 			if (card->support_grouping) {
@@ -755,6 +748,9 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 					&dwBufferSize, &dwDataAvail,
 					&dwSamplesPlayed, &dwAux));
 
+		/* number of bytes in on-card buffer */
+		runtime->delay = dwAux;
+
 		if (wState == HPI_STATE_DRAINED) {
 			snd_printd(KERN_WARNING  "OStream %d drained\n",
 					s->number);
@@ -781,7 +777,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 				newdata);
 		}
 
-		VPRINTK1("PB timer hw_ptr x%04lX, appl_ptr x%04lX ",
+		VPRINTK1("PB timer hw_ptr x%04lX, appl_ptr x%04lX\n",
 			(unsigned long)frames_to_bytes(runtime,
 						runtime->status->hw_ptr),
 			(unsigned long)frames_to_bytes(runtime,
@@ -797,8 +793,8 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 	next_jiffies = ((dpcm->pcm_count-remdata) * HZ / dpcm->bytes_per_sec)+1;
 	next_jiffies = max(next_jiffies, 2U * HZ / 1000U);
 	dpcm->timer.expires = jiffies + next_jiffies;
-	VPRINTK1("jif %d buf pos x%04X newdata x%04X\n",
-			next_jiffies, min_buf_pos, newdata);
+	VPRINTK1("jif %d buf pos x%04X newdata x%04X xc x%04X\n",
+			next_jiffies, min_buf_pos, newdata, xfercount);
 
 	snd_pcm_group_for_each_entry(s, dpcm->substream) {
 		struct snd_card_asihpi_pcm *ds = s->runtime->private_data;
@@ -865,6 +861,7 @@ snd_card_asihpi_playback_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 	snd_pcm_uframes_t ptr;
+
 	u32 dwSamplesPlayed;
 	u16 err;
 
@@ -885,7 +882,7 @@ snd_card_asihpi_playback_pointer(struct snd_pcm_substream *substream)
 	 */
 
 	ptr = bytes_to_frames(runtime, dpcm->pcm_buf_pos  % dpcm->pcm_size);
-	VPRINTK2("Playback ptr x%04lx\n", (unsigned long)ptr);
+	VPRINTK2("playback_pointer=%04ld\n", (unsigned long)ptr);
 	return ptr;
 }
 
@@ -978,6 +975,9 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	snd_card_asihpi_pcm_samplerates(card,  &snd_card_asihpi_playback);
 
 	snd_card_asihpi_playback.info = SNDRV_PCM_INFO_INTERLEAVED |
+					SNDRV_PCM_INFO_DOUBLE |
+					SNDRV_PCM_INFO_BATCH |
+					SNDRV_PCM_INFO_BLOCK_TRANSFER |
 					SNDRV_PCM_INFO_PAUSE;
 
 	if (card->support_mmap)
@@ -996,15 +996,8 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		return err;
 
-	/* period must be at least 50ms.
-	   This means more bytes for more channels
-	    ?fixes asi5044 multichannel playback xruns
-	*/
-	/*
-	snd_pcm_hw_constraint_minmax(runtime,
-		SNDRV_PCM_HW_PARAM_PERIOD_TIME,
-		44000, UINT_MAX);
-	*/
+	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, card->update_interval_frames);
+	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, card->update_interval_frames * 4, UINT_MAX);
 
 	snd_pcm_set_sync(substream);
 
@@ -1097,7 +1090,7 @@ snd_card_asihpi_capture_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 
-	VPRINTK3("Capture pointer%d x%04x\n",
+	VPRINTK2("Capture pointer %d=%d\n",
 			substream->number, dpcm->pcm_buf_pos);
 	/* NOTE Unlike playback can't use actual dwSamplesPlayed
 		for the capture position, because those samples aren't yet in
@@ -1223,6 +1216,9 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		return err;
 
+	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, card->update_interval_frames);
+	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, card->update_interval_frames * 2, UINT_MAX);
+
 	snd_pcm_set_sync(substream);
 
 	return 0;
@@ -1660,7 +1656,7 @@ static int snd_asihpi_aesebu_format_info(struct snd_kcontrol *kcontrol,
 
 static int snd_asihpi_aesebu_format_get(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol,
-			u16 (*func)(struct hpi_hsubsys *, u32, u16 *))
+			u16 (*func)(const struct hpi_hsubsys *, u32, u16 *))
 {
 	u32 hControl = kcontrol->private_value;
 	u16 source, err;
@@ -1682,7 +1678,7 @@ static int snd_asihpi_aesebu_format_get(struct snd_kcontrol *kcontrol,
 
 static int snd_asihpi_aesebu_format_put(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol,
-			 u16 (*func)(struct hpi_hsubsys *, u32, u16))
+			 u16 (*func)(const struct hpi_hsubsys *, u32, u16))
 {
 	u32 hControl = kcontrol->private_value;
 
@@ -2860,18 +2856,31 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 	if (pcm_substreams < asihpi->wNumInStreams)
 		pcm_substreams = asihpi->wNumInStreams;
 
+	err = HPI_AdapterGetProperty(phSubSys, asihpi->wAdapterIndex,
+		HPI_ADAPTER_PROPERTY_CAPS1,
+		NULL, &asihpi->support_grouping);
+	if (err)
+		asihpi->support_grouping = 0;
+
+	err = HPI_AdapterGetProperty(phSubSys, asihpi->wAdapterIndex,
+		HPI_ADAPTER_PROPERTY_CAPS2,
+		&asihpi->support_mrx, NULL);
+	if (err)
+		asihpi->support_mrx = 0;
+
+	err = HPI_AdapterGetProperty(phSubSys, asihpi->wAdapterIndex,
+		HPI_ADAPTER_PROPERTY_INTERVAL,
+		NULL, &asihpi->update_interval_frames);
+	if (err)
+		asihpi->update_interval_frames = 512;
+
 	HPI_HandleError(HPI_InStreamOpen(phSubSys, asihpi->wAdapterIndex,
 			     0, &hStream));
 
-	err = HPI_InStreamGroupAdd(phSubSys, hStream, hStream);
-	asihpi->support_grouping = (!err);
-
 	err = HPI_InStreamHostBufferFree(phSubSys, hStream);
 	asihpi->support_mmap = (!err);
 
-	asihpi->support_mrx = (((asihpi->wType & 0xFF00) == 0x8900) ||
-			((asihpi->wType & 0xF000) == 0x6000));
-
+	HPI_HandleError(HPI_InStreamClose(phSubSys, hStream));
 
 	err = HPI_AdapterGetProperty(phSubSys, asihpi->wAdapterIndex,
 		HPI_ADAPTER_PROPERTY_CURCHANNELS,
@@ -2881,22 +2890,21 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 		asihpi->out_max_chans = 2;
 	}
 
-	printk(KERN_INFO "Supports mmap:%d grouping:%d mrx:%d\n",
+	snd_printk(KERN_INFO "Supports mmap:%d grouping:%d mrx:%d\n",
 			asihpi->support_mmap,
 			asihpi->support_grouping,
 			asihpi->support_mrx
 	      );
 
-	HPI_HandleError(HPI_InStreamClose(phSubSys, hStream));
 
 	err = snd_card_asihpi_pcm_new(asihpi, 0, pcm_substreams);
 	if (err < 0) {
-		printk(KERN_ERR "pcm_new failed\n");
+		snd_printk(KERN_ERR "pcm_new failed\n");
 		goto __nodev;
 	}
 	err = snd_card_asihpi_mixer_new(asihpi);
 	if (err < 0) {
-		printk(KERN_ERR "mixer_new failed\n");
+		snd_printk(KERN_ERR "mixer_new failed\n");
 		goto __nodev;
 	}
 
@@ -2930,7 +2938,7 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 	}
 __nodev:
 	snd_card_free(card);
-	printk(KERN_ERR "snd_asihpi_probe error %d\n", err);
+	snd_printk(KERN_ERR "snd_asihpi_probe error %d\n", err);
 	return err;
 
 }
@@ -2944,7 +2952,7 @@ static void __devexit snd_asihpi_remove(struct pci_dev *pci_dev)
 	asihpi_adapter_remove(pci_dev);
 }
 
-static struct pci_device_id  asihpi_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(asihpi_pci_tbl) = {
 	{HPI_PCI_VENDOR_ID_TI, HPI_PCI_DEV_ID_DSP6205,
 		HPI_PCI_VENDOR_ID_AUDIOSCIENCE, PCI_ANY_ID, 0, 0,
 		(kernel_ulong_t)HPI_6205},
-- 
1.7.0.rc0.8.ge3f67d
