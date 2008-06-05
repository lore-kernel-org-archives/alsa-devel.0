From: linux@audioscience.com
Subject: [PATCH - ASIHPI 2/8] Fix sampleclock source get. Fix
 volume control dB range.
Date: Thu, 05 Jun 2008 16:06:55 +1200
Message-ID: <1212638821-2779-2-git-send-email-linux@audioscience.com>
References: <1212638821-2779-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 87EF024579
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 06:07:02 +0200 (CEST)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K1Z0043N23FR170@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 05 Jun 2008 16:07:02 +1200 (NZST)
In-reply-to: <1212638821-2779-1-git-send-email-linux@audioscience.com>
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

From: Eliot Blennerhassett <linux@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index 538c771..3ffc47b 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -24,9 +24,6 @@
 /* >0: print Hw params, timer vars. >1: print stream write/copy sizes  */
 #define REALLY_VERBOSE_LOGGING 0
 
-/* Experimental HPI hwdep interface */
-#define EXPERIMENTAL_HWDEP 0
-
 #if REALLY_VERBOSE_LOGGING
 #define VPRINTK1 printk
 #else
@@ -50,7 +47,14 @@
 #define ASI_STYLE_NAMES 1
 #endif
 
+#ifndef KERNEL_ALSA_BUILD
+/* building in ALSA source tree */
 #include "adriver.h"
+#else
+/* building in kernel tree */
+#include <sound/driver.h>
+#endif
+
 #include <linux/pci.h>
 #include <linux/version.h>
 #include <linux/init.h>
@@ -68,11 +72,16 @@
 #include <sound/hwdep.h>
 
 #include "hpi.h"
+#include "hpioctl.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("AudioScience Inc. <support@audioscience.com>");
+MODULE_DESCRIPTION("AudioScience ALSA ASI5000 ASI6000 ASI87xx ASI89xx");
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
-static int enable_hpi_hwdep;
+static int enable_hpi_hwdep = 1;
 
 module_param_array(index, int, NULL, S_IRUGO);
 MODULE_PARM_DESC(index, "ALSA Index value for AudioScience soundcard.");
@@ -85,15 +94,18 @@ MODULE_PARM_DESC(enable, "ALSA Enable AudioScience soundcard.");
 
 module_param(enable_hpi_hwdep, bool, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(enable_hpi_hwdep,
-		"ALSA Enable HPI hwdep for AudioScience soundcard "
-		"(experimental)");
-
-/* used by hpimod.c, stop sparse from complaining */
-int snd_asihpi_bind(struct hpi_adapter *hpi_card);
-void snd_asihpi_unbind(struct hpi_adapter *hpi_card);
+		"ALSA Enable HPI hwdep for AudioScience soundcard ");
 
-/* index base 0 or 1 for control names or indices */
-static const int ixb;
+/* identify driver */
+#ifdef KERNEL_ALSA_BUILD
+static char * build_info = "Built using headers from kernel source";
+module_param(build_info, charp, S_IRUGO);
+MODULE_PARM_DESC(build_info, "Built using headers from kernel source");
+#else
+static char * build_info = "Built within ALSA source";
+module_param(build_info, charp, S_IRUGO);
+MODULE_PARM_DESC(build_info, "Built within ALSA source");
+#endif
 
 /* set to 1 to dump every control from adapter to log */
 static const int mixer_dump;
@@ -142,6 +154,7 @@ struct snd_card_asihpi {
 
 	int support_mmap;
 	int support_grouping;
+	int support_mrx;
 };
 
 /* Per stream data */
@@ -352,6 +365,89 @@ static int snd_card_asihpi_format_alsa2hpi(snd_pcm_format_t alsaFormat,
 	return -EINVAL;
 }
 
