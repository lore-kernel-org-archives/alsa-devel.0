From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Automatically manage WM8731
	deemphasis
Date: Thu,  2 Dec 2010 11:47:54 +0000
Message-ID: <1291290474-816-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1291290474-816-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64F1B103A54
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 12:47:57 +0100 (CET)
In-Reply-To: <1291290474-816-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The deemphasis filter should be selected based on sample rate for
optimal performance.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |   76 ++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 8003761..71122dc 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -46,6 +46,8 @@ struct wm8731_priv {
 	u16 reg_cache[WM8731_CACHEREGNUM];
 	unsigned int sysclk;
 	int sysclk_type;
+	int playback_fs;
+	bool deemph;
 };
 
 
@@ -65,14 +67,73 @@ static const u16 wm8731_reg[WM8731_CACHEREGNUM] = {
 
 static const char *wm8731_input_select[] = {"Line In", "Mic"};
 
-static const char *wm8731_deemph[] = {"None", "32Khz", "44.1Khz", "48Khz"};
-
 static const struct soc_enum wm8731_insel_enum =
 	SOC_ENUM_SINGLE(WM8731_APANA, 2, 2, wm8731_input_select);
 
-static const struct soc_enum wm8731_deemph_enum =
-	SOC_ENUM_SINGLE(WM8731_APDIGI, 1, 4, wm8731_deemph);
+static int wm8731_deemph[] = { 0, 32000, 44100, 48000 };
+
+static int wm8731_set_deemph(struct snd_soc_codec *codec)
+{
+	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
+	int val, i, best;
+
+	/* If we're using deemphasis select the nearest available sample
+	 * rate.
+	 */
+	if (wm8731->deemph) {
+		best = 1;
+		for (i = 2; i < ARRAY_SIZE(wm8731_deemph); i++) {
+			if (abs(wm8731_deemph[i] - wm8731->playback_fs) <
+			    abs(wm8731_deemph[best] - wm8731->playback_fs))
+				best = i;
+		}
+
+		val = best << 1;
+	} else {
+		best = 0;
+		val = 0;
+	}
+
+	dev_dbg(codec->dev, "Set deemphasis %d (%dHz)\n",
+		best, wm8731_deemph[best]);
 
+	return snd_soc_update_bits(codec, WM8731_APDIGI, 0x6, val);
+}
+
+static int wm8731_get_deemph(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = wm8731->deemph;
+
+	return 0;
+}
+
+static int wm8731_put_deemph(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
+	int deemph = ucontrol->value.enumerated.item[0];
+	int ret = 0;
+
+	if (deemph > 1)
+		return -EINVAL;
+
+	mutex_lock(&codec->mutex);
+	if (wm8731->deemph != deemph) {
+		wm8731->deemph = deemph;
+
+		wm8731_set_deemph(codec);
+
+		ret = 1;
+	}
+	mutex_unlock(&codec->mutex);
+
+	return ret;
+}
 
 static const DECLARE_TLV_DB_SCALE(in_tlv, -3450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(sidetone_tlv, -1500, 300, 0);
@@ -99,7 +160,8 @@ SOC_SINGLE_TLV("Sidetone Playback Volume", WM8731_APANA, 6, 3, 1,
 SOC_SINGLE("ADC High Pass Filter Switch", WM8731_APDIGI, 0, 1, 1),
 SOC_SINGLE("Store DC Offset Switch", WM8731_APDIGI, 4, 1, 0),
 
-SOC_ENUM("Playback De-emphasis", wm8731_deemph_enum),
+SOC_SINGLE_BOOL_EXT("Playback Deemphasis Switch", 0,
+		    wm8731_get_deemph, wm8731_put_deemph),
 };
 
 /* Output Mixer */
@@ -243,6 +305,8 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 	u16 srate = (coeff_div[i].sr << 2) |
 		(coeff_div[i].bosr << 1) | coeff_div[i].usb;
 
+	wm8731->playback_fs = params_rate(params);
+
 	snd_soc_write(codec, WM8731_SRATE, srate);
 
 	/* bit size */
@@ -257,6 +321,8 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
+	wm8731_set_deemph(codec);
+
 	snd_soc_write(codec, WM8731_IFACE, iface);
 	return 0;
 }
-- 
1.7.1
