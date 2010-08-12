From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Remove unneeded control_data
	management from Wolfson drivers
Date: Thu, 12 Aug 2010 11:04:14 +0100
Message-ID: <1281607454-13248-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1281607156-12991-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C7F71038C8
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 12:04:19 +0200 (CEST)
In-Reply-To: <1281607156-12991-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Now soc-cache.c can figure out the I2C and SPI control data from the
device for the CODEC we don't need to manually assign it in drivers.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8510.c |    4 ----
 sound/soc/codecs/wm8523.c |    3 ---
 sound/soc/codecs/wm8580.c |    3 ---
 sound/soc/codecs/wm8711.c |    4 ----
 sound/soc/codecs/wm8728.c |    4 ----
 sound/soc/codecs/wm8731.c |    4 ----
 sound/soc/codecs/wm8741.c |    3 ---
 sound/soc/codecs/wm8750.c |    4 ----
 sound/soc/codecs/wm8753.c |    6 +-----
 sound/soc/codecs/wm8776.c |    4 ----
 sound/soc/codecs/wm8900.c |    4 ----
 sound/soc/codecs/wm8903.c |    3 ---
 sound/soc/codecs/wm8955.c |    3 ---
 sound/soc/codecs/wm8961.c |    3 ---
 sound/soc/codecs/wm8971.c |    3 ---
 sound/soc/codecs/wm8974.c |    3 ---
 sound/soc/codecs/wm8988.c |    4 ----
 sound/soc/codecs/wm8990.c |    4 ----
 sound/soc/codecs/wm8993.c |    3 ---
 19 files changed, 1 insertions(+), 68 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 1c623de..d00da20 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -60,7 +60,6 @@ static const u16 wm8510_reg[WM8510_CACHEREGNUM] = {
 /* codec private data */
 struct wm8510_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 };
 
 static const char *wm8510_companding[] = { "Off", "NC", "u-law", "A-law" };
@@ -561,7 +560,6 @@ static int wm8510_probe(struct snd_soc_codec *codec)
 	struct wm8510_priv *wm8510 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	codec->control_data = wm8510->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9,  wm8510->control_type);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8510: failed to set cache I/O: %d\n", ret);
@@ -611,7 +609,6 @@ static int __devinit wm8510_spi_probe(struct spi_device *spi)
 	if (wm8510 == NULL)
 		return -ENOMEM;
 
-	wm8510->control_data = spi;
 	wm8510->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8510);
 
@@ -651,7 +648,6 @@ static __devinit int wm8510_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8510);
-	wm8510->control_data = i2c;
 	wm8510->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 58d411b..712ef7c 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -41,7 +41,6 @@ static const char *wm8523_supply_names[WM8523_NUM_SUPPLIES] = {
 /* codec private data */
 struct wm8523_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	u16 reg_cache[WM8523_REGISTER_COUNT];
 	struct regulator_bulk_data supplies[WM8523_NUM_SUPPLIES];
 	unsigned int sysclk;
@@ -419,7 +418,6 @@ static int wm8523_probe(struct snd_soc_codec *codec)
 	int ret, i;
 
 	codec->hw_write = (hw_write_t)i2c_master_send;
-	codec->control_data = wm8523->control_data;
 	wm8523->rate_constraint.list = &wm8523->rate_constraint_list[0];
 	wm8523->rate_constraint.count =
 		ARRAY_SIZE(wm8523->rate_constraint_list);
@@ -528,7 +526,6 @@ static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8523);
-	wm8523->control_data = i2c;
 	wm8523->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 6dbfa13..b1a80e5 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -200,7 +200,6 @@ static const char *wm8580_supply_names[WM8580_NUM_SUPPLIES] = {
 /* codec private data */
 struct wm8580_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	struct regulator_bulk_data supplies[WM8580_NUM_SUPPLIES];
 	u16 reg_cache[WM8580_MAX_REGISTER + 1];
 	struct pll_state a;
@@ -778,7 +777,6 @@ static int wm8580_probe(struct snd_soc_codec *codec)
 	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0,i;
 
-	codec->control_data = wm8580->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8580->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
@@ -858,7 +856,6 @@ static int wm8580_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8580);
-	wm8580->control_data = i2c;
 	wm8580->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 8d942b3..f8d9c60 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -34,7 +34,6 @@
 /* codec private data */
 struct wm8711_priv {
 	enum snd_soc_control_type bus_type;
-	void *control_data;
 	u16 reg_cache[WM8711_CACHEREGNUM];
 	unsigned int sysclk;
 };
