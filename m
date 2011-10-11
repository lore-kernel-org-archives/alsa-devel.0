From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl6040: Convert to table based init
Date: Tue, 11 Oct 2011 13:11:12 +0300
Message-ID: <1318327872-7104-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog112.obsmtp.com (na3sys009aog112.obsmtp.com
	[74.125.149.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 8423C243D3
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 12:11:24 +0200 (CEST)
Received: by bkbzs2 with SMTP id zs2so9914751bkb.28
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2011 03:11:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   31 ++++++++++---------------------
 1 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 62edded..93f8a59 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1183,18 +1183,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"AUXR", NULL, "AUXR Playback"},
 };
 
-static int twl6040_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, twl6040_dapm_widgets,
-				 ARRAY_SIZE(twl6040_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-	snd_soc_dapm_new_widgets(dapm);
-
-	return 0;
-}
-
 static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 				enum snd_soc_bias_level level)
 {
@@ -1503,16 +1491,10 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 
 	/* power on device */
 	ret = twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	if (ret)
-		goto bias_err;
-
-	snd_soc_add_controls(codec, twl6040_snd_controls,
-				ARRAY_SIZE(twl6040_snd_controls));
-	twl6040_add_widgets(codec);
-
-	return 0;
+	if (!ret)
+		return 0;
 
-bias_err:
+	/* Error path */
 	free_irq(priv->plug_irq, codec);
 plugirq_err:
 	destroy_workqueue(priv->workqueue);
@@ -1544,6 +1526,13 @@ static struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
 	.reg_cache_size = ARRAY_SIZE(twl6040_reg),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = twl6040_reg,
+
+	.controls = twl6040_snd_controls,
+	.num_controls = ARRAY_SIZE(twl6040_snd_controls),
+	.dapm_widgets = twl6040_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(twl6040_dapm_widgets),
+	.dapm_routes = intercon,
+	.num_dapm_routes = ARRAY_SIZE(intercon),
 };
 
 static int __devinit twl6040_codec_probe(struct platform_device *pdev)
-- 
1.7.7
