From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Reset registers during
	power up" to the asoc tree
Date: Thu, 07 Dec 2017 17:48:14 +0000
Message-ID: <E1eN0HO-000409-7W@debutante>
References: <20171207153900.9831-7-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0529B266B67
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 18:48:17 +0100 (CET)
In-Reply-To: <20171207153900.9831-7-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "Andrew F ., Davis" <afd@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: Reset registers during power up

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0ce918c9e070bf4fd17af0d76096ad184815bd79 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Thu, 7 Dec 2017 09:38:56 -0600
Subject: [PATCH] ASoC: tlv320aic31xx: Reset registers during power up

Add a reset function that toggles the reset line if available or uses
the software reset command otherwise. Use this in power up to ensure the
registers are in a sane state. This is useful when the driver module
is reloaded, or after Kexec, warm-reboots, etc..

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 655c99db2426..858cb8be445f 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1055,6 +1055,22 @@ static int aic31xx_regulator_event(struct notifier_block *nb,
 	return 0;
 }
 
+static int aic31xx_reset(struct aic31xx_priv *aic31xx)
+{
+	int ret = 0;
+
+	if (aic31xx->gpio_reset) {
+		gpiod_set_value(aic31xx->gpio_reset, 1);
+		ndelay(10); /* At least 10ns */
+		gpiod_set_value(aic31xx->gpio_reset, 0);
+	} else {
+		ret = regmap_write(aic31xx->regmap, AIC31XX_RESET, 1);
+	}
+	mdelay(1); /* At least 1ms */
+
+	return ret;
+}
+
 static void aic31xx_clk_on(struct snd_soc_codec *codec)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
@@ -1098,11 +1114,13 @@ static int aic31xx_power_on(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;
 
-	if (aic31xx->gpio_reset) {
-		gpiod_set_value(aic31xx->gpio_reset, 0);
-		udelay(100);
-	}
 	regcache_cache_only(aic31xx->regmap, false);
+
+	/* Reset device registers for a consistent power-on like state */
+	ret = aic31xx_reset(aic31xx);
+	if (ret < 0)
+		dev_err(aic31xx->dev, "Could not reset device: %d\n", ret);
+
 	ret = regcache_sync(aic31xx->regmap);
 	if (ret) {
 		dev_err(codec->dev,
-- 
2.15.1
