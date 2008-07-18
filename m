From: linux@audioscience.com
Subject: [PATCH - asihpi 3/5] use new query functions
Date: Fri, 18 Jul 2008 18:00:17 +1200
Message-ID: <1216360819-1847-3-git-send-email-linux@audioscience.com>
References: <1216360819-1847-1-git-send-email-linux@audioscience.com>
	<1216360819-1847-2-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1216360819-1847-2-git-send-email-linux@audioscience.com>
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
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index f9fe449..31dd144 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -47,6 +47,9 @@
 #define ASI_STYLE_NAMES 1
 #endif
 
+#include "hpi_internal.h"
+#include "hpioctl.h"
+
 #ifndef KERNEL_ALSA_BUILD
 /* building in ALSA source tree */
 #include "adriver.h"
@@ -71,8 +74,6 @@
 #include <sound/tlv.h>
 #include <sound/hwdep.h>
 
-#include "hpi.h"
-#include "hpioctl.h"
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("AudioScience Inc. <support@audioscience.com>");
@@ -185,14 +186,13 @@ static u16 HPI_StreamHostBufferAttach(
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+	unsigned int obj = HPI_HandleObject(hStream);
 
 	if (!hStream)
 		return HPI_ERROR_INVALID_OBJ;
-	if (HPI_HandleObject(hStream) ==  HPI_OBJ_OSTREAM)
-		HPI_InitMessage(&hm,  HPI_OBJ_OSTREAM,
-				HPI_OSTREAM_HOSTBUFFER_ALLOC);
-	else
-		HPI_InitMessage(&hm,  HPI_OBJ_ISTREAM,
+	HPI_InitMessage(&hm,  obj,
+			obj == HPI_OBJ_OSTREAM ?
+				HPI_OSTREAM_HOSTBUFFER_ALLOC :
 				HPI_ISTREAM_HOSTBUFFER_ALLOC);
 
 	HPI_HandleToIndexes(hStream, &hm.wAdapterIndex,
@@ -212,16 +212,15 @@ static u16 HPI_StreamHostBufferDetach(
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+	unsigned int obj = HPI_HandleObject(hStream);
 
 	if (!hStream)
 		return HPI_ERROR_INVALID_OBJ;
 
-	if (HPI_HandleObject(hStream) ==  HPI_OBJ_OSTREAM)
-		HPI_InitMessage(&hm,  HPI_OBJ_OSTREAM,
-					HPI_OSTREAM_HOSTBUFFER_FREE);
-	else
-		HPI_InitMessage(&hm,  HPI_OBJ_ISTREAM,
-					HPI_ISTREAM_HOSTBUFFER_FREE);
+	HPI_InitMessage(&hm,  obj,
+			obj == HPI_OBJ_OSTREAM ?
+				HPI_OSTREAM_HOSTBUFFER_FREE :
+				HPI_ISTREAM_HOSTBUFFER_FREE);
 
 	HPI_HandleToIndexes(hStream, &hm.wAdapterIndex,
 				&hm.u.d.wStreamIndex, NULL);
@@ -396,9 +395,8 @@ static void snd_card_asihpi_pcm_samplerates(struct snd_card_asihpi *asihpi,
 					  HPI_CONTROL_SAMPLECLOCK, &hControl);
 
 		for (idx = 0; idx < 100; idx++) {
-			if (HPI_ControlQuery(phSubSys, hControl,
-					HPI_SAMPLECLOCK_SAMPLERATE,
-					idx, 0, &sampleRate))
+			if (HPI_SampleClock_QueryLocalRate(phSubSys, hControl,
+					idx, &sampleRate))
 				break;
 
 			rate_min = min(rate_min, sampleRate);
@@ -1311,6 +1309,7 @@ struct hpi_control {
 	u16 wDstNodeType;
 	u16 wDstNodeIndex;
 	u16 wBand;
+	char name[44]; /* copied to snd_ctl_elem_id.name[44]; */
 };
 
 static char *asihpi_tuner_band_names[] =
@@ -1346,6 +1345,7 @@ static char *asihpi_src_names[] =
 	"Bitstr",
 	"Mic",
 	"Cobranet",
+	"AnalogIn",
 };
 #else
 static char *asihpi_src_names[] =
@@ -1360,10 +1360,13 @@ static char *asihpi_src_names[] =
 	"Bitstream",
 	"Mic",
 	"Cobranet in",
+	"Analog in",
 };
 #endif
 
-#define NUM_SOURCENODE_STRINGS 10
+#if ((11 != (HPI_SOURCENODE_LAST_INDEX-HPI_SOURCENODE_BASE+1)))
+#error "SourceNode strings don't agree with HPI defines - version mismatch?"
+#endif
 
 #if ASI_STYLE_NAMES
 static char *asihpi_dst_names[] =
@@ -1375,6 +1378,7 @@ static char *asihpi_dst_names[] =
 	"RF",
 	"Speaker" ,
 	"Cobranet",
+	"AnalogOut",
 };
 #else
 static char *asihpi_dst_names[] =
@@ -1386,17 +1390,14 @@ static char *asihpi_dst_names[] =
 	"RF",
 	"Speaker",
 	"Cobranet out",
+	"Analog out",
 };
 #endif
-#define NUM_DESTNODE_STRINGS 7
 
-#if ((NUM_SOURCENODE_STRINGS != \
-	(HPI_SOURCENODE_LAST_INDEX-HPI_SOURCENODE_BASE+1)) || \
-      (NUM_DESTNODE_STRINGS  != (HPI_DESTNODE_LAST_INDEX-HPI_DESTNODE_BASE+1)))
-#error "Node strings don't agree with HPI defines - version mismatch?"
+#if ((8 != (HPI_DESTNODE_LAST_INDEX-HPI_DESTNODE_BASE+1)))
+#error "DestNode strings don't agree with HPI defines - version mismatch?"
 #endif
 
