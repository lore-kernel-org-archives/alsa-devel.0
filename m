From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: da732x: Remove leftover cache size
	setting
Date: Mon, 24 Feb 2014 11:38:50 +0900
Message-ID: <1393209530-15950-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E64C2265266
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 06:34:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The da732x driver no longer uses the ASoC level register cache but the
cache size setting had been left in the driver by mistake. Remove it.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/da732x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index f295b65..8e2c74d 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1554,7 +1554,6 @@ static struct snd_soc_codec_driver soc_codec_dev_da732x = {
 	.dapm_routes		= da732x_dapm_routes,
 	.num_dapm_routes	= ARRAY_SIZE(da732x_dapm_routes),
 	.set_pll		= da732x_set_dai_pll,
-	.reg_cache_size		= ARRAY_SIZE(da732x_reg_cache),
 };
 
 static int da732x_i2c_probe(struct i2c_client *i2c,
-- 
1.9.0.rc3
