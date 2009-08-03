From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/8] ASoC: Remove use of hw_read from
	TLV320AIC3x driver
Date: Mon,  3 Aug 2009 17:09:45 +0100
Message-ID: <1249315790-22814-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1249315790-22814-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7DA2C24793
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 18:09:54 +0200 (CEST)
In-Reply-To: <1249315790-22814-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The TLV320AIC3x driver is currently the only user of the CODEC hw_read
operation and is jumping through some hoops in order to do so.  In order
to support future refactoring to make the hw_read operation more usable
unwrap the usage in this driver to avoid its use.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic3x.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index ab099f4..0cf401f 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -145,8 +145,8 @@ static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
 		      u8 *value)
 {
 	*value = reg & 0xff;
-	if (codec->hw_read(codec->control_data, value, 1) != 1)
-		return -EIO;
+
+	value[0] = i2c_smbus_read_byte_data(codec->control_data, value[0]);
 
 	aic3x_write_reg_cache(codec, reg, *value);
 	return 0;
@@ -1316,12 +1316,6 @@ static struct i2c_driver aic3x_i2c_driver = {
 	.id_table = aic3x_i2c_id,
 };
 
-static int aic3x_i2c_read(struct i2c_client *client, u8 *value, int len)
-{
-	value[0] = i2c_smbus_read_byte_data(client, value[0]);
-	return (len == 1);
-}
-
 static int aic3x_add_i2c_device(struct platform_device *pdev,
 				 const struct aic3x_setup_data *setup)
 {
@@ -1394,7 +1388,6 @@ static int aic3x_probe(struct platform_device *pdev)
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
 		codec->hw_write = (hw_write_t) i2c_master_send;
-		codec->hw_read = (hw_read_t) aic3x_i2c_read;
 		ret = aic3x_add_i2c_device(pdev, setup);
 	}
 #else
-- 
1.6.3.3
