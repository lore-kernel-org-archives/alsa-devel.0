From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH] ASoC: pcm512x: Trigger auto-increment of register addresses on i2c
Date: Mon,  8 Dec 2014 16:33:11 +0100
Message-ID: <1418052791-4257-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

When the codec is connected using i2c, it will only auto-increment
register addresses if msb (0x80) of the register address byte is set.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/pcm512x-i2c.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm512x-i2c.c b/sound/soc/codecs/pcm512x-i2c.c
index 4d62230bd378..d0547fa275fc 100644
--- a/sound/soc/codecs/pcm512x-i2c.c
+++ b/sound/soc/codecs/pcm512x-i2c.c
@@ -24,8 +24,13 @@ static int pcm512x_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
 	struct regmap *regmap;
+	struct regmap_config config = pcm512x_regmap;
 
-	regmap = devm_regmap_init_i2c(i2c, &pcm512x_regmap);
+	/* msb needs to be set to enable auto-increment of addresses */
+	config.read_flag_mask = 0x80;
+	config.write_flag_mask = 0x80;
+
+	regmap = devm_regmap_init_i2c(i2c, &config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
1.7.10.4
