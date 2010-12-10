From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Automatically manage WM8903
	deemphasis rate
Date: Fri, 10 Dec 2010 19:17:08 +0000
Message-ID: <1292008628-29457-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1292008628-29457-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D7286245E2
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 20:17:12 +0100 (CET)
In-Reply-To: <1292008628-29457-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Provide the user with a boolean control then automatically select
the deemphasis filter most closely matching the sample rate.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   82 ++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index f9ae403..d015745 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -218,6 +218,9 @@ struct wm8903_priv {
 	int sysclk;
 	int irq;
 
+	int fs;
+	int deemph;
+
 	/* Reference count */
 	int class_w_users;
 
@@ -457,6 +460,72 @@ static int wm8903_class_w_put(struct snd_kcontrol *kcontrol,
 	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
 
 
+static int wm8903_deemph[] = { 0, 32000, 44100, 48000 };
+
+static int wm8903_set_deemph(struct snd_soc_codec *codec)
+{
+	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
+	int val, i, best;
+
+	/* If we're using deemphasis select the nearest available sample
+	 * rate.
+	 */
+	if (wm8903->deemph) {
+		best = 1;
+		for (i = 2; i < ARRAY_SIZE(wm8903_deemph); i++) {
+			if (abs(wm8903_deemph[i] - wm8903->fs) <
+			    abs(wm8903_deemph[best] - wm8903->fs))
+				best = i;
+		}
+
+		val = best << WM8903_DEEMPH_SHIFT;
+	} else {
+		best = 0;
+		val = 0;
+	}
+
+	dev_dbg(codec->dev, "Set deemphasis %d (%dHz)\n",
+		best, wm8903_deemph[best]);
+
+	return snd_soc_update_bits(codec, WM8903_DAC_DIGITAL_1,
+				   WM8903_DEEMPH_MASK, val);
+}
+
+static int wm8903_get_deemph(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = wm8903->deemph;
+
+	return 0;
+}
+
+static int wm8903_put_deemph(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
+	int deemph = ucontrol->value.enumerated.item[0];
+	int ret = 0;
+
+	if (deemph > 1)
+		return -EINVAL;
+
+	mutex_lock(&codec->mutex);
+	if (wm8903->deemph != deemph) {
+		wm8903->deemph = deemph;
+
+		wm8903_set_deemph(codec);
+
+		ret = 1;
+	}
+	mutex_unlock(&codec->mutex);
+
+	return ret;
+}
+
 /* ALSA can only do steps of .01dB */
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -7200, 75, 1);
 
@@ -548,13 +617,6 @@ static const char *mute_mode_text[] = {
 static const struct soc_enum mute_mode =
 	SOC_ENUM_SINGLE(WM8903_DAC_DIGITAL_1, 9, 2, mute_mode_text);
 
-static const char *dac_deemphasis_text[] = {
-	"Disabled", "32kHz", "44.1kHz", "48kHz"
-};
-
-static const struct soc_enum dac_deemphasis =
-	SOC_ENUM_SINGLE(WM8903_DAC_DIGITAL_1, 1, 4, dac_deemphasis_text);
-
 static const char *companding_text[] = {
 	"ulaw", "alaw"
 };
@@ -662,9 +724,10 @@ SOC_DOUBLE_R_TLV("Digital Playback Volume", WM8903_DAC_DIGITAL_VOLUME_LEFT,
 SOC_ENUM("DAC Soft Mute Rate", soft_mute),
 SOC_ENUM("DAC Mute Mode", mute_mode),
 SOC_SINGLE("DAC Mono Switch", WM8903_DAC_DIGITAL_1, 12, 1, 0),
-SOC_ENUM("DAC De-emphasis", dac_deemphasis),
 SOC_ENUM("DAC Companding Mode", dac_companding),
 SOC_SINGLE("DAC Companding Switch", WM8903_AUDIO_INTERFACE_0, 1, 1, 0),
+SOC_SINGLE_BOOL_EXT("Playback Deemphasis Switch", 0,
+		    wm8903_get_deemph, wm8903_put_deemph),
 
 /* Headphones */
 SOC_DOUBLE_R("Headphone Switch",
@@ -1374,6 +1437,9 @@ static int wm8903_hw_params(struct snd_pcm_substream *substream,
 	aif2 |= bclk_divs[bclk_div].div;
 	aif3 |= bclk / fs;
 
+	wm8903->fs = params_rate(params);
+	wm8903_set_deemph(codec);
+
 	snd_soc_write(codec, WM8903_CLOCK_RATES_0, clock0);
 	snd_soc_write(codec, WM8903_CLOCK_RATES_1, clock1);
 	snd_soc_write(codec, WM8903_AUDIO_INTERFACE_1, aif1);
-- 
1.7.1
