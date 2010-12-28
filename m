From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/9] ASoC: codecs: wm9090: Fix register cache incoherency
Date: Tue, 28 Dec 2010 21:38:02 +0100
Message-ID: <1293568684-9626-9-git-send-email-lars@metafoo.de>
References: <1293568684-9626-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1293568684-9626-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Ian Lartey <ian@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The multi-component patch(commit f0fba2ad1) moved the allocation of the
register cache from the driver to the ASoC core. Most drivers where adjusted to
this, but the wm9090 driver still uses its own register cache for its
private functions, while functions from the ASoC core use the generic cache.
Thus we end up with two from each other incoherent caches, which can lead to
undefined behaviour.
This patch fixes the issue by changing the wm9090 driver to use the
generic register cache in its private functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ian Lartey <ian@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

---
Compile tested only
---
 sound/soc/codecs/wm9090.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 99c046b..6e5f64f 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -141,7 +141,6 @@ static const u16 wm9090_reg_defaults[] = {
 /* This struct is used to save the context */
 struct wm9090_priv {
 	struct mutex mutex;
-	u16 reg_cache[WM9090_MAX_REGISTER + 1];
 	struct wm9090_platform_data pdata;
 	void *control_data;
 };
@@ -552,6 +551,7 @@ static int wm9090_set_bias_level(struct snd_soc_codec *codec,
 static int wm9090_probe(struct snd_soc_codec *codec)
 {
 	struct wm9090_priv *wm9090 = snd_soc_codec_get_drvdata(codec);
+	u16 *reg_cache = codec->reg_cache;
 	int ret;
 
 	codec->control_data = wm9090->control_data;
@@ -576,22 +576,22 @@ static int wm9090_probe(struct snd_soc_codec *codec)
 	/* Configure some defaults; they will be written out when we
 	 * bring the bias up.
 	 */
-	wm9090->reg_cache[WM9090_IN1_LINE_INPUT_A_VOLUME] |= WM9090_IN1_VU
+	reg_cache[WM9090_IN1_LINE_INPUT_A_VOLUME] |= WM9090_IN1_VU
 		| WM9090_IN1A_ZC;
-	wm9090->reg_cache[WM9090_IN1_LINE_INPUT_B_VOLUME] |= WM9090_IN1_VU
+	reg_cache[WM9090_IN1_LINE_INPUT_B_VOLUME] |= WM9090_IN1_VU
 		| WM9090_IN1B_ZC;
-	wm9090->reg_cache[WM9090_IN2_LINE_INPUT_A_VOLUME] |= WM9090_IN2_VU
+	reg_cache[WM9090_IN2_LINE_INPUT_A_VOLUME] |= WM9090_IN2_VU
 		| WM9090_IN2A_ZC;
-	wm9090->reg_cache[WM9090_IN2_LINE_INPUT_B_VOLUME] |= WM9090_IN2_VU
+	reg_cache[WM9090_IN2_LINE_INPUT_B_VOLUME] |= WM9090_IN2_VU
 		| WM9090_IN2B_ZC;
-	wm9090->reg_cache[WM9090_SPEAKER_VOLUME_LEFT] |=
+	reg_cache[WM9090_SPEAKER_VOLUME_LEFT] |=
 		WM9090_SPKOUT_VU | WM9090_SPKOUTL_ZC;
-	wm9090->reg_cache[WM9090_LEFT_OUTPUT_VOLUME] |=
+	reg_cache[WM9090_LEFT_OUTPUT_VOLUME] |=
 		WM9090_HPOUT1_VU | WM9090_HPOUT1L_ZC;
-	wm9090->reg_cache[WM9090_RIGHT_OUTPUT_VOLUME] |=
+	reg_cache[WM9090_RIGHT_OUTPUT_VOLUME] |=
 		WM9090_HPOUT1_VU | WM9090_HPOUT1R_ZC;
 
-	wm9090->reg_cache[WM9090_CLOCKING_1] |= WM9090_TOCLK_ENA;
+	reg_cache[WM9090_CLOCKING_1] |= WM9090_TOCLK_ENA;
 
 	wm9090_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-- 
1.7.2.3
