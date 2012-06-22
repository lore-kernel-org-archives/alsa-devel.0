From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: da732x: Staticise non-exported symbol
	soc_codec_dev_da732x
Date: Fri, 22 Jun 2012 11:36:18 +0100
Message-ID: <1340361378-12192-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E8DD1103F9E
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2012 12:36:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michal Hajduk <Michal.Hajduk@diasemi.com>, Adam Thomson <Adam.Thomson@diasemi.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/da732x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 04af369..01be2a3 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1543,7 +1543,7 @@ static int da732x_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-struct snd_soc_codec_driver soc_codec_dev_da732x = {
+static struct snd_soc_codec_driver soc_codec_dev_da732x = {
 	.probe			= da732x_probe,
 	.remove			= da732x_remove,
 	.set_bias_level		= da732x_set_bias_level,
-- 
1.7.10
