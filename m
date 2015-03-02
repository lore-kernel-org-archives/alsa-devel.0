From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm8804: Add DAPM widgets for
	SPDIF/AIF
Date: Mon,  2 Mar 2015 17:57:55 +0000
Message-ID: <1425319075-10400-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1425319075-10400-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85C632605E9
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 18:59:10 +0100 (CET)
In-Reply-To: <1425319075-10400-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, info@crazy-audio.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Sapthagiri Baratam <sapthagiri.baratam@incubesol.com>

Signed-off-by: Sapthagiri Baratam <sapthagiri.baratam@incubesol.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

This does cause some changes to the ALSA controls I wanted to
get peoples opinion on. I think there are a couple of users for
this driver.

Firstly, 'Input Source' changes names to 'Tx Source' this is a
lot clearer, but perhaps we shouldn't change this, as it doesn't
have to change?

Secondly, the patch removes the controls 'TX Playback Switch' and
'AIF Playback Switch' as these bits are controlled by DAPM now. I
wasn't sure if it would be preferrable to leave dummy controls that
do nothing?

Thanks,
Charles

 sound/soc/codecs/wm8804.c |  140 ++++++++++++++++++++++++++------------------
 1 files changed, 83 insertions(+), 57 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 6131c2a..7a04dc4 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -24,6 +24,7 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
+#include <sound/soc-dapm.h>
 
 #include "wm8804.h"
 
@@ -61,14 +62,16 @@ struct wm8804_priv {
 	struct regulator_bulk_data supplies[WM8804_NUM_SUPPLIES];
 	struct notifier_block disable_nb[WM8804_NUM_SUPPLIES];
 	int mclk_div;
-};
 
-static int txsrc_get(struct snd_kcontrol *kcontrol,
-		     struct snd_ctl_elem_value *ucontrol);
+	int aif_pwr;
+};
 
 static int txsrc_put(struct snd_kcontrol *kcontrol,
 		     struct snd_ctl_elem_value *ucontrol);
 
+static int wm8804_aif_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event);
+
 /*
  * We can't use the same notifier block for more than one supply and
  * there's no way I can see to get from a callback to the caller
@@ -90,26 +93,62 @@ WM8804_REGULATOR_EVENT(0)
 WM8804_REGULATOR_EVENT(1)
 
 static const char *txsrc_text[] = { "S/PDIF RX", "AIF" };
-static SOC_ENUM_SINGLE_EXT_DECL(txsrc, txsrc_text);
+static const SOC_ENUM_SINGLE_DECL(txsrc, WM8804_SPDTX4, 6, txsrc_text);
 
-static const struct snd_kcontrol_new wm8804_snd_controls[] = {
-	SOC_ENUM_EXT("Input Source", txsrc, txsrc_get, txsrc_put),
-	SOC_SINGLE("TX Playback Switch", WM8804_PWRDN, 2, 1, 1),
-	SOC_SINGLE("AIF Playback Switch", WM8804_PWRDN, 4, 1, 1)
+static const struct snd_kcontrol_new wm8804_tx_source_mux[] = {
+	SOC_DAPM_ENUM_EXT("Tx Source", txsrc,
+			  snd_soc_dapm_get_enum_double, txsrc_put),
 };
 
-static int txsrc_get(struct snd_kcontrol *kcontrol,
-		     struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec;
-	unsigned int src;
+static const struct snd_soc_dapm_widget wm8804_dapm_widgets[] = {
+SND_SOC_DAPM_OUTPUT("SPDIF Out"),
+SND_SOC_DAPM_INPUT("SPDIF In"),
+
+SND_SOC_DAPM_PGA("SPDIFTX", WM8804_PWRDN, 2, 1, NULL, 0),
+SND_SOC_DAPM_PGA("SPDIFRX", WM8804_PWRDN, 1, 1, NULL, 0),
+
+SND_SOC_DAPM_MUX("Tx Source", SND_SOC_NOPM, 6, 0, wm8804_tx_source_mux),
+
+SND_SOC_DAPM_AIF_OUT_E("AIFTX", NULL, 0, SND_SOC_NOPM, 0, 0, wm8804_aif_event,
+		       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_AIF_IN_E("AIFRX", NULL, 0, SND_SOC_NOPM, 0, 0, wm8804_aif_event,
+		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route wm8804_dapm_routes[] = {
+	{ "AIFRX", NULL, "Playback" },
+	{ "Tx Source", "AIF", "AIFRX" },
+
+	{ "SPDIFRX", NULL, "SPDIF In" },
+	{ "Tx Source", "S/PDIF RX", "SPDIFRX" },
+
+	{ "SPDIFTX", NULL, "Tx Source" },
+	{ "SPDIF Out", NULL, "SPDIFTX" },
 
-	codec = snd_soc_kcontrol_codec(kcontrol);
-	src = snd_soc_read(codec, WM8804_SPDTX4);
-	if (src & 0x40)
-		ucontrol->value.integer.value[0] = 1;
-	else
-		ucontrol->value.integer.value[0] = 0;
+	{ "AIFTX", NULL, "SPDIFRX" },
+	{ "Capture", NULL, "AIFTX" },
+};
+
+static int wm8804_aif_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct wm8804_priv *wm8804 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* power up the aif */
+		if (!wm8804->aif_pwr)
+			snd_soc_update_bits(codec, WM8804_PWRDN, 0x10, 0x0);
+		wm8804->aif_pwr++;
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* power down only both paths are disabled */
+		wm8804->aif_pwr--;
+		if (!wm8804->aif_pwr)
+			snd_soc_update_bits(codec, WM8804_PWRDN, 0x10, 0x10);
+		break;
+	}
 
 	return 0;
 }
