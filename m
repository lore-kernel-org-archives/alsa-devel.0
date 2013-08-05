From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: pcm1792a: Fix build with !OF
Date: Mon,  5 Aug 2013 18:22:18 +0100
Message-ID: <1375723338-19057-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D8021265144
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 19:22:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm1792a.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
index 3f83bf9..72cf835 100644
--- a/sound/soc/codecs/pcm1792a.c
+++ b/sound/soc/codecs/pcm1792a.c
@@ -169,13 +169,11 @@ static struct snd_soc_dai_driver pcm1792a_dai = {
 	.ops = &pcm1792a_dai_ops,
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id pcm1792a_of_match[] = {
 	{ .compatible = "ti,pcm1792a", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pcm1792a_of_match);
-#endif
 
 static const struct regmap_config pcm1792a_regmap = {
 	.reg_bits		= 8,
@@ -231,7 +229,7 @@ static struct spi_driver pcm1792a_codec_driver = {
 	.driver = {
 		.name = "pcm1792a",
 		.owner = THIS_MODULE,
-		.of_match_table = pcm1792a_of_match,
+		.of_match_table = of_match_ptr(pcm1792a_of_match),
 	},
 	.id_table = pcm1792a_spi_ids,
 	.probe = pcm1792a_spi_probe,
-- 
1.8.4.rc0