-static char snd_control_name[44]; /*asound.h:745 unsigned char name[44]; */
 
 static inline int ctl_add(struct snd_card *card, struct snd_kcontrol_new *ctl,
 				struct snd_card_asihpi *asihpi)
@@ -1418,25 +1419,25 @@ static void asihpi_ctl_init(struct snd_kcontrol_new *snd_control,
 				char *name)
 {
 	memset(snd_control, 0, sizeof(*snd_control));
-	snd_control->name = snd_control_name;
+	snd_control->name = asihpi_control->name;
 	snd_control->private_value = asihpi_control->hControl;
 	snd_control->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	snd_control->index = 0;
 
 	if (asihpi_control->wSrcNodeType && asihpi_control->wDstNodeType)
-		sprintf(snd_control->name, "%s%d to %s%d %s",
+		sprintf(asihpi_control->name, "%s%d to %s%d %s",
 			asihpi_src_names[asihpi_control->wSrcNodeType],
 			asihpi_control->wSrcNodeIndex,
 			asihpi_dst_names[asihpi_control->wDstNodeType],
 			asihpi_control->wDstNodeIndex,
 			name);
 	else if (asihpi_control->wDstNodeType) {
-		sprintf(snd_control->name, "%s%d %s",
+		sprintf(asihpi_control->name, "%s%d %s",
 		asihpi_dst_names[asihpi_control->wDstNodeType],
 		asihpi_control->wDstNodeIndex,
 		name);
 	} else {
-		sprintf(snd_control->name, "%s%d %s",
+		sprintf(asihpi_control->name, "%s%d %s",
 		asihpi_src_names[asihpi_control->wSrcNodeType],
 		asihpi_control->wSrcNodeIndex,
 		name);
@@ -1530,10 +1531,26 @@ static int __devinit snd_asihpi_volume_add(struct snd_card_asihpi *asihpi,
 static int snd_asihpi_level_info(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_info *uinfo)
 {
+	u32 hControl = kcontrol->private_value;
+	u16 err;
+	short nMinGain_01dB;
+	short nMaxGain_01dB;
+	short nStepGain_01dB;
+
+	err =
+	    HPI_LevelQueryRange(phSubSys, hControl, &nMinGain_01dB,
+			       &nMaxGain_01dB, &nStepGain_01dB);
+	if (err) {
+		nMaxGain_01dB = 2400;
+		nMinGain_01dB = -1000;
+		nStepGain_01dB = 100;
+	}
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
-	uinfo->value.integer.min = -10;
-	uinfo->value.integer.max = 24;
+	uinfo->value.integer.min = nMinGain_01dB / HPI_UNITS_PER_dB;
+	uinfo->value.integer.max = nMaxGain_01dB / HPI_UNITS_PER_dB;
+	uinfo->value.integer.step = nStepGain_01dB / HPI_UNITS_PER_dB;
 	return 0;
 }
 
@@ -1763,11 +1780,10 @@ static int snd_asihpi_tuner_gain_info(struct snd_kcontrol *kcontrol,
 	u32 hControl = kcontrol->private_value;
 	u16 err;
 	short idx;
-	u32 gainRange[3];
+	u16 gainRange[3];
 
 	for (idx = 0; idx < 3; idx++) {
-	err = HPI_ControlQuery(phSubSys, hControl, HPI_TUNER_GAIN,
-				idx, 0, &gainRange[idx]);
+	err = HPI_Tuner_QueryGain(phSubSys, hControl, idx, &gainRange[idx]);
 		if (err != 0)
 			return err;
 	}
@@ -1813,25 +1829,24 @@ static int snd_asihpi_tuner_gain_put(struct snd_kcontrol *kcontrol,
 /* Band  */
 
 static int asihpi_tuner_band_query(struct snd_kcontrol *kcontrol,
-					u32 *bandList, u32 len) {
+					u16 *bandList, u32 len) {
 	u32 hControl = kcontrol->private_value;
 	u16 err;
-	u32 idx;
+	u32 i;
 
-	for (idx = 0; idx < len; idx++) {
-		err = HPI_ControlQuery(phSubSys, hControl , HPI_TUNER_BAND,
-				idx, 0 , &bandList[idx]);
+	for (i = 0; i < len; i++) {
+		err = HPI_Tuner_QueryBand(phSubSys, hControl, i, &bandList[i]);
 		if (err != 0)
 			break;
 	}
 
-	return idx;
+	return i;
 }
 
 static int snd_asihpi_tuner_band_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
-	u32 tunerBands[HPI_TUNER_BAND_LAST];
+	u16 tunerBands[HPI_TUNER_BAND_LAST];
 	u32 numBands = 0;
 
 	numBands = asihpi_tuner_band_query(kcontrol, tunerBands,
@@ -1860,7 +1875,7 @@ static int snd_asihpi_tuner_band_get(struct snd_kcontrol *kcontrol,
 	struct snd_card_asihpi *asihpi = snd_kcontrol_chip(kcontrol);
 	*/
 	u16 band, idx;
-	u32 tunerBands[HPI_TUNER_BAND_LAST];
+	u16 tunerBands[HPI_TUNER_BAND_LAST];
 	u32 numBands = 0;
 
 	numBands = asihpi_tuner_band_query(kcontrol, tunerBands,
@@ -1886,7 +1901,7 @@ static int snd_asihpi_tuner_band_put(struct snd_kcontrol *kcontrol,
 	*/
 	u32 hControl = kcontrol->private_value;
 	u16 band;
-	u32 tunerBands[HPI_TUNER_BAND_LAST];
+	u16 tunerBands[HPI_TUNER_BAND_LAST];
 	u32 numBands = 0;
 
 	numBands = asihpi_tuner_band_query(kcontrol, tunerBands,
@@ -1905,8 +1920,8 @@ static int snd_asihpi_tuner_freq_info(struct snd_kcontrol *kcontrol,
 {
 	u32 hControl = kcontrol->private_value;
 	u16 err;
-	u32 tunerBands[HPI_TUNER_BAND_LAST];
-	u32 numBands = 0, band_iter, idx;
+	u16 tunerBands[HPI_TUNER_BAND_LAST];
+	u16 numBands = 0, band_iter, idx;
 	u32 freqRange[3], tempFreqRange[3];
 
 	numBands = asihpi_tuner_band_query(kcontrol, tunerBands,
@@ -1918,8 +1933,8 @@ static int snd_asihpi_tuner_freq_info(struct snd_kcontrol *kcontrol,
 
 	for (band_iter = 0; band_iter < numBands; band_iter++) {
 		for (idx = 0; idx < 3; idx++) {
-			err = HPI_ControlQuery(phSubSys, hControl,
-				HPI_TUNER_FREQ, idx, tunerBands[band_iter],
+			err = HPI_Tuner_QueryFrequency(phSubSys, hControl,
+				idx, tunerBands[band_iter],
 				&tempFreqRange[idx]);
 			if (err != 0)
 				return err;
@@ -2242,15 +2257,14 @@ static int snd_asihpi_cmode_info(struct snd_kcontrol *kcontrol,
 	};
 
 	u32 hControl = kcontrol->private_value;
-	u32 mode;
+	u16 wMode;
 	int i;
 
 	/* HPI channel mode values can be from 1 to 6
 	Some adapters only support a contiguous subset
 	*/
 	for (i = 0; i < HPI_CHANNEL_MODE_LAST; i++)
-		if (HPI_ControlQuery(phSubSys, hControl,
-				HPI_CHANNEL_MODE_MODE, i, 0, &mode))
+		if (HPI_ChannelMode_QueryMode(phSubSys,  hControl, i, &wMode))
 			break;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
@@ -2464,15 +2478,15 @@ static int __devinit snd_asihpi_sampleclock_add(struct snd_card_asihpi *asihpi,
 	u32 hSC =  asihpi_control->hControl;
 	int hasAesIn = 0;
 	int i, j;
-	u32 wSource;
+	u16 wSource;
 
 	snd_control.private_value = asihpi_control->hControl;
 
 	clkcache->has_local = 0;
 
 	for (i = 0; i <= HPI_SAMPLECLOCK_SOURCE_LAST; i++) {
-		if  (HPI_ControlQuery(phSubSys, hSC,
-				HPI_SAMPLECLOCK_SOURCE, i, 0, &wSource))
+		if  (HPI_SampleClock_QuerySource(phSubSys, hSC,
+				i, &wSource))
 			break;
 		clkcache->s[i].source = wSource;
 		clkcache->s[i].index = 0;
@@ -2485,9 +2499,9 @@ static int __devinit snd_asihpi_sampleclock_add(struct snd_card_asihpi *asihpi,
 	if (hasAesIn)
 		/* already will have picked up index 0 above */
 		for (j = 1; j < 8; j++) {
-			if (HPI_ControlQuery(phSubSys, hSC,
-				HPI_SAMPLECLOCK_SOURCE_INDEX, j,
-				HPI_SAMPLECLOCK_SOURCE_AESEBU_INPUT, &wSource))
+			if (HPI_SampleClock_QuerySourceIndex(phSubSys, hSC,
+				j, HPI_SAMPLECLOCK_SOURCE_AESEBU_INPUT,
+				&wSource))
 				break;
 			clkcache->s[i].source =
 				HPI_SAMPLECLOCK_SOURCE_AESEBU_INPUT;
@@ -2589,7 +2603,8 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 			err = snd_asihpi_meter_add(asihpi, &asihpi_control);
 			break;
 		case HPI_CONTROL_SAMPLECLOCK:
-			err = snd_asihpi_sampleclock_add(asihpi, &asihpi_control);
+			err = snd_asihpi_sampleclock_add(
+						asihpi, &asihpi_control);
 			break;
 		case HPI_CONTROL_CONNECTION:	/* ignore these */
 			continue;
@@ -2744,7 +2759,7 @@ static int __devinit snd_asihpi_hpi_new(struct snd_card_asihpi *asihpi,
 /*------------------------------------------------------------
    CARD
  ------------------------------------------------------------*/
-int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
+static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 				       const struct pci_device_id *pci_id)
 {
 	int err;
@@ -2886,7 +2901,7 @@ static void __devexit snd_asihpi_remove(struct pci_dev *pci_dev)
 	asihpi_adapter_remove(pci_dev);
 }
 
-struct pci_device_id  asihpi_pci_tbl[] = {
+static struct pci_device_id  asihpi_pci_tbl[] = {
 	{HPI_PCI_VENDOR_ID_TI, HPI_ADAPTER_DSP6205,
 		HPI_PCI_VENDOR_ID_AUDIOSCIENCE, PCI_ANY_ID, 0, 0,
 		(kernel_ulong_t)HPI_6205},
-- 
1.5.4.3