@@ -117,48 +156,33 @@ static int txsrc_get(struct snd_kcontrol *kcontrol,
 static int txsrc_put(struct snd_kcontrol *kcontrol,
 		     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec;
-	unsigned int src, txpwr;
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int val = ucontrol->value.enumerated.item[0] << e->shift_l;
+	unsigned int mask = 1 << e->shift_l;
+	unsigned int txpwr;
+
+	if (val != 0 && val != mask)
+		return -EINVAL;
 
-	codec = snd_soc_kcontrol_codec(kcontrol);
+	snd_soc_dapm_mutex_lock(dapm);
 
-	if (ucontrol->value.integer.value[0] != 0
-			&& ucontrol->value.integer.value[0] != 1)
-		return -EINVAL;
+	if (snd_soc_test_bits(codec, e->reg, mask, val)) {
+		/* save the current power state of the transmitter */
+		txpwr = snd_soc_read(codec, WM8804_PWRDN) & 0x4;
 
-	src = snd_soc_read(codec, WM8804_SPDTX4);
-	switch ((src & 0x40) >> 6) {
-	case 0:
-		if (!ucontrol->value.integer.value[0])
-			return 0;
-		break;
-	case 1:
-		if (ucontrol->value.integer.value[1])
-			return 0;
-		break;
-	}
+		/* power down the transmitter */
+		snd_soc_update_bits(codec, WM8804_PWRDN, 0x4, 0x4);
 
-	/* save the current power state of the transmitter */
-	txpwr = snd_soc_read(codec, WM8804_PWRDN) & 0x4;
-	/* power down the transmitter */
-	snd_soc_update_bits(codec, WM8804_PWRDN, 0x4, 0x4);
-	/* set the tx source */
-	snd_soc_update_bits(codec, WM8804_SPDTX4, 0x40,
-			    ucontrol->value.integer.value[0] << 6);
-
-	if (ucontrol->value.integer.value[0]) {
-		/* power down the receiver */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x2, 0x2);
-		/* power up the AIF */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x10, 0);
-	} else {
-		/* don't power down the AIF -- may be used as an output */
-		/* power up the receiver */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x2, 0);
+		/* set the tx source */
+		snd_soc_update_bits(codec, e->reg, mask, val);
+
+		/* restore the transmitter's configuration */
+		snd_soc_update_bits(codec, WM8804_PWRDN, 0x4, txpwr);
 	}
 
-	/* restore the transmitter's configuration */
-	snd_soc_update_bits(codec, WM8804_PWRDN, 0x4, txpwr);
+	snd_soc_dapm_mutex_unlock(dapm);
 
 	return 0;
 }
@@ -555,8 +579,10 @@ static const struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
 	.set_bias_level = wm8804_set_bias_level,
 	.idle_bias_off = true,
 
-	.controls = wm8804_snd_controls,
-	.num_controls = ARRAY_SIZE(wm8804_snd_controls),
+	.dapm_widgets = wm8804_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8804_dapm_widgets),
+	.dapm_routes = wm8804_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8804_dapm_routes),
 };
 
 const struct regmap_config wm8804_regmap_config = {
-- 
1.7.2.5
