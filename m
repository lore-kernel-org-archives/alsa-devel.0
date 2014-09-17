From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [PATCHv4 1/9] Clean WM8971 through checkpatch
Date: Wed, 17 Sep 2014 16:41:07 +0800
Message-ID: <1410943275-4160-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Kraken (unknown [124.219.7.128])
 by alsa0.perex.cz (Postfix) with ESMTP id E5E272652D0
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 10:41:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
Cc: Xavier Hsu <xavier.hsu@linaro.org>, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, Andy Green <andy.green@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch improves WM8971.
We clean the file through checkpatch.

Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
Any comments about improving the patch are welcome.
Thanks.

 sound/soc/codecs/wm8971.c |  108 +++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 52 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 0499cd4..c0f7e9b 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -31,7 +31,7 @@
 
 #define	WM8971_REG_COUNT		43
 
-static struct workqueue_struct *wm8971_workq = NULL;
+static struct workqueue_struct *wm8971_workq;
 
 /* codec private data */
 struct wm8971_priv {
@@ -92,25 +92,28 @@ static const struct reg_default wm8971_reg_defaults[] = {
 #define wm8971_reset(c)	snd_soc_write(c, WM8971_RESET, 0)
 
 /* WM8971 Controls */
-static const char *wm8971_bass[] = { "Linear Control", "Adaptive Boost" };
-static const char *wm8971_bass_filter[] = { "130Hz @ 48kHz",
-	"200Hz @ 48kHz" };
-static const char *wm8971_treble[] = { "8kHz", "4kHz" };
-static const char *wm8971_alc_func[] = { "Off", "Right", "Left", "Stereo" };
-static const char *wm8971_ng_type[] = { "Constant PGA Gain",
-	"Mute ADC Output" };
-static const char *wm8971_deemp[] = { "None", "32kHz", "44.1kHz", "48kHz" };
-static const char *wm8971_mono_mux[] = {"Stereo", "Mono (Left)",
-	"Mono (Right)", "Digital Mono"};
-static const char *wm8971_dac_phase[] = { "Non Inverted", "Inverted" };
-static const char *wm8971_lline_mux[] = {"Line", "NC", "NC", "PGA",
-	"Differential"};
-static const char *wm8971_rline_mux[] = {"Line", "Mic", "NC", "PGA",
-	"Differential"};
-static const char *wm8971_lpga_sel[] = {"Line", "NC", "NC", "Differential"};
-static const char *wm8971_rpga_sel[] = {"Line", "Mic", "NC", "Differential"};
-static const char *wm8971_adcpol[] = {"Normal", "L Invert", "R Invert",
-	"L + R Invert"};
+static const char const *wm8971_bass[] = {"Linear Control", "Adaptive Boost"};
+static const char const *wm8971_bass_filter[] = {"130Hz @ 48kHz",
+						 "200Hz @ 48kHz"};
+static const char const *wm8971_treble[] = {"8kHz", "4kHz"};
+static const char const *wm8971_alc_func[] = {"Off", "Right",
+					      "Left", "Stereo"};
+static const char const *wm8971_ng_type[] = {"Constant PGA Gain",
+					     "Mute ADC Output"};
+static const char const *wm8971_deemp[] = {"None", "32kHz", "44.1kHz", "48kHz"};
+static const char const *wm8971_mono_mux[] = {"Stereo", "Mono (Left)",
+					      "Mono (Right)", "Digital Mono"};
+static const char const *wm8971_dac_phase[] = {"Non Inverted", "Inverted"};
+static const char const *wm8971_lline_mux[] = {"Line", "NC", "NC",
+					       "PGA", "Differential"};
+static const char const *wm8971_rline_mux[] = {"Line", "Mic", "NC",
+					       "PGA", "Differential"};
+static const char const *wm8971_lpga_sel[] = {"Line", "NC", "NC",
+					      "Differential"};
+static const char const *wm8971_rpga_sel[] = {"Line", "Mic", "NC",
+					      "Differential"};
+static const char const *wm8971_adcpol[] = {"Normal", "L Invert",
+					    "R Invert", "L + R Invert"};
 
 static const struct soc_enum wm8971_enum[] = {
 	SOC_ENUM_SINGLE(WM8971_BASS, 7, 2, wm8971_bass),	/* 0 */
@@ -136,24 +139,24 @@ static const struct snd_kcontrol_new wm8971_snd_controls[] = {
 	SOC_DOUBLE_R("Capture Switch", WM8971_LINVOL, WM8971_RINVOL, 7, 1, 1),
 
 	SOC_DOUBLE_R("Headphone Playback ZC Switch", WM8971_LOUT1V,
-		WM8971_ROUT1V, 7, 1, 0),
+		     WM8971_ROUT1V, 7, 1, 0),
 	SOC_DOUBLE_R("Speaker Playback ZC Switch", WM8971_LOUT2V,
-		WM8971_ROUT2V, 7, 1, 0),
+		     WM8971_ROUT2V, 7, 1, 0),
 	SOC_SINGLE("Mono Playback ZC Switch", WM8971_MOUTV, 7, 1, 0),
 
 	SOC_DOUBLE_R("PCM Volume", WM8971_LDAC, WM8971_RDAC, 0, 255, 0),
 
 	SOC_DOUBLE_R("Bypass Left Playback Volume", WM8971_LOUTM1,
-		WM8971_LOUTM2, 4, 7, 1),
+		     WM8971_LOUTM2, 4, 7, 1),
 	SOC_DOUBLE_R("Bypass Right Playback Volume", WM8971_ROUTM1,
-		WM8971_ROUTM2, 4, 7, 1),
+		     WM8971_ROUTM2, 4, 7, 1),
 	SOC_DOUBLE_R("Bypass Mono Playback Volume", WM8971_MOUTM1,
-		WM8971_MOUTM2, 4, 7, 1),
+		     WM8971_MOUTM2, 4, 7, 1),
 
 	SOC_DOUBLE_R("Headphone Playback Volume", WM8971_LOUT1V,
-		WM8971_ROUT1V, 0, 127, 0),
+		     WM8971_ROUT1V, 0, 127, 0),
 	SOC_DOUBLE_R("Speaker Playback Volume", WM8971_LOUT2V,
-		WM8971_ROUT2V, 0, 127, 0),
+		     WM8971_ROUT2V, 0, 127, 0),
 
 	SOC_ENUM("Bass Boost", wm8971_enum[0]),
 	SOC_ENUM("Bass Filter", wm8971_enum[1]),
