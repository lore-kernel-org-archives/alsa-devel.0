From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Move WM8962 FLL configuration to CODEC
Date: Mon, 25 Apr 2011 18:44:55 +0100
Message-ID: <1303753495-23894-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 08EAA24433
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Apr 2011 19:44:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There's only one DAI anyway.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 7d6ace3..bc84a1a 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3172,10 +3172,9 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 	return 0;
 }
 
-static int wm8962_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
+static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 			  unsigned int Fref, unsigned int Fout)
 {
-	struct snd_soc_codec *codec = dai->codec;
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	struct _fll_div fll_div;
 	unsigned long timeout;
@@ -3280,7 +3279,6 @@ static struct snd_soc_dai_ops wm8962_dai_ops = {
 	.hw_params = wm8962_hw_params,
 	.set_sysclk = wm8962_set_dai_sysclk,
 	.set_fmt = wm8962_set_dai_fmt,
-	.set_pll = wm8962_set_fll,
 	.digital_mute = wm8962_mute,
 };
 
@@ -3931,6 +3929,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8962 = {
 	.reg_cache_default = wm8962_reg,
 	.volatile_register = wm8962_volatile_register,
 	.readable_register = wm8962_readable_register,
+	.set_pll = wm8962_set_fll,
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-- 
1.7.4.1
