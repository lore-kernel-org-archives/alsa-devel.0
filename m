From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: wm8350: Remove direct usage of
	codec->control_data
Date: Mon, 30 Apr 2012 22:53:15 +0100
Message-ID: <1335822795-4720-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1335822795-4720-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5CB9910419C
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 23:53:23 +0200 (CEST)
In-Reply-To: <1335822795-4720-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Supports regmap conversion.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8350.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index f610518..ec560d3 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -92,7 +92,7 @@ static inline int wm8350_out1_ramp_step(struct snd_soc_codec *codec)
 {
 	struct wm8350_data *wm8350_data = snd_soc_codec_get_drvdata(codec);
 	struct wm8350_output *out1 = &wm8350_data->out1;
-	struct wm8350 *wm8350 = codec->control_data;
+	struct wm8350 *wm8350 = wm8350_data->wm8350;
 	int left_complete = 0, right_complete = 0;
 	u16 reg, val;
 
@@ -158,7 +158,7 @@ static inline int wm8350_out2_ramp_step(struct snd_soc_codec *codec)
 {
 	struct wm8350_data *wm8350_data = snd_soc_codec_get_drvdata(codec);
 	struct wm8350_output *out2 = &wm8350_data->out2;
-	struct wm8350 *wm8350 = codec->control_data;
+	struct wm8350 *wm8350 = wm8350_data->wm8350;
 	int left_complete = 0, right_complete = 0;
 	u16 reg, val;
 
@@ -774,7 +774,8 @@ static int wm8350_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				 int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8350 *wm8350 = codec->control_data;
+	struct wm8350_data *wm8350_data = snd_soc_codec_get_drvdata(codec);
+	struct wm8350 *wm8350 = wm8350_data->wm8350;
 	u16 fll_4;
 
 	switch (clk_id) {
@@ -927,7 +928,8 @@ static int wm8350_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *codec_dai)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8350 *wm8350 = codec->control_data;
+	struct wm8350_data *wm8350_data = snd_soc_codec_get_drvdata(codec);
+	struct wm8350 *wm8350 = wm8350_data->wm8350;
 	u16 iface = snd_soc_read(codec, WM8350_AI_FORMATING) &
 	    ~WM8350_AIF_WL_MASK;
 
@@ -966,12 +968,15 @@ static int wm8350_pcm_hw_params(struct snd_pcm_substream *substream,
 static int wm8350_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct wm8350 *wm8350 = codec->control_data;
+	unsigned int val;
 
 	if (mute)
-		wm8350_set_bits(wm8350, WM8350_DAC_MUTE, WM8350_DAC_MUTE_ENA);
+		val = WM8350_DAC_MUTE_ENA;
 	else
-		wm8350_clear_bits(wm8350, WM8350_DAC_MUTE, WM8350_DAC_MUTE_ENA);
+		val = 0;
+
+	snd_soc_update_bits(codec, WM8350_DAC_MUTE, WM8350_DAC_MUTE_ENA, val);
+
 	return 0;
 }
 
@@ -1040,8 +1045,8 @@ static int wm8350_set_fll(struct snd_soc_dai *codec_dai,
 			  unsigned int freq_out)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8350 *wm8350 = codec->control_data;
 	struct wm8350_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct wm8350 *wm8350 = priv->wm8350;
 	struct _fll_div fll_div;
 	int ret = 0;
 	u16 fll_1, fll_4;
@@ -1092,8 +1097,8 @@ static int wm8350_set_fll(struct snd_soc_dai *codec_dai,
 static int wm8350_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8350 *wm8350 = codec->control_data;
 	struct wm8350_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct wm8350 *wm8350 = priv->wm8350;
 	struct wm8350_audio_platform_data *platform =
 		wm8350->codec.platform_data;
 	u16 pm1;
@@ -1348,7 +1353,7 @@ int wm8350_hp_jack_detect(struct snd_soc_codec *codec, enum wm8350_jack which,
 			  struct snd_soc_jack *jack, int report)
 {
 	struct wm8350_data *priv = snd_soc_codec_get_drvdata(codec);
-	struct wm8350 *wm8350 = codec->control_data;
+	struct wm8350 *wm8350 = priv->wm8350;
 	int irq;
 	int ena;
 
@@ -1424,7 +1429,7 @@ int wm8350_mic_jack_detect(struct snd_soc_codec *codec,
 			   int detect_report, int short_report)
 {
 	struct wm8350_data *priv = snd_soc_codec_get_drvdata(codec);
-	struct wm8350 *wm8350 = codec->control_data;
+	struct wm8350 *wm8350 = priv->wm8350;
 
 	priv->mic.jack = jack;
 	priv->mic.report = detect_report;
-- 
1.7.10
