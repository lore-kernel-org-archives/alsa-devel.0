From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH][asihpi] Meter control return peak.
Date: Tue, 17 Jun 2008 13:35:44 +1200
Message-ID: <200806171335.44469.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A9222446E
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 03:35:48 +0200 (CEST)
Received: from zaphod.local
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K2L00LPD33KPI20@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 17 Jun 2008 13:35:46 +1200 (NZST)
Content-disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use Peak meter instead of Rms meter because it is supported by all card 
families.
Minor checkpatch cleanups.

Signed-off-by: Eliot Blennerhassett <linux@audioscience.com>

---
diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index 8cbefab..ab90b08 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -383,15 +383,15 @@ static void snd_card_asihpi_pcm_samplerates(struct 
snd_card_asihpi *asihpi,
 		rate_max = 100000;
 	} else {
 		/* on cards without SRC,
-		    valid rates are determined by sampleclock */
+		   valid rates are determined by sampleclock */
 		err = HPI_MixerGetControl(phSubSys, asihpi->hMixer,
 					  HPI_SOURCENODE_CLOCK_SOURCE, 0, 0, 0,
 					  HPI_CONTROL_SAMPLECLOCK, &hControl);
 
 		for (idx = 0; idx < 100; idx++) {
 			if (HPI_ControlQuery(phSubSys, hControl,
-				HPI_SAMPLECLOCK_SAMPLERATE, idx, 0,
-				&sampleRate))
+					HPI_SAMPLECLOCK_SAMPLERATE,
+					idx, 0, &sampleRate))
 				break;
 
 			rate_min = min(rate_min, sampleRate);
@@ -443,7 +443,7 @@ static void snd_card_asihpi_pcm_samplerates(struct 
snd_card_asihpi *asihpi,
 		}
 	}
 
-	/*printk(KERN_INFO "Supported rates %X %d %d\n",
+	/* printk(KERN_INFO "Supported rates %X %d %d\n",
 	   rates, rate_min, rate_max); */
 	pcmhw->rates = rates;
 	pcmhw->rate_min = rate_min;
@@ -885,7 +885,7 @@ static void snd_card_asihpi_playback_format(struct 
snd_card_asihpi *asihpi,
 						u32 hStream,
 						struct snd_pcm_hardware *pcmhw)
 {
-  struct hpi_format hpi_format;
+	struct hpi_format hpi_format;
 	u16 wFormat;
 	u16 err;
 	u32 hControl;
@@ -1126,10 +1126,10 @@ static void snd_card_asihpi_capture_format(struct 
snd_card_asihpi *asihpi,
 	for (wFormat = HPI_FORMAT_PCM8_UNSIGNED;
 		wFormat <= HPI_FORMAT_PCM24_SIGNED; wFormat++) {
 
-		HPI_FormatCreate(
-			&hpi_format, 2, wFormat, dwSampleRate, 128000, 0);
-
-		err = HPI_InStreamQueryFormat(phSubSys, hStream,
+		HPI_FormatCreate(&hpi_format, 2, wFormat, dwSampleRate,
+						128000, 0);
+		err =
+		    HPI_InStreamQueryFormat(phSubSys, hStream,
 					    &hpi_format);
 		if (!err)
 			pcmhw->formats |=
@@ -2025,7 +2025,7 @@ static int snd_asihpi_meter_get(struct snd_kcontrol 
*kcontrol,
 	short anGain0_01dB[HPI_MAX_CHANNELS], i;
 	u16 err;
 
-	err = HPI_MeterGetRms(phSubSys, hControl, anGain0_01dB);
+	err = HPI_MeterGetPeak(phSubSys, hControl, anGain0_01dB);
 
 	for (i = 0; i < HPI_MAX_CHANNELS; i++) {
 #if ASIHPI_LINEAR_METERS
@@ -2796,7 +2796,7 @@ int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 	asihpi->support_mmap = (!err);
 
 	asihpi->support_mrx = (((asihpi->wType & 0xFF00) == 0x8900) ||
-					((asihpi->wType & 0xF000) == 0x6000));
+			((asihpi->wType & 0xF000) == 0x6000));
 
 
 	printk(KERN_INFO "Supports mmap:%d grouping:%d\n",

-- 
--
Eliot Blennerhassett
www.audioscience.com