@@ -378,7 +377,6 @@ static int wm8711_probe(struct snd_soc_codec *codec)
 	struct wm8711_priv *wm8711 = snd_soc_codec_get_drvdata(codec);
 	int ret, reg;
 
-	codec->control_data = wm8711->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8711->bus_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
@@ -436,7 +434,6 @@ static int __devinit wm8711_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, wm8711);
-	wm8711->control_data = spi;
 	wm8711->bus_type = SND_SOC_SPI;
 
 	ret = snd_soc_register_codec(&spi->dev,
@@ -476,7 +473,6 @@ static __devinit int wm8711_i2c_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, wm8711);
-	wm8711->control_data = client;
 	wm8711->bus_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&client->dev,
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index ae22924..5e5a162 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -45,7 +45,6 @@ static const u16 wm8728_reg_defaults[] = {
 /* codec private data */
 struct wm8728_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 };
 
 static const DECLARE_TLV_DB_SCALE(wm8728_tlv, -12750, 50, 1);
@@ -244,7 +243,6 @@ static int wm8728_probe(struct snd_soc_codec *codec)
 	struct wm8728_priv *wm8728 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	codec->control_data = wm8728->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8728->control_type);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8728: failed to configure cache I/O: %d\n",
@@ -289,7 +287,6 @@ static int __devinit wm8728_spi_probe(struct spi_device *spi)
 	if (wm8728 == NULL)
 		return -ENOMEM;
 
-	wm8728->control_data = spi;
 	wm8728->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8728);
 
@@ -330,7 +327,6 @@ static __devinit int wm8728_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8728);
-	wm8728->control_data = i2c;
 	wm8728->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 7da360e..19844fc 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -43,7 +43,6 @@ static const char *wm8731_supply_names[WM8731_NUM_SUPPLIES] = {
 /* codec private data */
 struct wm8731_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	struct regulator_bulk_data supplies[WM8731_NUM_SUPPLIES];
 	u16 reg_cache[WM8731_CACHEREGNUM];
 	unsigned int sysclk;
@@ -463,7 +462,6 @@ static int wm8731_probe(struct snd_soc_codec *codec)
 	int ret = 0, i;
 
 	codec->bias_level = SND_SOC_BIAS_OFF,
-	codec->control_data = wm8731->control_data;
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8731->control_type);
 	if (ret < 0) {
@@ -557,7 +555,6 @@ static int __devinit wm8731_spi_probe(struct spi_device *spi)
 	if (wm8731 == NULL)
 		return -ENOMEM;
 
-	wm8731->control_data = spi;
 	wm8731->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8731);
 
@@ -598,7 +595,6 @@ static __devinit int wm8731_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8731);
-	wm8731->control_data = i2c;
 	wm8731->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 0c6d59e..782fe53 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -41,7 +41,6 @@ static const char *wm8741_supply_names[WM8741_NUM_SUPPLIES] = {
 /* codec private data */
 struct wm8741_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	u16 reg_cache[WM8741_REGISTER_COUNT];
 	struct regulator_bulk_data supplies[WM8741_NUM_SUPPLIES];
 	unsigned int sysclk;
@@ -347,7 +346,6 @@ static int wm8741_probe(struct snd_soc_codec *codec)
 	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	codec->control_data = wm8741->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8741->control_type);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
@@ -415,7 +413,6 @@ static int wm8741_i2c_probe(struct i2c_client *i2c,
 	}
 
 	i2c_set_clientdata(i2c, wm8741);
-	wm8741->control_data = i2c;
 	wm8741->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 89863a5..92d4b2a 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -53,7 +53,6 @@ static const u16 wm8750_reg[] = {
 struct wm8750_priv {
 	unsigned int sysclk;
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	u16 reg_cache[ARRAY_SIZE(wm8750_reg)];
 };
 
@@ -697,7 +696,6 @@ static int wm8750_probe(struct snd_soc_codec *codec)
 	struct wm8750_priv *wm8750 = snd_soc_codec_get_drvdata(codec);
 	int reg, ret;
 
-	codec->control_data = wm8750->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8750->control_type);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8750: failed to set cache I/O: %d\n", ret);
@@ -764,7 +762,6 @@ static int __devinit wm8750_spi_probe(struct spi_device *spi)
 	if (wm8750 == NULL)
 		return -ENOMEM;
 
