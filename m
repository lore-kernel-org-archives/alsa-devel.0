From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 2/6] ASoC: sgtl5000: Write all default registers
Date: Tue,  7 Jun 2016 01:14:49 +0200
Message-ID: <20160606231453.19377-3-clemens.gruber@pqgruber.com>
References: <20160606231453.19377-1-clemens.gruber@pqgruber.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606231453.19377-1-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Eric Nelson <eric@nelint.com>, linux-kernel@vger.kernel.org, Clemens Gruber <clemens.gruber@pqgruber.com>
List-Id: alsa-devel@alsa-project.org

From: Eric Nelson <eric@nelint.com>

If an error occurs writing defaults, produce an error message but
continue writing other registers. The failure of a single write should
not cause catastrophic device failure.

In at least one occurrence, I2C writes of CHIP_ANA_POWER were nacked,
though continuing allowed the device to operate properly.

Signed-off-by: Eric Nelson <eric@nelint.com>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 sound/soc/codecs/sgtl5000.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 9fdce9e..fd8cfec 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1220,8 +1220,9 @@ static const struct regmap_config sgtl5000_regmap = {
  * and avoid problems like, not being able to probe after an audio playback
  * followed by a system reset or a 'reboot' command in Linux
  */
-static int sgtl5000_fill_defaults(struct sgtl5000_priv *sgtl5000)
+static void sgtl5000_fill_defaults(struct i2c_client *client)
 {
+	struct sgtl5000_priv *sgtl5000 = i2c_get_clientdata(client);
 	int i, ret, val, index;
 
 	for (i = 0; i < ARRAY_SIZE(sgtl5000_reg_defaults); i++) {
@@ -1229,10 +1230,10 @@ static int sgtl5000_fill_defaults(struct sgtl5000_priv *sgtl5000)
 		index = sgtl5000_reg_defaults[i].reg;
 		ret = regmap_write(sgtl5000->regmap, index, val);
 		if (ret)
-			return ret;
+			dev_err(&client->dev,
+				"%s: error %d setting reg 0x%02x to 0x%04x\n",
+				__func__, ret, index, val);
 	}
-
-	return 0;
 }
 
 static int sgtl5000_i2c_probe(struct i2c_client *client,
@@ -1365,9 +1366,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	}
 
 	/* Ensure sgtl5000 will start with sane register values */
-	ret = sgtl5000_fill_defaults(sgtl5000);
-	if (ret)
-		goto disable_clk;
+	sgtl5000_fill_defaults(client);
 
 	ret = snd_soc_register_codec(&client->dev,
 			&sgtl5000_driver, &sgtl5000_dai, 1);
-- 
2.8.3
