From: linux@audioscience.com
Subject: [PATCH - ASIHPI 8/8] Checkpatch tweaks
Date: Thu, 05 Jun 2008 16:07:01 +1200
Message-ID: <1212638821-2779-8-git-send-email-linux@audioscience.com>
References: <1212638821-2779-1-git-send-email-linux@audioscience.com>
	<1212638821-2779-2-git-send-email-linux@audioscience.com>
	<1212638821-2779-3-git-send-email-linux@audioscience.com>
	<1212638821-2779-4-git-send-email-linux@audioscience.com>
	<1212638821-2779-5-git-send-email-linux@audioscience.com>
	<1212638821-2779-6-git-send-email-linux@audioscience.com>
	<1212638821-2779-7-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 0808A10382B
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 06:07:20 +0200 (CEST)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K1Z0043N23FR170@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 05 Jun 2008 16:07:19 +1200 (NZST)
In-reply-to: <1212638821-2779-7-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index 3ffc47b..8cbefab 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -98,11 +98,11 @@ MODULE_PARM_DESC(enable_hpi_hwdep,
 
 /* identify driver */
 #ifdef KERNEL_ALSA_BUILD
-static char * build_info = "Built using headers from kernel source";
+static char *build_info = "Built using headers from kernel source";
 module_param(build_info, charp, S_IRUGO);
 MODULE_PARM_DESC(build_info, "Built using headers from kernel source");
 #else
-static char * build_info = "Built within ALSA source";
+static char *build_info = "Built within ALSA source";
 module_param(build_info, charp, S_IRUGO);
 MODULE_PARM_DESC(build_info, "Built within ALSA source");
 #endif
@@ -382,14 +382,16 @@ static void snd_card_asihpi_pcm_samplerates(struct snd_card_asihpi *asihpi,
 		rate_min = 8000;
 		rate_max = 100000;
 	} else {
-		/* on cards without SRC, valid rates are determined by sampleclock */
+		/* on cards without SRC,
+		    valid rates are determined by sampleclock */
 		err = HPI_MixerGetControl(phSubSys, asihpi->hMixer,
 					  HPI_SOURCENODE_CLOCK_SOURCE, 0, 0, 0,
 					  HPI_CONTROL_SAMPLECLOCK, &hControl);
 
-		for (idx=0; idx<100; idx++) {
-			if (HPI_ControlQuery(phSubSys, hControl, HPI_SAMPLECLOCK_SAMPLERATE,
-					idx, 0, &sampleRate))
+		for (idx = 0; idx < 100; idx++) {
+			if (HPI_ControlQuery(phSubSys, hControl,
+				HPI_SAMPLECLOCK_SAMPLERATE, idx, 0,
+				&sampleRate))
 				break;
 
 			rate_min = min(rate_min, sampleRate);
@@ -441,7 +443,8 @@ static void snd_card_asihpi_pcm_samplerates(struct snd_card_asihpi *asihpi,
 		}
 	}
 
-	/*printk(KERN_INFO "Supported rates %X %d %d\n", rates, rate_min, rate_max); */
+	/*printk(KERN_INFO "Supported rates %X %d %d\n",
+	   rates, rate_min, rate_max); */
 	pcmhw->rates = rates;
 	pcmhw->rate_min = rate_min;
 	pcmhw->rate_max = rate_max;
@@ -880,7 +883,7 @@ snd_card_asihpi_playback_pointer(struct snd_pcm_substream *substream)
 
 static void snd_card_asihpi_playback_format(struct snd_card_asihpi *asihpi,
 						u32 hStream,
-						struct snd_pcm_hardware * pcmhw)
+						struct snd_pcm_hardware *pcmhw)
 {
   struct hpi_format hpi_format;
 	u16 wFormat;
@@ -906,7 +909,8 @@ static void snd_card_asihpi_playback_format(struct snd_card_asihpi *asihpi,
 		err = HPI_OutStreamQueryFormat(phSubSys, hStream,
 					     &hpi_format);
 		if (!err && (hpi_to_alsa_formats[wFormat] != -1))
-			pcmhw->formats |= (1ULL << hpi_to_alsa_formats[wFormat]);
+			pcmhw->formats |=
+				(1ULL << hpi_to_alsa_formats[wFormat]);
 	}
 }
 
@@ -1122,12 +1126,14 @@ static void snd_card_asihpi_capture_format(struct snd_card_asihpi *asihpi,
 	for (wFormat = HPI_FORMAT_PCM8_UNSIGNED;
 		wFormat <= HPI_FORMAT_PCM24_SIGNED; wFormat++) {
 
-		HPI_FormatCreate(&hpi_format, 2, wFormat, dwSampleRate, 128000, 0);
-		err =
-		    HPI_InStreamQueryFormat(phSubSys, hStream,
+		HPI_FormatCreate(
+			&hpi_format, 2, wFormat, dwSampleRate, 128000, 0);
+
+		err = HPI_InStreamQueryFormat(phSubSys, hStream,
 					    &hpi_format);
 		if (!err)
-			pcmhw->formats |= (1ULL << hpi_to_alsa_formats[wFormat]);
+			pcmhw->formats |=
+				(1ULL << hpi_to_alsa_formats[wFormat]);
 	}
 }
 
@@ -2790,7 +2796,7 @@ int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 	asihpi->support_mmap = (!err);
 
 	asihpi->support_mrx = (((asihpi->wType & 0xFF00) == 0x8900) ||
-	                       ((asihpi->wType & 0xF000) == 0x6000));
+					((asihpi->wType & 0xF000) == 0x6000));
 
 
 	printk(KERN_INFO "Supports mmap:%d grouping:%d\n",
-- 
1.5.4.3