-	wm8750->control_data = spi;
 	wm8750->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8750);
 
@@ -805,7 +802,6 @@ static __devinit int wm8750_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8750);
-	wm8750->control_data = i2c;
 	wm8750->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 976e408..4844232 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -86,7 +86,6 @@ static const u16 wm8753_reg[] = {
 /* codec private data */
 struct wm8753_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	unsigned int sysclk;
 	unsigned int pcmclk;
 	u16 reg_cache[ARRAY_SIZE(wm8753_reg)];
@@ -1551,8 +1550,7 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0, reg;
 
-	codec->bias_level = SND_SOC_BIAS_OFF,
-	codec->control_data = wm8753->control_data;
+	codec->bias_level = SND_SOC_BIAS_OFF;
 	INIT_DELAYED_WORK(&codec->delayed_work, wm8753_work);
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8753->control_type);
@@ -1637,7 +1635,6 @@ static int __devinit wm8753_spi_probe(struct spi_device *spi)
 	if (wm8753 == NULL)
 		return -ENOMEM;
 
-	wm8753->control_data = spi;
 	wm8753->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8753);
 
@@ -1678,7 +1675,6 @@ static __devinit int wm8753_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8753);
-	wm8753->control_data = i2c;
 	wm8753->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 51a2d26..0530306 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -34,7 +34,6 @@
 /* codec private data */
 struct wm8776_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	u16 reg_cache[WM8776_CACHEREGNUM];
 	int sysclk[2];
 };
@@ -415,7 +414,6 @@ static int wm8776_probe(struct snd_soc_codec *codec)
 	struct wm8776_priv *wm8776 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	codec->control_data = wm8776->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8776->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
@@ -472,7 +470,6 @@ static int __devinit wm8776_spi_probe(struct spi_device *spi)
 	if (wm8776 == NULL)
 		return -ENOMEM;
 
-	wm8776->control_data = spi;
 	wm8776->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8776);
 
@@ -513,7 +510,6 @@ static __devinit int wm8776_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8776);
-	wm8776->control_data = i2c;
 	wm8776->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 33c3b57..1378aab 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -140,7 +140,6 @@
 
 struct wm8900_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	u16 reg_cache[WM8900_MAXREG];
 
 	u32 fll_in; /* FLL input frequency */
@@ -1189,7 +1188,6 @@ static int wm8900_probe(struct snd_soc_codec *codec)
 	struct wm8900_priv *wm8900 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0, reg;
 
-	codec->control_data = wm8900->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, wm8900->control_type);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
@@ -1273,7 +1271,6 @@ static int __devinit wm8900_spi_probe(struct spi_device *spi)
 	if (wm8900 == NULL)
 		return -ENOMEM;
 
-	wm8900->control_data = spi;
 	wm8900->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8900);
 
@@ -1314,7 +1311,6 @@ static __devinit int wm8900_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8900);
-	wm8900->control_data = i2c;
 	wm8900->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index f5d73ed..622b602 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -217,7 +217,6 @@ struct wm8903_priv {
 	u16 reg_cache[ARRAY_SIZE(wm8903_reg_defaults)];
 
 	int sysclk;
-	struct i2c_client *control_data;
 	int irq;
 
 	/* Reference counts */
@@ -1639,7 +1638,6 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 	u16 val;
 
 	init_completion(&wm8903->wseq);
-	codec->control_data = wm8903->control_data;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
 	if (ret != 0) {
@@ -1779,7 +1777,6 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8903);
-	wm8903->control_data = i2c;
 	wm8903->irq = i2c->irq;
 
 	ret = snd_soc_register_codec(&i2c->dev,
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index a5a9f8e..f89ad6c 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -41,7 +41,6 @@ static const char *wm8955_supply_names[WM8955_NUM_SUPPLIES] = {
 /* codec private data */
 struct wm8955_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 
 	u16 reg_cache[WM8955_MAX_REGISTER + 1];
 
@@ -904,7 +903,6 @@ static int wm8955_probe(struct snd_soc_codec *codec)
 	struct wm8955_pdata *pdata = dev_get_platdata(codec->dev);
 	int ret, i;
 
-	codec->control_data = wm8955->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8955->control_type);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
@@ -1004,7 +1002,6 @@ static __devinit int wm8955_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8955);
-	wm8955->control_data = i2c;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8955, &wm8955_dai, 1);
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 5ebe2c0..fa36a62 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -289,7 +289,6 @@ static u16 wm8961_reg_defaults[] = {
 
 struct wm8961_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	int sysclk;
 	u16 reg_cache[WM8961_MAX_REGISTER];
 };