@@ -238,14 +241,14 @@ SOC_DAPM_ENUM("Route", wm8971_enum[13]);
 
 static const struct snd_soc_dapm_widget wm8971_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
-		&wm8971_left_mixer_controls[0],
-		ARRAY_SIZE(wm8971_left_mixer_controls)),
+			   &wm8971_left_mixer_controls[0],
+			   ARRAY_SIZE(wm8971_left_mixer_controls)),
 	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
-		&wm8971_right_mixer_controls[0],
-		ARRAY_SIZE(wm8971_right_mixer_controls)),
+			   &wm8971_right_mixer_controls[0],
+			   ARRAY_SIZE(wm8971_right_mixer_controls)),
 	SND_SOC_DAPM_MIXER("Mono Mixer", WM8971_PWR2, 2, 0,
-		&wm8971_mono_mixer_controls[0],
-		ARRAY_SIZE(wm8971_mono_mixer_controls)),
+			   &wm8971_mono_mixer_controls[0],
+			   ARRAY_SIZE(wm8971_mono_mixer_controls)),
 
 	SND_SOC_DAPM_PGA("Right Out 2", WM8971_PWR2, 3, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("Left Out 2", WM8971_PWR2, 4, 0, NULL, 0),
@@ -260,18 +263,18 @@ static const struct snd_soc_dapm_widget wm8971_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", WM8971_PWR1, 3, 0),
 
 	SND_SOC_DAPM_MUX("Left PGA Mux", WM8971_PWR1, 5, 0,
-		&wm8971_left_pga_controls),
+			 &wm8971_left_pga_controls),
 	SND_SOC_DAPM_MUX("Right PGA Mux", WM8971_PWR1, 4, 0,
-		&wm8971_right_pga_controls),
+			 &wm8971_right_pga_controls),
 	SND_SOC_DAPM_MUX("Left Line Mux", SND_SOC_NOPM, 0, 0,
-		&wm8971_left_line_controls),
+			 &wm8971_left_line_controls),
 	SND_SOC_DAPM_MUX("Right Line Mux", SND_SOC_NOPM, 0, 0,
-		&wm8971_right_line_controls),
+			 &wm8971_right_line_controls),
 
 	SND_SOC_DAPM_MUX("Left ADC Mux", SND_SOC_NOPM, 0, 0,
-		&wm8971_monomux_controls),
+			 &wm8971_monomux_controls),
 	SND_SOC_DAPM_MUX("Right ADC Mux", SND_SOC_NOPM, 0, 0,
-		&wm8971_monomux_controls),
+			 &wm8971_monomux_controls),
 
 	SND_SOC_DAPM_OUTPUT("LOUT1"),
 	SND_SOC_DAPM_OUTPUT("ROUT1"),
