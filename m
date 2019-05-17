From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42xx8: Add reset gpio handling" to
	the asoc tree
Date: Fri, 17 May 2019 11:34:39 +0100 (BST)
Message-ID: <20190517103439.130F41126D71@debutante.sirena.org.uk>
References: <95eb314ef6d47ee6581094a406516a6069278d56.1557986457.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B48D8F80C18
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2019 12:34:44 +0200 (CEST)
In-Reply-To: <95eb314ef6d47ee6581094a406516a6069278d56.1557986457.git.shengjiu.wang@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>, tiwai@suse.com, linux-kernel@vger.kernel.org, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42xx8: Add reset gpio handling

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From bfe95dfa4dacefbe20a8532bdac0a19da0708be4 Mon Sep 17 00:00:00 2001
From: "S.j. Wang" <shengjiu.wang@nxp.com>
Date: Thu, 16 May 2019 06:04:58 +0000
Subject: [PATCH] ASoC: cs42xx8: Add reset gpio handling

Handle the reset GPIO and reset the device every time we
start it.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42xx8.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index ebb9e0cf8364..3e8dbf63adbe 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <sound/pcm_params.h>
@@ -45,6 +46,7 @@ struct cs42xx8_priv {
 	bool slave_mode;
 	unsigned long sysclk;
 	u32 tx_channels;
+	struct gpio_desc *gpiod_reset;
 };
 
 /* -127.5dB to 0dB with step of 0.5dB */
@@ -467,6 +469,13 @@ int cs42xx8_probe(struct device *dev, struct regmap *regmap)
 		return -EINVAL;
 	}
 
+	cs42xx8->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
+							GPIOD_OUT_HIGH);
+	if (IS_ERR(cs42xx8->gpiod_reset))
+		return PTR_ERR(cs42xx8->gpiod_reset);
+
+	gpiod_set_value_cansleep(cs42xx8->gpiod_reset, 0);
+
 	cs42xx8->clk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(cs42xx8->clk)) {
 		dev_err(dev, "failed to get the clock: %ld\n",
@@ -547,6 +556,8 @@ static int cs42xx8_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	gpiod_set_value_cansleep(cs42xx8->gpiod_reset, 0);
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(cs42xx8->supplies),
 				    cs42xx8->supplies);
 	if (ret) {
@@ -585,6 +596,8 @@ static int cs42xx8_runtime_suspend(struct device *dev)
 	regulator_bulk_disable(ARRAY_SIZE(cs42xx8->supplies),
 			       cs42xx8->supplies);
 
+	gpiod_set_value_cansleep(cs42xx8->gpiod_reset, 1);
+
 	clk_disable_unprepare(cs42xx8->clk);
 
 	return 0;
-- 
2.20.1