@@ -964,7 +963,6 @@ static int wm8961_probe(struct snd_soc_codec *codec)
 	int ret = 0;
 	u16 reg;
 
-	codec->control_data = wm8961->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
@@ -1096,7 +1094,6 @@ static __devinit int wm8961_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8961);
-	wm8961->control_data = i2c;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8961, &wm8961_dai, 1);
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 9ec9a2e..63f6dbf 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -37,7 +37,6 @@ static struct workqueue_struct *wm8971_workq = NULL;
 /* codec private data */
 struct wm8971_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	unsigned int sysclk;
 };
 
@@ -638,7 +637,6 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 	int ret = 0;
 	u16 reg;
 
-	codec->control_data = wm8971->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8971->control_type);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8971: failed to set cache I/O: %d\n", ret);
@@ -721,7 +719,6 @@ static __devinit int wm8971_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8971);
-	wm8971->control_data = i2c;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8971, &wm8971_dai, 1);
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 52f631c..e61728b 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -52,7 +52,6 @@ static const u16 wm8974_reg[WM8974_CACHEREGNUM] = {
 
 struct wm8974_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	u16 reg_cache[WM8974_CACHEREGNUM];
 };
 
@@ -611,7 +610,6 @@ static int wm8974_probe(struct snd_soc_codec *codec)
 	struct wm8974_priv *wm8974 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	codec->control_data = wm8974->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_I2C);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
@@ -662,7 +660,6 @@ static __devinit int wm8974_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8974);
-	wm8974->control_data = i2c;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8974, &wm8974_dai, 1);
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index ecbffce..d070a58 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -53,7 +53,6 @@ static const u16 wm8988_reg[] = {
 struct wm8988_priv {
 	unsigned int sysclk;
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
 	u16 reg_cache[WM8988_NUM_REG];
 };
@@ -763,7 +762,6 @@ static int wm8988_probe(struct snd_soc_codec *codec)
 	int ret = 0;
 	u16 reg;
 
-	codec->control_data = wm8988->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8988->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
@@ -826,7 +824,6 @@ static int __devinit wm8988_spi_probe(struct spi_device *spi)
 	if (wm8988 == NULL)
 		return -ENOMEM;
 
-	wm8988->control_data = spi;
 	wm8988->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8988);
 
@@ -867,7 +864,6 @@ static __devinit int wm8988_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8988);
-	wm8988->control_data = i2c;
 	wm8988->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index b252433..0ffecbd 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -33,7 +33,6 @@
 /* codec private data */
 struct wm8990_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	unsigned int sysclk;
 	unsigned int pcmclk;
 };
@@ -1343,11 +1342,9 @@ static int wm8990_resume(struct snd_soc_codec *codec)
  */
 static int wm8990_probe(struct snd_soc_codec *codec)
 {
-	struct wm8990_priv *wm8990 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 	u16 reg;
 
-	codec->control_data = wm8990->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8990: failed to set cache I/O: %d\n", ret);
@@ -1410,7 +1407,6 @@ static __devinit int wm8990_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8990);
-	wm8990->control_data = i2c;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8990, &wm8990_dai, 1);
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 1d9e183..a3fd6b9 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -230,7 +230,6 @@ struct wm8993_priv {
 	struct regulator_bulk_data supplies[WM8993_NUM_SUPPLIES];
 	struct wm8993_platform_data pdata;
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	int master;
 	int sysclk_source;
 	int tdm_slots;
@@ -1425,7 +1424,6 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
 	int ret, i, val;
 
-	codec->control_data = wm8993->control_data;
 	wm8993->hubs_data.hp_startup_mode = 1;
 	wm8993->hubs_data.dcs_codes = -2;
 
@@ -1606,7 +1604,6 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8993);
-	wm8993->control_data = i2c;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8993, &wm8993_dai, 1);
-- 
1.7.1
