From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 16/22] ASoC: tas2552: Implement startup/stop
	sequence as per TRM
Date: Thu, 4 Jun 2015 15:22:40 +0300
Message-ID: <1433420571-5421-17-git-send-email-peter.ujfalusi@ti.com>
References: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A6B22664E9
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:23:33 +0200 (CEST)
In-Reply-To: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Certain sequence need to be followed in order to have smooth power up and
power down performance.
Execute this sequence via DAPM_POST widget.
Remove patching the RESERVED_0D register at probe time since it has to be
handled every time when we stop or start the amplifier.
In order to be able to execute the sequence at the correct time, the driver
need to request to ignore the pmdown time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index fe2e4d384a00..9c081344bd90 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -46,7 +46,7 @@ static struct reg_default tas2552_reg_defs[] = {
 	{TAS2552_PDM_CFG, 0x01},
 	{TAS2552_PGA_GAIN, 0x00},
 	{TAS2552_BOOST_PT_CTRL, 0x0f},
-	{TAS2552_RESERVED_0D, 0x00},
+	{TAS2552_RESERVED_0D, 0xbe},
 	{TAS2552_LIMIT_RATE_HYS, 0x08},
 	{TAS2552_CFG_2, 0xef},
 	{TAS2552_SER_CTRL_1, 0x00},
@@ -83,6 +83,29 @@ struct tas2552_data {
 	unsigned int tdm_delay;
 };
 
+static int tas2552_post_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_write(codec, TAS2552_RESERVED_0D, 0xc0);
+		snd_soc_update_bits(codec, TAS2552_LIMIT_RATE_HYS, (1 << 5),
+				    (1 << 5));
+		snd_soc_update_bits(codec, TAS2552_CFG_2, 1, 0);
+		snd_soc_update_bits(codec, TAS2552_CFG_1, TAS2552_SWS, 0);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, TAS2552_CFG_1, TAS2552_SWS,
+				    TAS2552_SWS);
+		snd_soc_update_bits(codec, TAS2552_CFG_2, 1, 1);
+		snd_soc_update_bits(codec, TAS2552_LIMIT_RATE_HYS, (1 << 5), 0);
+		snd_soc_write(codec, TAS2552_RESERVED_0D, 0xbe);
+		break;
+	}
+	return 0;
+}
 
 /* Input mux controls */
 static const char * const tas2552_input_texts[] = {
@@ -105,6 +128,7 @@ static const struct snd_soc_dapm_widget tas2552_dapm_widgets[] =
 	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUT_DRV("ClassD", TAS2552_CFG_2, 7, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("PLL", TAS2552_CFG_2, 3, 0, NULL, 0),
+	SND_SOC_DAPM_POST("Post Event", tas2552_post_event),
 
 	SND_SOC_DAPM_OUTPUT("OUT")
 };
@@ -413,10 +437,6 @@ static const struct snd_kcontrol_new tas2552_snd_controls[] = {
 			 TAS2552_PGA_GAIN, 0, 0x1f, 0, dac_tlv),
 };
 
-static const struct reg_default tas2552_init_regs[] = {
-	{ TAS2552_RESERVED_0D, 0xc0 },
-};
-
 static int tas2552_codec_probe(struct snd_soc_codec *codec)
 {
 	struct tas2552_data *tas2552 = snd_soc_codec_get_drvdata(codec);
@@ -443,7 +463,7 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 		goto probe_fail;
 	}
 
-	snd_soc_write(codec, TAS2552_CFG_1, TAS2552_MUTE);
+	snd_soc_update_bits(codec, TAS2552_CFG_1, TAS2552_MUTE, TAS2552_MUTE);
 	snd_soc_write(codec, TAS2552_CFG_3, TAS2552_I2S_OUT_SEL |
 				TAS2552_DIN_SRC_SEL_AVG_L_R | TAS2552_88_96KHZ);
 	snd_soc_write(codec, TAS2552_DOUT, TAS2552_PDM_DATA_I);
@@ -451,21 +471,11 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, TAS2552_BOOST_PT_CTRL, TAS2552_APT_DELAY_200 |
 				TAS2552_APT_THRESH_2_1_7);
 
-	ret = regmap_register_patch(tas2552->regmap, tas2552_init_regs,
-					    ARRAY_SIZE(tas2552_init_regs));
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to write init registers: %d\n",
-			ret);
-		goto patch_fail;
-	}
-
 	snd_soc_write(codec, TAS2552_CFG_2, TAS2552_BOOST_EN |
 				  TAS2552_APT_EN | TAS2552_LIM_EN);
 
 	return 0;
 
-patch_fail:
-	pm_runtime_put(codec->dev);
 probe_fail:
 	if (tas2552->enable_gpio)
 		gpiod_set_value(tas2552->enable_gpio, 0);
@@ -527,6 +537,8 @@ static struct snd_soc_codec_driver soc_codec_dev_tas2552 = {
 	.remove = tas2552_codec_remove,
 	.suspend =	tas2552_suspend,
 	.resume = tas2552_resume,
+	.ignore_pmdown_time = true,
+
 	.controls = tas2552_snd_controls,
 	.num_controls = ARRAY_SIZE(tas2552_snd_controls),
 	.dapm_widgets = tas2552_dapm_widgets,
-- 
2.4.2