+static void snd_card_asihpi_pcm_samplerates(struct snd_card_asihpi *asihpi,
+					 struct snd_pcm_hardware *pcmhw)
+{
+	u16 err;
+	u32 hControl;
+	u32 sampleRate;
+	int idx;
+	unsigned int rate_min = 200000;
+	unsigned int rate_max = 0;
+	unsigned int rates = 0;
+
+	if (asihpi->support_mrx) {
+		rates |= SNDRV_PCM_RATE_CONTINUOUS;
+		rates |= SNDRV_PCM_RATE_8000_96000;
+		rate_min = 8000;
+		rate_max = 100000;
+	} else {
+		/* on cards without SRC, valid rates are determined by sampleclock */
+		err = HPI_MixerGetControl(phSubSys, asihpi->hMixer,
+					  HPI_SOURCENODE_CLOCK_SOURCE, 0, 0, 0,
+					  HPI_CONTROL_SAMPLECLOCK, &hControl);
+
+		for (idx=0; idx<100; idx++) {
+			if (HPI_ControlQuery(phSubSys, hControl, HPI_SAMPLECLOCK_SAMPLERATE,
+					idx, 0, &sampleRate))
+				break;
+
+			rate_min = min(rate_min, sampleRate);
+			rate_max = max(rate_max, sampleRate);
+
+			switch (sampleRate) {
+			case 5512:
+				rates |= SNDRV_PCM_RATE_5512;
+				break;
+			case 8000:
+				rates |= SNDRV_PCM_RATE_8000;
+				break;
+			case 11025:
+				rates |= SNDRV_PCM_RATE_11025;
+				break;
+			case 16000:
+				rates |= SNDRV_PCM_RATE_16000;
+				break;
+			case 22050:
+				rates |= SNDRV_PCM_RATE_22050;
+				break;
+			case 32000:
+				rates |= SNDRV_PCM_RATE_32000;
+				break;
+			case 44100:
+				rates |= SNDRV_PCM_RATE_44100;
+				break;
+			case 48000:
+				rates |= SNDRV_PCM_RATE_48000;
+				break;
+			case 64000:
+				rates |= SNDRV_PCM_RATE_64000;
+				break;
+			case 88200:
+				rates |= SNDRV_PCM_RATE_88200;
+				break;
+			case 96000:
+				rates |= SNDRV_PCM_RATE_96000;
+				break;
+			case 176400:
+				rates |= SNDRV_PCM_RATE_176400;
+				break;
+			case 192000:
+				rates |= SNDRV_PCM_RATE_192000;
+				break;
+			default: /* some other rate */
+				rates |= SNDRV_PCM_RATE_KNOT;
+			}
+		}
+	}
+
+	/*printk(KERN_INFO "Supported rates %X %d %d\n", rates, rate_min, rate_max); */
+	pcmhw->rates = rates;
+	pcmhw->rate_min = rate_min;
+	pcmhw->rate_max = rate_max;
+
+}
+
 static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 					 struct snd_pcm_hw_params *params)
 {
@@ -784,7 +880,7 @@ snd_card_asihpi_playback_pointer(struct snd_pcm_substream *substream)
 
 static void snd_card_asihpi_playback_format(struct snd_card_asihpi *asihpi,
 						u32 hStream,
-						u64 *formats)
+						struct snd_pcm_hardware * pcmhw)
 {
   struct hpi_format hpi_format;
 	u16 wFormat;
@@ -810,7 +906,7 @@ static void snd_card_asihpi_playback_format(struct snd_card_asihpi *asihpi,
 		err = HPI_OutStreamQueryFormat(phSubSys, hStream,
 					     &hpi_format);
 		if (!err && (hpi_to_alsa_formats[wFormat] != -1))
-			*formats |= (1ULL << hpi_to_alsa_formats[wFormat]);
+			pcmhw->formats |= (1ULL << hpi_to_alsa_formats[wFormat]);
 	}
 }
 
