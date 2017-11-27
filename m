From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use codec hw_write on uda1380" to
	the asoc tree
Date: Mon, 27 Nov 2017 18:52:17 +0000
Message-ID: <E1eJOVt-0006v5-Rz@debutante>
References: <87fuc7m11v.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AB84B267588
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:52:21 +0100 (CET)
In-Reply-To: <87fuc7m11v.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: don't use codec hw_write on uda1380

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

>From eaa53216c5909ae1567d15888e55d9b1d7269ca7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 9 Nov 2017 00:19:33 +0000
Subject: [PATCH] ASoC: don't use codec hw_write on uda1380

uda1380 driver is using codec hw_write/control_data,
but it is redundant code. This patch cleanup these

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/uda1380.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 926c81ae8185..44448023edb0 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -37,7 +37,7 @@ struct uda1380_priv {
 	struct snd_soc_codec *codec;
 	unsigned int dac_clk;
 	struct work_struct work;
-	void *control_data;
+	struct i2c_client *i2c;
 };
 
 /*
@@ -92,6 +92,7 @@ static inline void uda1380_write_reg_cache(struct snd_soc_codec *codec,
 static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int value)
 {
+	struct uda1380_priv *uda1380 = snd_soc_codec_get_drvdata(codec);
 	u8 data[3];
 
 	/* data is
@@ -111,10 +112,10 @@ static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
 	if (!snd_soc_codec_is_active(codec) && (reg >= UDA1380_MVOL))
 		return 0;
 	pr_debug("uda1380: hw write %x val %x\n", reg, value);
-	if (codec->hw_write(codec->control_data, data, 3) == 3) {
+	if (i2c_master_send(uda1380->i2c, data, 3) == 3) {
 		unsigned int val;
-		i2c_master_send(codec->control_data, data, 1);
-		i2c_master_recv(codec->control_data, data, 2);
+		i2c_master_send(uda1380->i2c, data, 1);
+		i2c_master_recv(uda1380->i2c, data, 2);
 		val = (data[0]<<8) | data[1];
 		if (val != value) {
 			pr_debug("uda1380: READ BACK VAL %x\n",
@@ -130,6 +131,7 @@ static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
 
 static void uda1380_sync_cache(struct snd_soc_codec *codec)
 {
+	struct uda1380_priv *uda1380 = snd_soc_codec_get_drvdata(codec);
 	int reg;
 	u8 data[3];
 	u16 *cache = codec->reg_cache;
@@ -139,7 +141,7 @@ static void uda1380_sync_cache(struct snd_soc_codec *codec)
 		data[0] = reg;
 		data[1] = (cache[reg] & 0xff00) >> 8;
 		data[2] = cache[reg] & 0x00ff;
-		if (codec->hw_write(codec->control_data, data, 3) != 3)
+		if (i2c_master_send(uda1380->i2c, data, 3) != 3)
 			dev_err(codec->dev, "%s: write to reg 0x%x failed\n",
 				__func__, reg);
 	}
@@ -148,6 +150,7 @@ static void uda1380_sync_cache(struct snd_soc_codec *codec)
 static int uda1380_reset(struct snd_soc_codec *codec)
 {
 	struct uda1380_platform_data *pdata = codec->dev->platform_data;
+	struct uda1380_priv *uda1380 = snd_soc_codec_get_drvdata(codec);
 
 	if (gpio_is_valid(pdata->gpio_reset)) {
 		gpio_set_value(pdata->gpio_reset, 1);
@@ -160,7 +163,7 @@ static int uda1380_reset(struct snd_soc_codec *codec)
 		data[1] = 0;
 		data[2] = 0;
 
-		if (codec->hw_write(codec->control_data, data, 3) != 3) {
+		if (i2c_master_send(uda1380->i2c, data, 3) != 3) {
 			dev_err(codec->dev, "%s: failed\n", __func__);
 			return -EIO;
 		}
@@ -695,9 +698,6 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 
 	uda1380->codec = codec;
 
-	codec->hw_write = (hw_write_t)i2c_master_send;
-	codec->control_data = uda1380->control_data;
-
 	if (!gpio_is_valid(pdata->gpio_power)) {
 		ret = uda1380_reset(codec);
 		if (ret)
@@ -772,7 +772,7 @@ static int uda1380_i2c_probe(struct i2c_client *i2c,
 	}
 
 	i2c_set_clientdata(i2c, uda1380);
-	uda1380->control_data = i2c;
+	uda1380->i2c = i2c;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_uda1380, uda1380_dai, ARRAY_SIZE(uda1380_dai));
-- 
2.15.0
