From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH v2 3/4] ASoC: wm8804: Add DAPM widgets for SPDIF/AIF
Date: Tue,  7 Apr 2015 11:34:52 +0100
Message-ID: <1428402893-11787-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428402893-11787-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428402893-11787-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, info-Ht5PubfIbSajfpyLsbbDOw@public.gmane.org, sapthagiri.baratam-sjhevXS25z0S+FvcfC7Uqw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Sapthagiri Baratam <sapthagiri.baratam-sjhevXS25z0S+FvcfC7Uqw@public.gmane.org>

This change converts the driver to use DAPM to control the power for the
various blocks on the chip. As part of this change the existing controls
"TX Playback Switch" (controlled power for the SPDIF TX block) and "AIF
Playback Switch" (controlled power for the AIF block) are both removed,
as they are now redundant since the power state of those blocks is
controlled automatically by DAPM.

There are several benefits of this change, the most important of which
is this change adds support for powering down the SPDIF RX block. The RX
block will automatically assume control of the PLL on the chip when it
is receiving a signal, so leaving this enabled all the time as was
currently done in the driver can be problematic. An incoming SPDIF signal
that is not being used can completely destroy the clocking for an in use
TX signal. But this change ensures that the RX block will only be
powered when the user intends to be receiving data, thus avoiding this
issue.

Additional benefits include the chip being simpler to operate as the
power no longer needs to be manually controlled between use-cases and a
small power saving (although it is acknowledged that this is likely
unimportant in the typical use-cases for this chip).

Signed-off-by: Sapthagiri Baratam <sapthagiri.baratam-sjhevXS25z0S+FvcfC7Uqw@public.gmane.org>
Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---

Changes since v1:
 - Add much more detail in the commit message
 - Don't rename the 'Input Source' control

 sound/soc/codecs/wm8804.c |  140 ++++++++++++++++++++++++++------------------
 1 files changed, 83 insertions(+), 57 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index cc168c4..cff34be 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -25,6 +25,7 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
+#include <sound/soc-dapm.h>
 
 #include "wm8804.h"
 
@@ -64,14 +65,16 @@ struct wm8804_priv {
 	int mclk_div;
 
 	struct gpio_desc *reset;
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
@@ -93,26 +96,62 @@ WM8804_REGULATOR_EVENT(0)
 WM8804_REGULATOR_EVENT(1)
 
 static const char *txsrc_text[] = { "S/PDIF RX", "AIF" };
-static SOC_ENUM_SINGLE_EXT_DECL(txsrc, txsrc_text);
+static const SOC_ENUM_SINGLE_DECL(txsrc, WM8804_SPDTX4, 6, txsrc_text);
 
-static const struct snd_kcontrol_new wm8804_snd_controls[] = {
-	SOC_ENUM_EXT("Input Source", txsrc, txsrc_get, txsrc_put),
-	SOC_SINGLE("TX Playback Switch", WM8804_PWRDN, 2, 1, 1),
-	SOC_SINGLE("AIF Playback Switch", WM8804_PWRDN, 4, 1, 1)
+static const struct snd_kcontrol_new wm8804_tx_source_mux[] = {
+	SOC_DAPM_ENUM_EXT("Input Source", txsrc,
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
@@ -120,48 +159,33 @@ static int txsrc_get(struct snd_kcontrol *kcontrol,
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
@@ -558,8 +582,10 @@ static const struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
