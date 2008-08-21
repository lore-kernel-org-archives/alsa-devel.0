From: linux@audioscience.com
Subject: [PATCH - asihpi 3/3] Add support for ASI50xx SSX
	(multichannel) mode.
Date: Thu, 21 Aug 2008 13:29:56 +1200
Message-ID: <1219282196-20834-3-git-send-email-linux@audioscience.com>
References: <1219282196-20834-1-git-send-email-linux@audioscience.com>
	<1219282196-20834-2-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1219282196-20834-2-git-send-email-linux@audioscience.com>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@zaphod.clear.net.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@zaphod.(none)>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index 69d422c..584310c 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -157,6 +157,8 @@ struct snd_card_asihpi {
 	int support_mmap;
 	int support_grouping;
 	int support_mrx;
+	u16 in_max_chans;
+	u16 out_max_chans;
 };
 
 /* Per stream data */
@@ -320,7 +322,6 @@ static void print_hwparams(struct snd_pcm_hw_params *p)
 	snd_printd("period_size %d \n", params_period_size(p));
 	snd_printd("periods %d \n", params_periods(p));
 	snd_printd("buffer_size %d \n", params_buffer_size(p));
-	snd_printd("tick_time %d \n", params_tick_time(p));
 }
 #else
 #define print_hwparams(x)
@@ -394,11 +395,18 @@ static void snd_card_asihpi_pcm_samplerates(struct snd_card_asihpi *asihpi,
 		err = HPI_MixerGetControl(phSubSys, asihpi->hMixer,
 					  HPI_SOURCENODE_CLOCK_SOURCE, 0, 0, 0,
 					  HPI_CONTROL_SAMPLECLOCK, &hControl);
+		if (err) {
+			printk(KERN_ERR "No local sampleclock, err %d\n", err);
+		}
 
 		for (idx = 0; idx < 100; idx++) {
 			if (HPI_SampleClock_QueryLocalRate(phSubSys, hControl,
-					idx, &sampleRate))
+					idx, &sampleRate)) {
+				if (!idx)
+					printk(KERN_ERR "Local rate query failed\n");
+
 				break;
+			}
 
 			rate_min = min(rate_min, sampleRate);
 			rate_max = max(rate_max, sampleRate);
@@ -965,6 +973,7 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	runtime->private_data = dpcm;
 	runtime->private_free = snd_card_asihpi_runtime_free;
 
+	snd_card_asihpi_playback.channels_max = card->out_max_chans;
 	snd_card_asihpi_playback_format(card, dpcm->hStream,
 					&snd_card_asihpi_playback);
 
@@ -980,10 +989,11 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	if (card->support_grouping)
 		snd_card_asihpi_playback.info |= SNDRV_PCM_INFO_SYNC_START;
 
-	/* struct copy so can create initializer dynamically */
+	/* struct is copied, so can create initializer dynamically */
 	runtime->hw = snd_card_asihpi_playback;
