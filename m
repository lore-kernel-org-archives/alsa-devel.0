From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: ak4642: Convert to table based
	control init
Date: Thu, 28 Nov 2013 18:04:47 +0000
Message-ID: <1385661888-11924-2-git-send-email-broonie@kernel.org>
References: <1385661888-11924-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F257261A59
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 19:04:55 +0100 (CET)
In-Reply-To: <1385661888-11924-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Improves error handling and saves code.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ak4642.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 5bb18e913fa5..d16c4ac5b27d 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -469,9 +469,6 @@ static int ak4642_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	snd_soc_add_codec_controls(codec, ak4642_snd_controls,
-			     ARRAY_SIZE(ak4642_snd_controls));
-
 	ak4642_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
@@ -491,6 +488,8 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4642 = {
 	.reg_cache_default	= ak4642_reg,			/* ak4642 reg */
 	.reg_cache_size		= ARRAY_SIZE(ak4642_reg),	/* ak4642 reg */
 	.reg_word_size		= sizeof(u8),
+	.controls		= ak4642_snd_controls,
+	.num_controls		= ARRAY_SIZE(ak4642_snd_controls),
 	.dapm_widgets		= ak4642_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(ak4642_dapm_widgets),
 	.dapm_routes		= ak4642_intercon,
@@ -505,6 +504,8 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4648 = {
 	.reg_cache_default	= ak4648_reg,			/* ak4648 reg */
 	.reg_cache_size		= ARRAY_SIZE(ak4648_reg),	/* ak4648 reg */
 	.reg_word_size		= sizeof(u8),
+	.controls		= ak4642_snd_controls,
+	.num_controls		= ARRAY_SIZE(ak4642_snd_controls),
 	.dapm_widgets		= ak4642_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(ak4642_dapm_widgets),
 	.dapm_routes		= ak4642_intercon,
-- 
1.8.4.4
