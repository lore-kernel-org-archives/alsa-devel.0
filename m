From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: max90895: Convert to table based
	control init
Date: Mon, 23 Sep 2013 19:10:12 +0100
Message-ID: <1379959813-22993-2-git-send-email-broonie@kernel.org>
References: <1379959813-22993-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A7D922610B4
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 20:10:34 +0200 (CEST)
In-Reply-To: <1379959813-22993-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <peter.hsiang@maxim-ic.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max98095.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 29c266b..474823a 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1268,14 +1268,6 @@ static const struct snd_soc_dapm_route max98095_audio_map[] = {
 	{"MIC2 Input", NULL, "MIC2"},
 };
 
-static int max98095_add_widgets(struct snd_soc_codec *codec)
-{
-	snd_soc_add_codec_controls(codec, max98095_snd_controls,
-			     ARRAY_SIZE(max98095_snd_controls));
-
-	return 0;
-}
-
 /* codec mclk clock divider coefficients */
 static const struct {
 	u32 rate;
@@ -2430,8 +2422,6 @@ static int max98095_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, M98095_097_PWR_SYS, M98095_SHDNRUN,
 		M98095_SHDNRUN);
 
-	max98095_add_widgets(codec);
-
 	return 0;
 
 err_irq:
@@ -2463,6 +2453,8 @@ static struct snd_soc_codec_driver soc_codec_dev_max98095 = {
 	.suspend = max98095_suspend,
 	.resume  = max98095_resume,
 	.set_bias_level = max98095_set_bias_level,
+	.controls = max98095_snd_controls,
+	.num_controls = ARRAY_SIZE(max98095_snd_controls),
 	.reg_cache_size = ARRAY_SIZE(max98095_reg_def),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = max98095_reg_def,
-- 
1.8.4.rc3
