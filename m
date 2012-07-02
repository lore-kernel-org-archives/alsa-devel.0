From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8962: Log AIF configuration requested
	by hw_params()
Date: Mon,  2 Jul 2012 18:20:29 +0100
Message-ID: <1341249629-7987-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D1AB724702
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2012 19:20:31 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index aa5839c..5781581 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2582,6 +2582,9 @@ static int wm8962_hw_params(struct snd_pcm_substream *substream,
 			    WM8962_SAMPLE_RATE_INT_MODE |
 			    WM8962_SAMPLE_RATE_MASK, adctl3);
 
+	dev_dbg(codec->dev, "hw_params set BCLK %dHz LRCLK %dHz\n",
+		wm8962->bclk, wm8962->lrclk);
+
 	if (codec->dapm.bias_level == SND_SOC_BIAS_ON)
 		wm8962_configure_bclk(codec);
 
-- 
1.7.10
