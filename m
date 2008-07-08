From: linux@audioscience.com
Subject: [PATCH - asihpi 2/4] Regularise control creation. Add
 readonly AESEBU status control. Fix ChannelMode enumeration.
Date: Wed, 09 Jul 2008 11:10:39 +1200
Message-ID: <1215558641-19514-2-git-send-email-linux@audioscience.com>
References: <1215558641-19514-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1215558641-19514-1-git-send-email-linux@audioscience.com>
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
index c715ad2..f9fe449 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -1304,6 +1304,7 @@ static int __devinit snd_card_asihpi_pcm_new(struct snd_card_asihpi *asihpi,
 
 /***************************** MIXER CONTROLS ****************/
 struct hpi_control {
+	u32 hControl;
 	u16 wControlType;
 	u16 wSrcNodeType;
 	u16 wSrcNodeIndex;
@@ -1395,11 +1396,13 @@ static char *asihpi_dst_names[] =
 #error "Node strings don't agree with HPI defines - version mismatch?"
 #endif
 
+static char snd_control_name[44]; /*asound.h:745 unsigned char name[44]; */
 
 static inline int ctl_add(struct snd_card *card, struct snd_kcontrol_new *ctl,
 				struct snd_card_asihpi *asihpi)
 {
 	int err;
+
 	err = snd_ctl_add(card, snd_ctl_new1(ctl, asihpi));
 	if (err < 0)
 		return err;
@@ -1410,10 +1413,16 @@ static inline int ctl_add(struct snd_card *card, struct snd_kcontrol_new *ctl,
 }
 
 /* Convert HPI control name and location into ALSA control name */
-static void asihpi_ctl_name(struct snd_kcontrol_new *snd_control,
+static void asihpi_ctl_init(struct snd_kcontrol_new *snd_control,
 				struct hpi_control *asihpi_control,
 				char *name)
 {
+	memset(snd_control, 0, sizeof(*snd_control));
+	snd_control->name = snd_control_name;
+	snd_control->private_value = asihpi_control->hControl;
+	snd_control->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	snd_control->index = 0;
+
 	if (asihpi_control->wSrcNodeType && asihpi_control->wDstNodeType)
 		sprintf(snd_control->name, "%s%d to %s%d %s",
 			asihpi_src_names[asihpi_control->wSrcNodeType],
@@ -1498,17 +1507,21 @@ static int snd_asihpi_volume_put(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(db_scale_100, -10000, 100, 0);
 
-static void __devinit snd_asihpi_volume_new(struct hpi_control *asihpi_control,
-					 struct snd_kcontrol_new *snd_control)
+static int __devinit snd_asihpi_volume_add(struct snd_card_asihpi *asihpi,
+					struct hpi_control *asihpi_control)
 {
-	snd_control->info = snd_asihpi_volume_info;
-	snd_control->get = snd_asihpi_volume_get;
-	snd_control->put = snd_asihpi_volume_put;
-	snd_control->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+	struct snd_card *card = asihpi->card;
+	struct snd_kcontrol_new snd_control;
+
+	asihpi_ctl_init(&snd_control, asihpi_control, "Volume");
+	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
 				SNDRV_CTL_ELEM_ACCESS_TLV_READ;
-	snd_control->tlv.p = db_scale_100;
+	snd_control.info = snd_asihpi_volume_info;
+	snd_control.get = snd_asihpi_volume_get;
+	snd_control.put = snd_asihpi_volume_put;
+	snd_control.tlv.p = db_scale_100;
 
-	asihpi_ctl_name(snd_control, asihpi_control, "Volume");
+	return (ctl_add(card, &snd_control, asihpi));
 }
 
 /*------------------------------------------------------------
@@ -1560,19 +1573,22 @@ static int snd_asihpi_level_put(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(db_scale_level, -1000, 100, 0);
 
-static void __devinit snd_asihpi_level_new(struct hpi_control *asihpi_control,
-					struct snd_kcontrol_new *snd_control)
+static int __devinit snd_asihpi_level_add(struct snd_card_asihpi *asihpi,
+					struct hpi_control *asihpi_control)
 {
-	snd_control->info = snd_asihpi_level_info;
-	snd_control->get = snd_asihpi_level_get;
-	snd_control->put = snd_asihpi_level_put;
-	snd_control->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-				SNDRV_CTL_ELEM_ACCESS_TLV_READ;
-
-	snd_control->tlv.p = db_scale_level;
+	struct snd_card *card = asihpi->card;
+	struct snd_kcontrol_new snd_control;
 
 	/* can't use 'volume' cos some nodes have volume as well */
-	asihpi_ctl_name(snd_control, asihpi_control, "Level");
+	asihpi_ctl_init(&snd_control, asihpi_control, "Level");
+	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ;
+	snd_control.info = snd_asihpi_level_info;
+	snd_control.get = snd_asihpi_level_get;
+	snd_control.put = snd_asihpi_level_put;
+	snd_control.tlv.p = db_scale_level;
+
+	return (ctl_add(card, &snd_control, asihpi));
 }
 
 /*------------------------------------------------------------
@@ -1646,69 +1662,93 @@ static int snd_asihpi_aesebu_format_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static int snd_asihpi_aesebu_rx_source_get(struct snd_kcontrol *kcontrol,
+static int snd_asihpi_aesebu_rx_format_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol) {
 	return snd_asihpi_aesebu_format_get(kcontrol, ucontrol,
 					HPI_AESEBU_Receiver_GetFormat);
 }
 
-static int snd_asihpi_aesebu_rx_source_put(struct snd_kcontrol *kcontrol,
+static int snd_asihpi_aesebu_rx_format_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol) {
 	return snd_asihpi_aesebu_format_put(kcontrol, ucontrol,
 					HPI_AESEBU_Receiver_SetFormat);
 }
 
-static int snd_asihpi_aesebu_tx_format_get(struct snd_kcontrol *kcontrol,
-				 struct snd_ctl_elem_value *ucontrol) {
-	return snd_asihpi_aesebu_format_get(kcontrol, ucontrol,
-					HPI_AESEBU_Transmitter_GetFormat);
+static int snd_asihpi_aesebu_rxstatus_info(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 0X1F;
+	uinfo->value.integer.step = 1;
+
+	return 0;
 }
 
-static int snd_asihpi_aesebu_tx_format_put(struct snd_kcontrol *kcontrol,
+static int snd_asihpi_aesebu_rxstatus_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol) {
-	return snd_asihpi_aesebu_format_put(kcontrol, ucontrol,
-					HPI_AESEBU_Transmitter_SetFormat);
-}
 
-/* AESEBU control group initializers  */
+	u32 hControl = kcontrol->private_value;
+	u16 status;
 
-static int __devinit snd_asihpi_aesebu_rx_new(struct snd_card_asihpi *asihpi,
-					struct hpi_control *asihpi_control,
-					struct snd_kcontrol_new *snd_control)
-{
+	HPI_AESEBU_Receiver_GetErrorStatus(phSubSys, hControl, &status);
+	ucontrol->value.integer.value[0] = status;
+	return 0;
+}
 
+static int __devinit snd_asihpi_aesebu_rx_add(struct snd_card_asihpi *asihpi,
+					struct hpi_control *asihpi_control)
+{
 	struct snd_card *card = asihpi->card;
+	struct snd_kcontrol_new snd_control;
 
-/* RX source */
-
-	snd_control->info = snd_asihpi_aesebu_format_info;
-	snd_control->get = snd_asihpi_aesebu_rx_source_get;
-	snd_control->put = snd_asihpi_aesebu_rx_source_put;
+	asihpi_ctl_init(&snd_control, asihpi_control, "Format");
+	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	snd_control.info = snd_asihpi_aesebu_format_info;
+	snd_control.get = snd_asihpi_aesebu_rx_format_get;
+	snd_control.put = snd_asihpi_aesebu_rx_format_put;
 
-	asihpi_ctl_name(snd_control, asihpi_control, "AesRx");
 
-	if (ctl_add(card, snd_control, asihpi) < 0)
+	if (ctl_add(card, &snd_control, asihpi) < 0)
 		return -EINVAL;
 
-	return 0;
+	asihpi_ctl_init(&snd_control, asihpi_control, "Status");
+	snd_control.access =
+	    SNDRV_CTL_ELEM_ACCESS_VOLATILE | SNDRV_CTL_ELEM_ACCESS_READ;
+	snd_control.info = snd_asihpi_aesebu_rxstatus_info;
+	snd_control.get = snd_asihpi_aesebu_rxstatus_get;
+
+	return ctl_add(card, &snd_control, asihpi);
 }
 
-static int __devinit snd_asihpi_aesebu_tx_new(struct snd_card_asihpi *asihpi,
-					struct hpi_control *asihpi_control,
-					struct snd_kcontrol_new *snd_control)
+static int snd_asihpi_aesebu_tx_format_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol) {
+	return snd_asihpi_aesebu_format_get(kcontrol, ucontrol,
+					HPI_AESEBU_Transmitter_GetFormat);
+}
+
+static int snd_asihpi_aesebu_tx_format_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol) {
+	return snd_asihpi_aesebu_format_put(kcontrol, ucontrol,
+					HPI_AESEBU_Transmitter_SetFormat);
+}
+
+
+static int __devinit snd_asihpi_aesebu_tx_add(struct snd_card_asihpi *asihpi,
+					struct hpi_control *asihpi_control)
 {
 	struct snd_card *card = asihpi->card;
-/* TX Format */
-	snd_control->info = snd_asihpi_aesebu_format_info;
-	snd_control->get = snd_asihpi_aesebu_tx_format_get;
-	snd_control->put = snd_asihpi_aesebu_tx_format_put;
-
-	asihpi_ctl_name(snd_control, asihpi_control, "Format");
+	struct snd_kcontrol_new snd_control;
 
-	if (ctl_add(card, snd_control, asihpi) < 0)
-		return -EINVAL;
+	asihpi_ctl_init(&snd_control, asihpi_control, "Format");
+	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	snd_control.info = snd_asihpi_aesebu_format_info;
+	snd_control.get = snd_asihpi_aesebu_tx_format_get;
+	snd_control.put = snd_asihpi_aesebu_tx_format_put;
 
-	return 0;
+	return ctl_add(card, &snd_control, asihpi);
 }
 
 /*------------------------------------------------------------
@@ -1930,48 +1970,39 @@ static int snd_asihpi_tuner_freq_put(struct snd_kcontrol *kcontrol,
 }
 
 /* Tuner control group initializer  */
-static int __devinit snd_asihpi_tuner_new(struct snd_card_asihpi *asihpi,
-					struct hpi_control *asihpi_control,
-					struct snd_kcontrol_new *snd_control)
+static int __devinit snd_asihpi_tuner_add(struct snd_card_asihpi *asihpi,
+					struct hpi_control *asihpi_control)
 {
 	struct snd_card *card = asihpi->card;
-	u32 hControl = snd_control->private_value;
-
-/* Gain ctl */
+	struct snd_kcontrol_new snd_control;
 
-	if (HPI_Tuner_GetGain(phSubSys, hControl, NULL) == 0) {
-		snd_control->info = snd_asihpi_tuner_gain_info;
-		snd_control->get = snd_asihpi_tuner_gain_get;
-		snd_control->put = snd_asihpi_tuner_gain_put;
+	snd_control.private_value = asihpi_control->hControl;
+	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
 
-		asihpi_ctl_name(snd_control, asihpi_control, "Gain");
+	if (HPI_Tuner_GetGain(phSubSys, asihpi_control->hControl, NULL) == 0) {
+		asihpi_ctl_init(&snd_control, asihpi_control, "Gain");
+		snd_control.info = snd_asihpi_tuner_gain_info;
+		snd_control.get = snd_asihpi_tuner_gain_get;
+		snd_control.put = snd_asihpi_tuner_gain_put;
 
-		if (ctl_add(card, snd_control, asihpi) < 0)
+		if (ctl_add(card, &snd_control, asihpi) < 0)
 			return -EINVAL;
 	}
-/* Band ctl */
-
-	snd_control->info = snd_asihpi_tuner_band_info;
-	snd_control->get = snd_asihpi_tuner_band_get;
-	snd_control->put = snd_asihpi_tuner_band_put;
 
-	asihpi_ctl_name(snd_control, asihpi_control, "Band");
+	asihpi_ctl_init(&snd_control, asihpi_control, "Band");
+	snd_control.info = snd_asihpi_tuner_band_info;
+	snd_control.get = snd_asihpi_tuner_band_get;
+	snd_control.put = snd_asihpi_tuner_band_put;
 
-	if (ctl_add(card, snd_control, asihpi) < 0)
+	if (ctl_add(card, &snd_control, asihpi) < 0)
 		return -EINVAL;
 
-/* Freq ctl */
+	asihpi_ctl_init(&snd_control, asihpi_control, "Freq");
+	snd_control.info = snd_asihpi_tuner_freq_info;
+	snd_control.get = snd_asihpi_tuner_freq_get;
+	snd_control.put = snd_asihpi_tuner_freq_put;
 
-	snd_control->info = snd_asihpi_tuner_freq_info;
-	snd_control->get = snd_asihpi_tuner_freq_get;
-	snd_control->put = snd_asihpi_tuner_freq_put;
-
-	asihpi_ctl_name(snd_control, asihpi_control, "Freq");
-
-	if (ctl_add(card, snd_control, asihpi) < 0)
-		return -EINVAL;
-
-	return 0;
+	return (ctl_add(card, &snd_control, asihpi));
 }
 
 /*------------------------------------------------------------
@@ -2075,16 +2106,19 @@ static int snd_asihpi_meter_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static void __devinit snd_asihpi_meter_new(struct hpi_control *asihpi_control,
-					struct snd_kcontrol_new *snd_control)
+static int __devinit snd_asihpi_meter_add(struct snd_card_asihpi *asihpi,
+					struct hpi_control *asihpi_control)
 {
-	snd_control->info = snd_asihpi_meter_info;
-	snd_control->get = snd_asihpi_meter_get;
-	snd_control->put = NULL;
-	snd_control->access =
+	struct snd_card *card = asihpi->card;
+	struct snd_kcontrol_new snd_control;
+
+	asihpi_ctl_init(&snd_control, asihpi_control, "Meter");
+	snd_control.access =
 	    SNDRV_CTL_ELEM_ACCESS_VOLATILE | SNDRV_CTL_ELEM_ACCESS_READ;
+	snd_control.info = snd_asihpi_meter_info;
+	snd_control.get = snd_asihpi_meter_get;
 
-	asihpi_ctl_name(snd_control, asihpi_control, "Meter");
+	return (ctl_add(card, &snd_control, asihpi));
 }
 
 /*------------------------------------------------------------
@@ -2177,18 +2211,24 @@ static int snd_asihpi_mux_put(struct snd_kcontrol *kcontrol,
 }
 
 
-static void __devinit snd_asihpi_mux_new(struct hpi_control *asihpi_control,
-				      struct snd_kcontrol_new *snd_control)
+static int  __devinit snd_asihpi_mux_add(struct snd_card_asihpi *asihpi,
+					struct hpi_control *asihpi_control)
 {
-	snd_control->info = snd_asihpi_mux_info;
-	snd_control->get = snd_asihpi_mux_get;
-	snd_control->put = snd_asihpi_mux_put;
+	struct snd_card *card = asihpi->card;
+	struct snd_kcontrol_new snd_control;
 
 #if ASI_STYLE_NAMES
-	asihpi_ctl_name(snd_control, asihpi_control, "Multiplexer");
+	asihpi_ctl_init(&snd_control, asihpi_control, "Multiplexer");
 #else
-	asihpi_ctl_name(snd_control, asihpi_control, "Route");
+	asihpi_ctl_init(&snd_control, asihpi_control, "Route");
 #endif
+	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	snd_control.info = snd_asihpi_mux_info;
+	snd_control.get = snd_asihpi_mux_get;
+	snd_control.put = snd_asihpi_mux_put;
+
+	return (ctl_add(card, &snd_control, asihpi));
+
 }
 
 /*------------------------------------------------------------
@@ -2197,19 +2237,32 @@ static void __devinit snd_asihpi_mux_new(struct hpi_control *asihpi_control,
 static int snd_asihpi_cmode_info(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[HPI_CHANNEL_MODE_LAST] = {
+	static char *mode_names[HPI_CHANNEL_MODE_LAST] = {
 		"Normal", "Swap", "FromLeft", "FromRight", "ToLeft", "ToRight"
 	};
 
+	u32 hControl = kcontrol->private_value;
+	u32 mode;
+	int i;
+
+	/* HPI channel mode values can be from 1 to 6
+	Some adapters only support a contiguous subset
+	*/
+	for (i = 0; i < HPI_CHANNEL_MODE_LAST; i++)
+		if (HPI_ControlQuery(phSubSys, hControl,
+				HPI_CHANNEL_MODE_MODE, i, 0, &mode))
+			break;
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = 6;
+	uinfo->value.enumerated.items = i;
 
-	if (uinfo->value.enumerated.item > 5)
-		uinfo->value.enumerated.item = 5;
+	if (uinfo->value.enumerated.item >= i)
+		uinfo->value.enumerated.item = i - 1;
 
 	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
+	       mode_names[uinfo->value.enumerated.item]);
+
 	return 0;
 }
 
@@ -2241,14 +2294,19 @@ static int snd_asihpi_cmode_put(struct snd_kcontrol *kcontrol,
 }
 
 
-static void __devinit snd_asihpi_cmode_new(struct hpi_control *asihpi_control,
-					struct snd_kcontrol_new *snd_control)
+static int __devinit snd_asihpi_cmode_add(struct snd_card_asihpi *asihpi,
+					struct hpi_control *asihpi_control)
 {
-	snd_control->info = snd_asihpi_cmode_info;
-	snd_control->get = snd_asihpi_cmode_get;
-	snd_control->put = snd_asihpi_cmode_put;
+	struct snd_card *card = asihpi->card;
+	struct snd_kcontrol_new snd_control;
+
+	asihpi_ctl_init(&snd_control, asihpi_control, "Channel Mode");
+	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	snd_control.info = snd_asihpi_cmode_info;
+	snd_control.get = snd_asihpi_cmode_get;
+	snd_control.put = snd_asihpi_cmode_put;
 
-	asihpi_ctl_name(snd_control, asihpi_control, "Channel Mode");
+	return (ctl_add(card, &snd_control, asihpi));
 }
 
 /*------------------------------------------------------------
@@ -2331,52 +2389,6 @@ static int snd_asihpi_clksrc_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static void __devinit snd_asihpi_clksrc_new(struct snd_card_asihpi *asihpi,
-					struct hpi_control *asihpi_control,
-					struct snd_kcontrol_new *snd_control)
-{
-	struct clk_cache *clkcache = &asihpi->cc;
-	u32 hSC =  snd_control->private_value;
-	int hasAesIn = 0;
-	int i, j;
-	u32 wSource;
-
-	snd_control->info = snd_asihpi_clksrc_info;
-	snd_control->get = snd_asihpi_clksrc_get;
-	snd_control->put = snd_asihpi_clksrc_put;
-	asihpi_ctl_name(snd_control, asihpi_control, "Source");
-
-	clkcache->has_local = 0;
-
-	for (i = 0; i <= HPI_SAMPLECLOCK_SOURCE_LAST; i++) {
-		if  (HPI_ControlQuery(phSubSys, hSC,
-				HPI_SAMPLECLOCK_SOURCE, i, 0, &wSource))
-			break;
-		clkcache->s[i].source = wSource;
-		clkcache->s[i].index = 0;
-		clkcache->s[i].name = sampleclock_sources[wSource];
-		if (wSource == HPI_SAMPLECLOCK_SOURCE_AESEBU_INPUT)
-			hasAesIn = 1;
-		if (wSource == HPI_SAMPLECLOCK_SOURCE_LOCAL)
-			clkcache->has_local = 1;
-	}
-	if (hasAesIn)
-		/* already will have picked up index 0 above */
-		for (j = 1; j < 8; j++) {
-			if (HPI_ControlQuery(phSubSys, hSC,
-				HPI_SAMPLECLOCK_SOURCE_INDEX, j,
-				HPI_SAMPLECLOCK_SOURCE_AESEBU_INPUT, &wSource))
-				break;
-			clkcache->s[i].source =
-				HPI_SAMPLECLOCK_SOURCE_AESEBU_INPUT;
-			clkcache->s[i].index = j;
-			clkcache->s[i].name = sampleclock_sources[
-					j+HPI_SAMPLECLOCK_SOURCE_LAST];
-			i++;
-		}
-	clkcache->count = i;
-}
-
 /*------------------------------------------------------------
    Clkrate controls
  ------------------------------------------------------------*/
@@ -2419,19 +2431,6 @@ static int snd_asihpi_clklocal_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static void __devinit snd_asihpi_clklocal_new(
-					struct hpi_control *asihpi_control,
-					struct snd_kcontrol_new *snd_control)
-{
-	snd_control->info = snd_asihpi_clklocal_info;
-	snd_control->get = snd_asihpi_clklocal_get;
-	snd_control->put = snd_asihpi_clklocal_put;
-	snd_control->access = SNDRV_CTL_ELEM_ACCESS_READWRITE ;
-
-
-	asihpi_ctl_name(snd_control, asihpi_control, "LocalRate");
-}
-
 static int snd_asihpi_clkrate_info(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_info *uinfo)
 {
@@ -2455,15 +2454,78 @@ static int snd_asihpi_clkrate_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static void __devinit snd_asihpi_clkrate_new(struct hpi_control *asihpi_control,
-					  struct snd_kcontrol_new *snd_control)
+static int __devinit snd_asihpi_sampleclock_add(struct snd_card_asihpi *asihpi,
+					struct hpi_control *asihpi_control)
 {
-	snd_control->info = snd_asihpi_clkrate_info;
-	snd_control->get = snd_asihpi_clkrate_get;
-	snd_control->access =
+	struct snd_card *card = asihpi->card;
+	struct snd_kcontrol_new snd_control;
+
+	struct clk_cache *clkcache = &asihpi->cc;
+	u32 hSC =  asihpi_control->hControl;
+	int hasAesIn = 0;
+	int i, j;
+	u32 wSource;
+
+	snd_control.private_value = asihpi_control->hControl;
+
+	clkcache->has_local = 0;
+
+	for (i = 0; i <= HPI_SAMPLECLOCK_SOURCE_LAST; i++) {
+		if  (HPI_ControlQuery(phSubSys, hSC,
+				HPI_SAMPLECLOCK_SOURCE, i, 0, &wSource))
+			break;
+		clkcache->s[i].source = wSource;
+		clkcache->s[i].index = 0;
+		clkcache->s[i].name = sampleclock_sources[wSource];
+		if (wSource == HPI_SAMPLECLOCK_SOURCE_AESEBU_INPUT)
+			hasAesIn = 1;
+		if (wSource == HPI_SAMPLECLOCK_SOURCE_LOCAL)
+			clkcache->has_local = 1;
+	}
+	if (hasAesIn)
+		/* already will have picked up index 0 above */
+		for (j = 1; j < 8; j++) {
+			if (HPI_ControlQuery(phSubSys, hSC,
+				HPI_SAMPLECLOCK_SOURCE_INDEX, j,
+				HPI_SAMPLECLOCK_SOURCE_AESEBU_INPUT, &wSource))
+				break;
+			clkcache->s[i].source =
+				HPI_SAMPLECLOCK_SOURCE_AESEBU_INPUT;
+			clkcache->s[i].index = j;
+			clkcache->s[i].name = sampleclock_sources[
+					j+HPI_SAMPLECLOCK_SOURCE_LAST];
+			i++;
+		}
+	clkcache->count = i;
+
+	asihpi_ctl_init(&snd_control, asihpi_control, "Source");
+	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE ;
+	snd_control.info = snd_asihpi_clksrc_info;
+	snd_control.get = snd_asihpi_clksrc_get;
+	snd_control.put = snd_asihpi_clksrc_put;
+	if (ctl_add(card, &snd_control, asihpi) < 0)
+		return -EINVAL;
+
+
+	if (clkcache->has_local) {
+		asihpi_ctl_init(&snd_control, asihpi_control, "LocalRate");
+		snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE ;
+		snd_control.info = snd_asihpi_clklocal_info;
+		snd_control.get = snd_asihpi_clklocal_get;
+		snd_control.put = snd_asihpi_clklocal_put;
+
+
+		if (ctl_add(card, &snd_control, asihpi) < 0)
+			return -EINVAL;
+	}
+
+	asihpi_ctl_init(&snd_control, asihpi_control, "Rate");
+	snd_control.access =
 	    SNDRV_CTL_ELEM_ACCESS_VOLATILE | SNDRV_CTL_ELEM_ACCESS_READ;
+	snd_control.info = snd_asihpi_clkrate_info;
+	snd_control.get = snd_asihpi_clkrate_get;
 
-	asihpi_ctl_name(snd_control, asihpi_control, "Rate");
+	return (ctl_add(card, &snd_control, asihpi));
 }
 /*------------------------------------------------------------
    Mixer
@@ -2474,9 +2536,6 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 	struct snd_card *card = asihpi->card;
 	unsigned int idx = 0;
 	int err;
-	u32 hControl;
-	struct snd_kcontrol_new snd_control;
-	char snd_control_name[44]; /*asound.h:745 unsigned char name[44]; */
 	struct hpi_control asihpi_control;
 
 	snd_assert(asihpi != NULL, return -EINVAL);
@@ -2489,10 +2548,6 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 	if (err)
 		return -err;
 
-	memset(&snd_control, 0, sizeof(snd_control));
-	snd_control.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-	snd_control.name = snd_control_name;
-
 	for (idx = 0; idx < 2000; idx++) {
 		err = HPI_MixerGetControlByIndex(phSubSys, asihpi->hMixer,
 						 idx,
@@ -2501,7 +2556,7 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 						 &asihpi_control.wDstNodeType,
 						 &asihpi_control.wDstNodeIndex,
 						 &asihpi_control.wControlType,
-						 &hControl);
+						 &asihpi_control.hControl);
 		if (err) {
 			if (err == HPI_ERROR_CONTROL_DISABLED) {
 				if (mixer_dump)
@@ -2516,64 +2571,37 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 
 		asihpi_control.wSrcNodeType -= HPI_SOURCENODE_BASE;
 		asihpi_control.wDstNodeType -= HPI_DESTNODE_BASE;
-		snd_control.index = 0;
-		snd_control.private_value = hControl;
-		snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE ;
+
 		switch (asihpi_control.wControlType) {
 		case HPI_CONTROL_VOLUME:
-			snd_asihpi_volume_new(&asihpi_control,
-					      &snd_control);
+			err = snd_asihpi_volume_add(asihpi, &asihpi_control);
 			break;
 		case HPI_CONTROL_LEVEL:
-			snd_asihpi_level_new(&asihpi_control,
-					     &snd_control);
+			err = snd_asihpi_level_add(asihpi, &asihpi_control);
 			break;
 		case HPI_CONTROL_MULTIPLEXER:
-			snd_asihpi_mux_new(&asihpi_control, &snd_control);
+			err = snd_asihpi_mux_add(asihpi, &asihpi_control);
 			break;
 		case HPI_CONTROL_CHANNEL_MODE:
-			snd_asihpi_cmode_new(&asihpi_control,
-					     &snd_control);
+			err = snd_asihpi_cmode_add(asihpi, &asihpi_control);
 			break;
 		case HPI_CONTROL_METER:
-			snd_asihpi_meter_new(&asihpi_control,
-					     &snd_control);
+			err = snd_asihpi_meter_add(asihpi, &asihpi_control);
 			break;
 		case HPI_CONTROL_SAMPLECLOCK:
-			snd_asihpi_clksrc_new(asihpi, &asihpi_control,
-					      &snd_control);
-			err = snd_ctl_add(card,
-					snd_ctl_new1(&snd_control, asihpi));
-			if (err < 0)
-				return err;
-			snd_asihpi_clkrate_new(&asihpi_control,
-					       &snd_control);
-			err = snd_ctl_add(card,
-					snd_ctl_new1(&snd_control, asihpi));
-			if (err < 0)
-				return err;
-			if (asihpi->cc.has_local)
-				snd_asihpi_clklocal_new(&asihpi_control,
-					       &snd_control);
-
+			err = snd_asihpi_sampleclock_add(asihpi, &asihpi_control);
 			break;
 		case HPI_CONTROL_CONNECTION:	/* ignore these */
 			continue;
 		case HPI_CONTROL_TUNER:
-			if (snd_asihpi_tuner_new(asihpi, &asihpi_control,
-						  &snd_control) < 0)
-				return -EINVAL;
-			continue;
+			err = snd_asihpi_tuner_add(asihpi, &asihpi_control);
+			break;
 		case HPI_CONTROL_AESEBU_TRANSMITTER:
-			if (snd_asihpi_aesebu_tx_new(asihpi, &asihpi_control,
-						      &snd_control) < 0)
-				return -EINVAL;
-			continue;
+			err = snd_asihpi_aesebu_tx_add(asihpi, &asihpi_control);
+			break;
 		case HPI_CONTROL_AESEBU_RECEIVER:
-			if (snd_asihpi_aesebu_rx_new(asihpi, &asihpi_control,
-						      &snd_control) < 0)
-				return -EINVAL;
-			continue;
+			err = snd_asihpi_aesebu_rx_add(asihpi, &asihpi_control);
+			break;
 		case HPI_CONTROL_VOX:
 		case HPI_CONTROL_BITSTREAM:
 		case HPI_CONTROL_MICROPHONE:
@@ -2592,12 +2620,8 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 					asihpi_control.wDstNodeIndex);
 			continue;
 		};
-		err = snd_ctl_add(card, snd_ctl_new1(&snd_control, asihpi));
 		if (err < 0)
 			return err;
-		else if (mixer_dump)
-			snd_printk(KERN_INFO "Added %s(%d)\n",
-				   snd_control.name, snd_control.index);
 	}
 	if (HPI_ERROR_INVALID_OBJ_INDEX != err)
 		HPI_HandleError(err);
-- 
1.5.4.3