@@ -431,7 +434,7 @@ static int get_coeff(int mclk, int rate)
 }
 
 static int wm8971_set_dai_sysclk(struct snd_soc_dai *codec_dai,
-		int clk_id, unsigned int freq, int dir)
+				 int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
@@ -449,7 +452,7 @@ static int wm8971_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 }
 
 static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
-		unsigned int fmt)
+			      unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	u16 iface = 0;
@@ -507,8 +510,8 @@ static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
 }
 
 static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params,
-	struct snd_soc_dai *dai)
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
@@ -553,7 +556,7 @@ static int wm8971_mute(struct snd_soc_dai *dai, int mute)
 }
 
 static int wm8971_set_bias_level(struct snd_soc_codec *codec,
-	enum snd_soc_bias_level level)
+				 enum snd_soc_bias_level level)
 {
 	u16 pwr_reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
 
@@ -580,11 +583,12 @@ static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 }
 
 #define WM8971_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | \
-		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+		      SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
+		      SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
+		      SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 
 #define WM8971_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
-	SNDRV_PCM_FMTBIT_S24_LE)
+			SNDRV_PCM_FMTBIT_S24_LE)
 
 static const struct snd_soc_dai_ops wm8971_dai_ops = {
 	.hw_params	= wm8971_pcm_hw_params,
@@ -616,6 +620,7 @@ static void wm8971_work(struct work_struct *work)
 		container_of(work, struct snd_soc_dapm_context,
 			     delayed_work.work);
 	struct snd_soc_codec *codec = dapm->codec;
+
 	wm8971_set_bias_level(codec, codec->dapm.bias_level);
 }
 
@@ -637,7 +642,7 @@ static int wm8971_resume(struct snd_soc_codec *codec)
 		snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
 		codec->dapm.bias_level = SND_SOC_BIAS_ON;
 		queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
-			msecs_to_jiffies(1000));
+				   msecs_to_jiffies(1000));
 	}
 
 	return 0;
@@ -660,7 +665,7 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
 	codec->dapm.bias_level = SND_SOC_BIAS_STANDBY;
 	queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
-		msecs_to_jiffies(1000));
+			   msecs_to_jiffies(1000));
 
 	/* set the update bits */
 	snd_soc_update_bits(codec, WM8971_LDAC, 0x0100, 0x0100);
@@ -675,7 +680,6 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 	return ret;
 }
 
-
 /* power down chip */
 static int wm8971_remove(struct snd_soc_codec *codec)
 {
@@ -729,8 +733,8 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8971);
 
-	ret = snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8971, &wm8971_dai, 1);
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_wm8971,
+				     &wm8971_dai, 1);
 
 	return ret;
 }
-- 
1.7.9.5
