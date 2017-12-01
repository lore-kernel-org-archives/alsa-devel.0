From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Merge init function into
	probe" to the asoc tree
Date: Fri, 01 Dec 2017 13:43:47 +0000
Message-ID: <E1eKlbX-0001DP-89@debutante>
References: <20171109002741.10897-5-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 43225267C81
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 14:43:52 +0100 (CET)
In-Reply-To: <20171109002741.10897-5-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: Merge init function into probe

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

>From e88c3881361cee9b778bf4e4ded43da7a0917ce1 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 29 Nov 2017 15:32:48 -0600
Subject: [PATCH] ASoC: tlv320aic31xx: Merge init function into probe

The function aic31xx_device_init() is only called from probe and
does nothing that logically shouldn't be in probe, remove this
unneeded function call and move its code into probe where it was called.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 55 ++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 07c014501e5e..c84febd991a0 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1302,9 +1302,29 @@ static const struct acpi_device_id aic31xx_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, aic31xx_acpi_match);
 #endif
 
-static int aic31xx_device_init(struct aic31xx_priv *aic31xx)
+static int aic31xx_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
 {
-	int ret, i;
+	struct aic31xx_priv *aic31xx;
+	int i, ret;
+
+	dev_dbg(&i2c->dev, "## %s: %s codec_type = %d\n", __func__,
+		id->name, (int)id->driver_data);
+
+	aic31xx = devm_kzalloc(&i2c->dev, sizeof(*aic31xx), GFP_KERNEL);
+	if (!aic31xx)
+		return -ENOMEM;
+
+	aic31xx->regmap = devm_regmap_init_i2c(i2c, &aic31xx_i2c_regmap);
+	if (IS_ERR(aic31xx->regmap)) {
+		ret = PTR_ERR(aic31xx->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+	aic31xx->dev = &i2c->dev;
+
+	aic31xx->pdata.codec_type = id->driver_data;
 
 	dev_set_drvdata(aic31xx->dev, aic31xx);
 
@@ -1336,37 +1356,6 @@ static int aic31xx_device_init(struct aic31xx_priv *aic31xx)
 		return ret;
 	}
 
-	return 0;
-}
-
-static int aic31xx_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
-{
-	struct aic31xx_priv *aic31xx;
-	int ret;
-
-	dev_dbg(&i2c->dev, "## %s: %s codec_type = %d\n", __func__,
-		id->name, (int) id->driver_data);
-
-	aic31xx = devm_kzalloc(&i2c->dev, sizeof(*aic31xx), GFP_KERNEL);
-	if (!aic31xx)
-		return -ENOMEM;
-
-	aic31xx->regmap = devm_regmap_init_i2c(i2c, &aic31xx_i2c_regmap);
-	if (IS_ERR(aic31xx->regmap)) {
-		ret = PTR_ERR(aic31xx->regmap);
-		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
-			ret);
-		return ret;
-	}
-	aic31xx->dev = &i2c->dev;
-
-	aic31xx->pdata.codec_type = id->driver_data;
-
-	ret = aic31xx_device_init(aic31xx);
-	if (ret)
-		return ret;
-
 	if (aic31xx->pdata.codec_type & DAC31XX_BIT)
 		return snd_soc_register_codec(&i2c->dev,
 				&soc_codec_driver_aic31xx,
-- 
2.15.0