-	/* Strictly only necessary for HPI6205 adapters */
-	err = snd_pcm_hw_constraint_pow2(runtime, 0,
+
+	if (card->support_mmap)
+		err = snd_pcm_hw_constraint_pow2(runtime, 0,
 					SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
 	if (err < 0)
 		return err;
@@ -1187,9 +1197,9 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	runtime->private_data = dpcm;
 	runtime->private_free = snd_card_asihpi_runtime_free;
 
+	snd_card_asihpi_capture.channels_max = card->in_max_chans;
 	snd_card_asihpi_capture_format(card, dpcm->hStream,
 				       &snd_card_asihpi_capture);
-
 	snd_card_asihpi_pcm_samplerates(card,  &snd_card_asihpi_capture);
 	snd_card_asihpi_capture.info = SNDRV_PCM_INFO_INTERLEAVED;
 
@@ -1199,8 +1209,8 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 
 	runtime->hw = snd_card_asihpi_capture;
 
-	/* Strictly only necessary for HPI6205 adapters */
-	err = snd_pcm_hw_constraint_pow2(runtime, 0,
+	if (card->support_mmap)
+		err = snd_pcm_hw_constraint_pow2(runtime, 0,
 					SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
 	if (err < 0)
 		return err;
@@ -2132,7 +2142,7 @@ static int snd_asihpi_meter_get(struct snd_kcontrol *kcontrol,
 }
 
 static int __devinit snd_asihpi_meter_add(struct snd_card_asihpi *asihpi,
-					struct hpi_control *asihpi_control)
+					struct hpi_control *asihpi_control, int subidx)
 {
 	struct snd_card *card = asihpi->card;
 	struct snd_kcontrol_new snd_control;
@@ -2143,7 +2153,9 @@ static int __devinit snd_asihpi_meter_add(struct snd_card_asihpi *asihpi,
 	snd_control.info = snd_asihpi_meter_info;
 	snd_control.get = snd_asihpi_meter_get;
 
-	return (ctl_add(card, &snd_control, asihpi));
+	snd_control.index = subidx;
+
+	return ctl_add(card, &snd_control, asihpi);
 }
 
 /*------------------------------------------------------------
@@ -2559,8 +2571,9 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 {
 	struct snd_card *card = asihpi->card;
 	unsigned int idx = 0;
+	unsigned int subindex = 0;
 	int err;
-	struct hpi_control asihpi_control;
+	struct hpi_control asihpi_control, prev_control;
 
 	if (snd_BUG_ON(!asihpi))
 		return -EINVAL;
@@ -2597,6 +2610,21 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 		asihpi_control.wSrcNodeType -= HPI_SOURCENODE_BASE;
 		asihpi_control.wDstNodeType -= HPI_DESTNODE_BASE;
 
+		/* ASI50xx in SSX mode has multiple meters on the same node.
+		   Use subindex to create distinct ALSA controls
+		   for any duplicated controls.
+		*/
+		if ((asihpi_control.wControlType == prev_control.wControlType) &&
+		    (asihpi_control.wSrcNodeType == prev_control.wSrcNodeType) &&
+		    (asihpi_control.wSrcNodeIndex == prev_control.wSrcNodeIndex) &&
+		    (asihpi_control.wDstNodeType == prev_control.wDstNodeType) &&
+		    (asihpi_control.wDstNodeIndex == prev_control.wDstNodeIndex))
+			subindex++;
+		else
+			subindex = 0;
+
+		prev_control = asihpi_control;
+
 		switch (asihpi_control.wControlType) {
 		case HPI_CONTROL_VOLUME:
 			err = snd_asihpi_volume_add(asihpi, &asihpi_control);
@@ -2611,7 +2639,7 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 			err = snd_asihpi_cmode_add(asihpi, &asihpi_control);
 			break;
 		case HPI_CONTROL_METER:
-			err = snd_asihpi_meter_add(asihpi, &asihpi_control);
+			err = snd_asihpi_meter_add(asihpi, &asihpi_control, subindex);
 			break;
 		case HPI_CONTROL_SAMPLECLOCK:
 			err = snd_asihpi_sampleclock_add(
@@ -2857,8 +2885,19 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 			((asihpi->wType & 0xF000) == 0x6000));
 
 
-	printk(KERN_INFO "Supports mmap:%d grouping:%d\n",
-			asihpi->support_mmap, asihpi->support_grouping);
+	err = HPI_AdapterGetProperty(phSubSys, asihpi->wAdapterIndex,
+		HPI_ADAPTER_PROPERTY_CURCHANNELS,
+		&asihpi->in_max_chans, &asihpi->out_max_chans);
+	if (err) {
+		asihpi->in_max_chans = 2;
+		asihpi->out_max_chans = 2;
+	}
+
+	printk(KERN_INFO "Supports mmap:%d grouping:%d mrx%d\n",
+			asihpi->support_mmap,
+			asihpi->support_grouping,
+			asihpi->support_mrx
+	      );
 
 	HPI_InStreamClose(phSubSys, hStream);
 
-- 
1.5.4.3
