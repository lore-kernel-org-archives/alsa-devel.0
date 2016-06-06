From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 3/6] ASoC: sgtl5000: Initialize CHIP_ANA_POWER to power-on defaults
Date: Tue,  7 Jun 2016 01:14:50 +0200
Message-ID: <20160606231453.19377-4-clemens.gruber@pqgruber.com>
References: <20160606231453.19377-1-clemens.gruber@pqgruber.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606231453.19377-1-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Eric Nelson <eric@nelint.com>, linux-kernel@vger.kernel.org, Clemens Gruber <clemens.gruber@pqgruber.com>
List-Id: alsa-devel@alsa-project.org

From: Eric Nelson <eric@nelint.com>

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
---
 sound/soc/codecs/sgtl5000.c | 56 +++++++++++++++++----------------------------
 sound/soc/codecs/sgtl5000.h |  1 +
 2 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index fd8cfec..59eee45 100644
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
@@ -1003,25 +1002,6 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 
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
@@ -1243,6 +1223,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	int ret, reg, rev;
 	struct device_node *np = client->dev.of_node;
 	u32 value;
+	u16 ana_pwr;
 
 	sgtl5000 = devm_kzalloc(&client->dev, sizeof(*sgtl5000), GFP_KERNEL);
 	if (!sgtl5000)
@@ -1300,29 +1281,34 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
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
index 1c317de..1be8237 100644
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
2.8.3