@@ -860,11 +956,10 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	runtime->private_free = snd_card_asihpi_runtime_free;
 
 	snd_card_asihpi_playback_format(card, dpcm->hStream,
-					&snd_card_asihpi_playback.formats);
-	snd_card_asihpi_playback.rates = SNDRV_PCM_RATE_CONTINUOUS |
-					SNDRV_PCM_RATE_8000_192000;
-	snd_card_asihpi_playback.rate_min = 5500;
-	snd_card_asihpi_playback.rate_max = 192000;
+					&snd_card_asihpi_playback);
+
+	snd_card_asihpi_pcm_samplerates(card,  &snd_card_asihpi_playback);
+
 	snd_card_asihpi_playback.info = SNDRV_PCM_INFO_INTERLEAVED |
 					SNDRV_PCM_INFO_PAUSE;
 
@@ -1006,12 +1101,13 @@ static int snd_card_asihpi_capture_prepare(struct snd_pcm_substream *substream)
 
 static void snd_card_asihpi_capture_format(struct snd_card_asihpi *asihpi,
 					u32 hStream,
-					u64 *formats)
+					 struct snd_pcm_hardware *pcmhw)
 {
   struct hpi_format hpi_format;
 	u16 wFormat;
 	u16 err;
 	u32 hControl;
+	u32 dwSampleRate = 48000;
 
 	/* on cards without SRC, must query at valid rate,
 		maybe set by external sync */
@@ -1021,20 +1117,21 @@ static void snd_card_asihpi_capture_format(struct snd_card_asihpi *asihpi,
 
 	if (!err)
 		err = HPI_SampleClock_GetSampleRate(phSubSys, hControl,
-			&hpi_format.dwSampleRate);
+			&dwSampleRate);
 
 	for (wFormat = HPI_FORMAT_PCM8_UNSIGNED;
 		wFormat <= HPI_FORMAT_PCM24_SIGNED; wFormat++) {
 
-		HPI_FormatCreate(&hpi_format, 2, wFormat, 48000, 128000, 0);
+		HPI_FormatCreate(&hpi_format, 2, wFormat, dwSampleRate, 128000, 0);
 		err =
 		    HPI_InStreamQueryFormat(phSubSys, hStream,
 					    &hpi_format);
 		if (!err)
-			*formats |= (1ULL << hpi_to_alsa_formats[wFormat]);
+			pcmhw->formats |= (1ULL << hpi_to_alsa_formats[wFormat]);
 	}
 }
 
+
 static struct snd_pcm_hardware snd_card_asihpi_capture = {
 	.channels_min = 1,
 	.channels_max = 2,
@@ -1079,12 +1176,11 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	runtime->private_free = snd_card_asihpi_runtime_free;
 
 	snd_card_asihpi_capture_format(card, dpcm->hStream,
-				       &snd_card_asihpi_capture.formats);
-	snd_card_asihpi_capture.rates = SNDRV_PCM_RATE_CONTINUOUS |
-					SNDRV_PCM_RATE_8000_192000;
-	snd_card_asihpi_capture.rate_min = 5500;
-	snd_card_asihpi_capture.rate_max = 192000;
+				       &snd_card_asihpi_capture);
+
+	snd_card_asihpi_pcm_samplerates(card,  &snd_card_asihpi_capture);
 	snd_card_asihpi_capture.info = SNDRV_PCM_INFO_INTERLEAVED;
+
 	if (card->support_mmap)
 		snd_card_asihpi_capture.info |= SNDRV_PCM_INFO_MMAP |
 						SNDRV_PCM_INFO_MMAP_VALID;
@@ -1300,50 +1396,29 @@ static inline int ctl_add(struct snd_card *card, struct snd_kcontrol_new *ctl,
 	return 0;
 }
 
