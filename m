From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Initialize CHIP_ANA_POWER to power-on defaults" to the asoc tree
Date: Wed, 15 Jun 2016 15:38:30 +0100
Message-ID: <E1bDBxe-0006wH-8Y@finisterre>
References: <20160606231453.19377-4-clemens.gruber@pqgruber.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606231453.19377-4-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Nelson <eric@nelint.com>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>, Fabio Estevam <fabio.estevam@nxp.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.orgClemens Gruber <clemens.gruber@pqgruber.com>Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: Initialize CHIP_ANA_POWER to power-on defaults

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3d632cc87204b51a4b32bdaa970fe6b8d879347e Mon Sep 17 00:00:00 2001
From: Eric Nelson <eric@nelint.com>
Date: Tue, 7 Jun 2016 01:14:50 +0200
Subject: [PATCH] ASoC: sgtl5000: Initialize CHIP_ANA_POWER to power-on
 defaults

Initialize CHIP_ANA_POWER to match power on defaults, which disables
ADC, DAC, and charge pumps.

In the process, remove references to the following register/bitfields
from the sgtl5000_set_power_regs routine:
	CHIP_ANA_POWER/LINREG_SIMPLE_POWERUP and
	CHIP_LINREG_CTRL/LINREG_VDD_MASK

And remove CHIP_ANA_POWER and CHIP_LINREG_CTRL from the set of default
registers so they don't get clobbered by sgtl5000_fill_defaults().

Signed-off-by: Eric Nelson <eric@nelint.com>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 56 +++++++++++++++++----------------------------
 sound/soc/codecs/sgtl5000.h |  1 +
 2 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 56d61a212083..42f2eb62664e 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -47,12 +47,10 @@ static const struct reg_default sgtl5000_reg_defaults[] = {
 	{ SGTL5000_CHIP_ANA_ADC_CTRL,		0x0000 },
 	{ SGTL5000_CHIP_ANA_HP_CTRL,		0x1818 },
 	{ SGTL5000_CHIP_ANA_CTRL,		0x0111 },
-	{ SGTL5000_CHIP_LINREG_CTRL,		0x0000 },
 	{ SGTL5000_CHIP_REF_CTRL,		0x0000 },
 	{ SGTL5000_CHIP_MIC_CTRL,		0x0000 },
 	{ SGTL5000_CHIP_LINE_OUT_CTRL,		0x0000 },
 	{ SGTL5000_CHIP_LINE_OUT_VOL,		0x0404 },
-	{ SGTL5000_CHIP_ANA_POWER,		0x7060 },
 	{ SGTL5000_CHIP_PLL_CTRL,		0x5000 },
 	{ SGTL5000_CHIP_CLK_TOP_CTRL,		0x0000 },
 	{ SGTL5000_CHIP_ANA_STATUS,		0x0000 },
@@ -93,6 +91,7 @@ static const char *supply_names[SGTL5000_SUPPLY_NUM] = {
 };
 
 #define LDO_VOLTAGE		1200000
+#define LINREG_VDDD	((1600 - LDO_VOLTAGE / 1000) / 50)
 
 enum sgtl5000_micbias_resistor {
 	SGTL5000_MICBIAS_OFF = 0,
@@ -1002,25 +1001,6 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 
 	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, ana_pwr);
 
-	/* set voltage to register */
-	snd_soc_update_bits(codec, SGTL5000_CHIP_LINREG_CTRL,
-				SGTL5000_LINREG_VDDD_MASK, 0x8);
-
-	/*
-	 * if vddd linear reg has been enabled,
-	 * simple digital supply should be clear to get
-	 * proper VDDD voltage.
-	 */
-	if (ana_pwr & SGTL5000_LINEREG_D_POWERUP)
-		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
-				SGTL5000_LINREG_SIMPLE_POWERUP,
-				0);
-	else
-		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
-				SGTL5000_LINREG_SIMPLE_POWERUP |
-				SGTL5000_STARTUP_POWERUP,
-				0);
-
 	/*
 	 * set ADC/DAC VAG to vdda / 2,
 	 * should stay in range (0.8v, 1.575v)
@@ -1242,6 +1222,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	int ret, reg, rev;
 	struct device_node *np = client->dev.of_node;
 	u32 value;
+	u16 ana_pwr;
 
 	sgtl5000 = devm_kzalloc(&client->dev, sizeof(*sgtl5000), GFP_KERNEL);
 	if (!sgtl5000)
@@ -1299,29 +1280,34 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	sgtl5000->revision = rev;
 
 	/* Follow section 2.2.1.1 of AN3663 */
+	ana_pwr = SGTL5000_ANA_POWER_DEFAULT;
 	if (sgtl5000->num_supplies <= VDDD) {
 		/* internal VDDD at 1.2V */
-		regmap_update_bits(sgtl5000->regmap,
-				   SGTL5000_CHIP_LINREG_CTRL,
-				   SGTL5000_LINREG_VDDD_MASK, 8);
-		regmap_update_bits(sgtl5000->regmap,
-				   SGTL5000_CHIP_ANA_POWER,
-				   SGTL5000_LINEREG_D_POWERUP
-				   | SGTL5000_LINREG_SIMPLE_POWERUP,
-				   SGTL5000_LINEREG_D_POWERUP);
-		dev_info(&client->dev, "Using internal LDO instead of VDDD: check ER1\n");
+		ret = regmap_update_bits(sgtl5000->regmap,
+					 SGTL5000_CHIP_LINREG_CTRL,
+					 SGTL5000_LINREG_VDDD_MASK,
+					 LINREG_VDDD);
+		if (ret)
+			dev_err(&client->dev,
+				"Error %d setting LINREG_VDDD\n", ret);
+
+		ana_pwr |= SGTL5000_LINEREG_D_POWERUP;
+		dev_info(&client->dev,
+			 "Using internal LDO instead of VDDD: check ER1\n");
 	} else {
 		/* using external LDO for VDDD
 		 * Clear startup powerup and simple powerup
 		 * bits to save power
 		 */
-		regmap_update_bits(sgtl5000->regmap,
-				   SGTL5000_CHIP_ANA_POWER,
-				   SGTL5000_STARTUP_POWERUP
-				   | SGTL5000_LINREG_SIMPLE_POWERUP,
-				   0);
+		ana_pwr &= ~(SGTL5000_STARTUP_POWERUP
+			     | SGTL5000_LINREG_SIMPLE_POWERUP);
 		dev_dbg(&client->dev, "Using external VDDD\n");
 	}
+	ret = regmap_write(sgtl5000->regmap, SGTL5000_CHIP_ANA_POWER, ana_pwr);
+	if (ret)
+		dev_err(&client->dev,
+			"Error %d setting CHIP_ANA_POWER to %04x\n",
+			ret, ana_pwr);
 
 	if (np) {
 		if (!of_property_read_u32(np,
diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
index 1c317de26176..1be82379c689 100644
--- a/sound/soc/codecs/sgtl5000.h
+++ b/sound/soc/codecs/sgtl5000.h
@@ -325,6 +325,7 @@
 /*
  * SGTL5000_CHIP_ANA_POWER
  */
+#define SGTL5000_ANA_POWER_DEFAULT		0x7060
 #define SGTL5000_DAC_STEREO			0x4000
 #define SGTL5000_LINREG_SIMPLE_POWERUP		0x2000
 #define SGTL5000_STARTUP_POWERUP		0x1000
-- 
2.8.1
