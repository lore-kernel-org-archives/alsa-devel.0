From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/8] ASoC: tlv320aic32x4: Convert table based
	control and DAPM setup
Date: Tue, 27 Aug 2013 15:50:56 +0200
Message-ID: <1377611461-3638-3-git-send-email-lars@metafoo.de>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-185.synserver.de (smtp-out-185.synserver.de
 [212.40.185.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E23B260845
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 15:49:37 +0200 (CEST)
In-Reply-To: <1377611461-3638-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

Let the core take care of instantiating the controls and DAPM widgets and
routes, this makes the code a bit shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Javier Martin <javier.martin@vista-silicon.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 17df4e3..2ed57d4 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -338,18 +338,6 @@ static inline int aic32x4_get_divs(int mclk, int rate)
 	return -EINVAL;
 }
 
-static int aic32x4_add_widgets(struct snd_soc_codec *codec)
-{
-	snd_soc_dapm_new_controls(&codec->dapm, aic32x4_dapm_widgets,
-				  ARRAY_SIZE(aic32x4_dapm_widgets));
-
-	snd_soc_dapm_add_routes(&codec->dapm, aic32x4_dapm_routes,
-				ARRAY_SIZE(aic32x4_dapm_routes));
-
-	snd_soc_dapm_new_widgets(&codec->dapm);
-	return 0;
-}
-
 static int aic32x4_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				  int clk_id, unsigned int freq, int dir)
 {
@@ -683,9 +671,6 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 	}
 
 	aic32x4_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	snd_soc_add_codec_controls(codec, aic32x4_snd_controls,
-			     ARRAY_SIZE(aic32x4_snd_controls));
-	aic32x4_add_widgets(codec);
 
 	/*
 	 * Workaround: for an unknown reason, the ADC needs to be powered up
@@ -714,6 +699,13 @@ static struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
 	.suspend = aic32x4_suspend,
 	.resume = aic32x4_resume,
 	.set_bias_level = aic32x4_set_bias_level,
+
+	.controls = aic32x4_snd_controls,
+	.num_controls = ARRAY_SIZE(aic32x4_snd_controls),
+	.dapm_widgets = aic32x4_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(aic32x4_dapm_widgets),
+	.dapm_routes = aic32x4_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(aic32x4_dapm_routes),
 };
 
 static int aic32x4_i2c_probe(struct i2c_client *i2c,
-- 
1.8.0