+/* Convert HPI control name and location into ALSA control name */
 static void asihpi_ctl_name(struct snd_kcontrol_new *snd_control,
 				struct hpi_control *asihpi_control,
 				char *name)
 {
-#if 1
-/* entire control ID is a string */
 	if (asihpi_control->wSrcNodeType && asihpi_control->wDstNodeType)
 		sprintf(snd_control->name, "%s%d to %s%d %s",
 			asihpi_src_names[asihpi_control->wSrcNodeType],
-			asihpi_control->wSrcNodeIndex + ixb,
+			asihpi_control->wSrcNodeIndex,
 			asihpi_dst_names[asihpi_control->wDstNodeType],
-			asihpi_control->wDstNodeIndex + ixb,
+			asihpi_control->wDstNodeIndex,
 			name);
 	else if (asihpi_control->wDstNodeType) {
 		sprintf(snd_control->name, "%s%d %s",
 		asihpi_dst_names[asihpi_control->wDstNodeType],
-		asihpi_control->wDstNodeIndex + ixb,
+		asihpi_control->wDstNodeIndex,
 		name);
 	} else {
 		sprintf(snd_control->name, "%s%d %s",
 		asihpi_src_names[asihpi_control->wSrcNodeType],
-		asihpi_control->wSrcNodeIndex + ixb,
+		asihpi_control->wSrcNodeIndex,
 		name);
 	}
-#else
-/* use string plus index of destination or only node */
-	snd_control->index = asihpi_control->wDstNodeIndex + ixb;
-	if (asihpi_control->wSrcNodeType && asihpi_control->wDstNodeType)
-		sprintf(snd_control->name, "%s%d to %s %s",
-			asihpi_src_names[asihpi_control->wSrcNodeType],
-			asihpi_control->wSrcNodeIndex + ixb,
-			asihpi_dst_names[asihpi_control->wDstNodeType],
-			name);
-	else if (asihpi_control->wDstNodeType)
-		sprintf(snd_control->name, "%s %s",
-		asihpi_dst_names[asihpi_control->wDstNodeType],
-		name);
-	else {
-		sprintf(snd_control->name, "%s %s",
-		asihpi_src_names[asihpi_control->wSrcNodeType],
-		name);
-		snd_control->index = asihpi_control->wSrcNodeIndex + ixb;
-	}
-#endif
 }
 
 /*------------------------------------------------------------
@@ -2041,7 +2116,7 @@ static int snd_asihpi_mux_info(struct snd_kcontrol *kcontrol,
 
 	sprintf(uinfo->value.enumerated.name, "%s %d",
 		asihpi_src_names[wSrcNodeType - HPI_SOURCENODE_BASE],
-		wSrcNodeIndex + ixb);
+		wSrcNodeIndex);
 	return 0;
 }
 
@@ -2201,15 +2276,16 @@ static int snd_asihpi_clksrc_get(struct snd_kcontrol *kcontrol,
 			(struct snd_card_asihpi *)(kcontrol->private_data);
 	struct clk_cache *clkcache = &asihpi->cc;
 	u32 hControl = kcontrol->private_value;
-	u16 wSource, wIndex;
+	u16 wSource, wIndex = 0;
 	int i;
 
 	ucontrol->value.enumerated.item[0] = 0;
-	/*Get current clock source, return "N/A" if an error occurs*/
 	if (HPI_SampleClock_GetSource(phSubSys, hControl, &wSource))
 		wSource = 0;
