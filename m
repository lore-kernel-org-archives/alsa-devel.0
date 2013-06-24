From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/5] ASoC: codecs: tas5086: open-code I2C
	transfer routines
Date: Mon, 24 Jun 2013 16:25:29 +0200
Message-ID: <1372083932-4318-2-git-send-email-zonque@gmail.com>
References: <1372083932-4318-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D9CA26501A
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:25:31 +0200 (CEST)
In-Reply-To: <1372083932-4318-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

In order to support registers of unequal sizes, the I2C I/O has to be
open-coded.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/tas5086.c | 85 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 6c5470c..833bccd 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -119,6 +119,17 @@ static const struct reg_default tas5086_reg_defaults[] = {
 	{ 0x1c,	0x05 },
 };
 
+static int tas5086_register_size(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TAS5086_DEV_ID ... TAS5086_BKNDERR:
+		return 1;
+	}
+
+	dev_err(dev, "Unsupported register address: %d\n", reg);
+	return 0;
+}
+
 static bool tas5086_accessible_reg(struct device *dev, unsigned int reg)
 {
 	return !((reg == 0x0f) || (reg >= 0x11 && reg <= 0x17));
@@ -140,6 +151,76 @@ static bool tas5086_writeable_reg(struct device *dev, unsigned int reg)
 	return tas5086_accessible_reg(dev, reg) && (reg != TAS5086_DEV_ID);
 }
 
+static int tas5086_reg_write(void *context, unsigned int reg,
+			      unsigned int value)
+{
+	struct i2c_client *client = context;
+	unsigned int i, size;
+	uint8_t buf[5];
+	int ret;
+
+	size = tas5086_register_size(&client->dev, reg);
+	if (size == 0)
+		return -EINVAL;
+
+	buf[0] = reg;
+
+	for (i = size; i >= 1; --i) {
+		buf[i] = value;
+		value >>= 8;
+	}
+
+	ret = i2c_master_send(client, buf, size + 1);
+	if (ret == size + 1)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static int tas5086_reg_read(void *context, unsigned int reg,
+			     unsigned int *value)
+{
+	struct i2c_client *client = context;
+	uint8_t send_buf, recv_buf[4];
+	struct i2c_msg msgs[2];
+	unsigned int size;
+	unsigned int i;
+	int ret;
+
+	size = tas5086_register_size(&client->dev, reg);
+	if (size == 0)
+		return -EINVAL;
+
+	send_buf = reg;
+
+	msgs[0].addr = client->addr;
+	msgs[0].len = sizeof(send_buf);
+	msgs[0].buf = &send_buf;
+	msgs[0].flags = 0;
+
+	msgs[1].addr = client->addr;
+	msgs[1].len = size;
+	msgs[1].buf = recv_buf;
+	msgs[1].flags = I2C_M_RD;
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret < 0)
+		return ret;
+	else if (ret != ARRAY_SIZE(msgs))
+		return -EIO;
+
+	*value = 0;
+
+	for (i = 0; i < size; i++) {
+		*value <<= 8;
+		*value |= recv_buf[i];
+	}
+
+	return 0;
+}
+
 struct tas5086_private {
 	struct regmap	*regmap;
 	unsigned int	mclk, sclk;
@@ -508,6 +589,8 @@ static const struct regmap_config tas5086_regmap = {
 	.volatile_reg		= tas5086_volatile_reg,
 	.writeable_reg		= tas5086_writeable_reg,
 	.readable_reg		= tas5086_accessible_reg,
+	.reg_read		= tas5086_reg_read,
+	.reg_write		= tas5086_reg_write,
 };
 
 static int tas5086_i2c_probe(struct i2c_client *i2c,
@@ -522,7 +605,7 @@ static int tas5086_i2c_probe(struct i2c_client *i2c,
 	if (!priv)
 		return -ENOMEM;
 
-	priv->regmap = devm_regmap_init_i2c(i2c, &tas5086_regmap);
+	priv->regmap = devm_regmap_init(dev, NULL, i2c, &tas5086_regmap);
 	if (IS_ERR(priv->regmap)) {
 		ret = PTR_ERR(priv->regmap);
 		dev_err(&i2c->dev, "Failed to create regmap: %d\n", ret);
-- 
1.8.1.4