-	if (HPI_SampleClock_GetSourceIndex(phSubSys, hControl, &wIndex))
-		wIndex = 0;
+
+	if (wSource == HPI_SAMPLECLOCK_SOURCE_AESEBU_INPUT)
+		if (HPI_SampleClock_GetSourceIndex(phSubSys, hControl, &wIndex))
+			wIndex = 0;
 
 	for (i = 0; i < clkcache->count; i++)
 		if ((clkcache->s[i].source == wSource) &&
@@ -2290,6 +2366,7 @@ static void __devinit snd_asihpi_clksrc_new(struct snd_card_asihpi *asihpi,
 /*------------------------------------------------------------
    Clkrate controls
  ------------------------------------------------------------*/
+/* Need to change this to enumerated control with list of rates */
 static int snd_asihpi_clklocal_info(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_info *uinfo)
 {
@@ -2335,6 +2412,8 @@ static void __devinit snd_asihpi_clklocal_new(
 	snd_control->info = snd_asihpi_clklocal_info;
 	snd_control->get = snd_asihpi_clklocal_get;
 	snd_control->put = snd_asihpi_clklocal_put;
+	snd_control->access = SNDRV_CTL_ELEM_ACCESS_READWRITE ;
+
 
 	asihpi_ctl_name(snd_control, asihpi_control, "LocalRate");
 }
@@ -2425,9 +2504,7 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 		asihpi_control.wDstNodeType -= HPI_DESTNODE_BASE;
 		snd_control.index = 0;
 		snd_control.private_value = hControl;
-		snd_control.access =
-		    SNDRV_CTL_ELEM_ACCESS_WRITE |
-		    SNDRV_CTL_ELEM_ACCESS_READ;
+		snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE ;
 		switch (asihpi_control.wControlType) {
 		case HPI_CONTROL_VOLUME:
 			snd_asihpi_volume_new(&asihpi_control,
@@ -2576,29 +2653,36 @@ static void __devinit snd_asihpi_proc_init(struct snd_card_asihpi *asihpi)
 
 static int snd_asihpi_hpi_open(struct snd_hwdep *hw, struct file *file)
 {
-	return 0;
+	if (enable_hpi_hwdep)
+		return 0;
+	else
+		return -ENODEV;
+
 }
 
 static int snd_asihpi_hpi_release(struct snd_hwdep *hw, struct file *file)
 {
-	return 0;
+	if (enable_hpi_hwdep)
+		return asihpi_hpi_release(file);
+	else
+		return -ENODEV;
 }
 
-long asihpi_hpi_ioctl(struct file *file,
-	  unsigned int cmd, unsigned long arg);
-
 static int snd_asihpi_hpi_ioctl(struct snd_hwdep *hw, struct file *file,
 				unsigned int cmd, unsigned long arg)
 {
-	return asihpi_hpi_ioctl(file, cmd, arg);
+	if (enable_hpi_hwdep)
+		return asihpi_hpi_ioctl(file, cmd, arg);
+	else
+		return -ENODEV;
 }
 
 
 /* results in /dev/snd/hwC#D0 file for each card with index #
    also /proc/asound/hwdep will contain '#-00: asihpi (HPI) for each card'
 */
-int __devinit snd_asihpi_hpi_new(struct snd_card_asihpi *asihpi, int device,
-				struct snd_hwdep **rhwdep)
+static int __devinit snd_asihpi_hpi_new(struct snd_card_asihpi *asihpi,
+	int device, struct snd_hwdep **rhwdep)
 {
 	struct snd_hwdep *hw;
 	int err;
@@ -2622,13 +2706,15 @@ int __devinit snd_asihpi_hpi_new(struct snd_card_asihpi *asihpi, int device,
 /*------------------------------------------------------------
    CARD
  ------------------------------------------------------------*/
-int __devinit snd_asihpi_bind(struct hpi_adapter *hpi_card)
+int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
+				       const struct pci_device_id *pci_id)
 {
 	int err;
 
 	u16 wVersion;
 	int pcm_substreams;
 
+	struct hpi_adapter *hpi_card;
 	struct snd_card *card;
 	struct snd_card_asihpi *asihpi;
 
@@ -2645,6 +2731,12 @@ int __devinit snd_asihpi_bind(struct hpi_adapter *hpi_card)
 		return -ENOENT;
 	}
 
+	err = asihpi_adapter_probe(pci_dev, pci_id);
+	if (err < 0)
+		return err;
+
+	hpi_card = pci_get_drvdata(pci_dev);
+
 	/* first try to give the card the same index as its hardware index */
 	card = snd_card_new(hpi_card->index,
 			id[hpi_card->index], THIS_MODULE,
@@ -2672,8 +2764,9 @@ int __devinit snd_asihpi_bind(struct hpi_adapter *hpi_card)
 				 &asihpi->wNumInStreams,
 				 &asihpi->wVersion,
 				 &asihpi->dwSerialNumber, &asihpi->wType));
+
 	wVersion = asihpi->wVersion;
-	snd_printk(KERN_INFO "Adapter ID=%4X Index=%d NumOutStreams=%d"
+	snd_printk(KERN_INFO "Adapter ID=%4X Index=%d NumOutStreams=%d "
 			"NumInStreams=%d S/N=%d\n"
 			"Hw Version %c%d DSP code version %03d\n",
 			asihpi->wType, asihpi->wAdapterIndex,
@@ -2695,6 +2788,11 @@ int __devinit snd_asihpi_bind(struct hpi_adapter *hpi_card)
 
 	err = HPI_InStreamHostBufferFree(phSubSys, hStream);
 	asihpi->support_mmap = (!err);
+
+	asihpi->support_mrx = (((asihpi->wType & 0xFF00) == 0x8900) ||
+	                       ((asihpi->wType & 0xF000) == 0x6000));
+
+
 	printk(KERN_INFO "Supports mmap:%d grouping:%d\n",
 			asihpi->support_mmap, asihpi->support_grouping);
 
@@ -2717,8 +2815,9 @@ int __devinit snd_asihpi_bind(struct hpi_adapter *hpi_card)
 
 	snd_asihpi_proc_init(asihpi);
 
-	if (enable_hpi_hwdep)
-		snd_asihpi_hpi_new(asihpi, 0, NULL);
+	/* always create, can be enabled or disabled dynamically
+	    by enable_hwdep  module param*/
+	snd_asihpi_hpi_new(asihpi, 0, NULL);
 
 	if (asihpi->support_mmap)
 		strcpy(card->driver, "ASIHPI-MMAP");
@@ -2727,7 +2826,7 @@ int __devinit snd_asihpi_bind(struct hpi_adapter *hpi_card)
 
 	sprintf(card->shortname, "AudioScience ASI%4X", asihpi->wType);
 	sprintf(card->longname, "%s %i",
-			card->shortname, asihpi->wAdapterIndex + ixb);
+			card->shortname, asihpi->wAdapterIndex);
 	err = snd_card_register(card);
 	if (!err) {
 		hpi_card->snd_card_asihpi = card;
@@ -2740,8 +2839,50 @@ __nodev:
 
 }
 
-void snd_asihpi_unbind(struct hpi_adapter *hpi_card)
+static void __devexit snd_asihpi_remove(struct pci_dev *pci_dev)
 {
+	struct hpi_adapter *hpi_card = pci_get_drvdata(pci_dev);
+
 	snd_card_free(hpi_card->snd_card_asihpi);
 	hpi_card->snd_card_asihpi = NULL;
+	asihpi_adapter_remove(pci_dev);
+}
+
+struct pci_device_id  asihpi_pci_tbl[] = {
+	{HPI_PCI_VENDOR_ID_TI, HPI_ADAPTER_DSP6205,
+		HPI_PCI_VENDOR_ID_AUDIOSCIENCE, PCI_ANY_ID, 0, 0,
+		(kernel_ulong_t)HPI_6205},
+	{HPI_PCI_VENDOR_ID_TI, HPI_ADAPTER_PCI2040,
+		HPI_PCI_VENDOR_ID_AUDIOSCIENCE, PCI_ANY_ID, 0, 0,
+		(kernel_ulong_t)HPI_6000},
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, asihpi_pci_tbl);
+
+static struct pci_driver driver = {
+	.name = "asihpi",
+	.id_table = asihpi_pci_tbl,
+	.probe = snd_asihpi_probe,
+	.remove = __devexit_p(snd_asihpi_remove),
+#ifdef CONFIG_PM
+/*	.suspend = snd_asihpi_suspend,
+	.resume = snd_asihpi_resume, */
+#endif
+};
+
+static int __init snd_asihpi_init(void)
+{
+	asihpi_init();
+	return pci_register_driver(&driver);
 }
+
+static void __exit snd_asihpi_exit(void)
+{
+
+	pci_unregister_driver(&driver);
+	asihpi_exit();
+}
+
+module_init(snd_asihpi_init)
+module_exit(snd_asihpi_exit)
+
-- 
1.5.4.3
