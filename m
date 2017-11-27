From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use codec hw_write on
	tlv320dac33" to the asoc tree
Date: Mon, 27 Nov 2017 18:52:14 +0000
Message-ID: <E1eJOVq-0006uG-Sc@debutante>
References: <87efrrm11c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 68123267568
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:52:18 +0100 (CET)
In-Reply-To: <87efrrm11c.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: don't use codec hw_write on tlv320dac33

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

>From ce9544dc8f9a83f9e8ff08eca30821edbe51d177 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 9 Nov 2017 00:19:48 +0000
Subject: [PATCH] ASoC: don't use codec hw_write on tlv320dac33

uda1380 driver is using codec hw_write/control_data,
but it is redundant code. This patch cleanup these

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320dac33.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 5b94a151539c..80a26418827c 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -121,7 +121,7 @@ struct tlv320dac33_priv {
 	unsigned int uthr;
 
 	enum dac33_state state;
-	void *control_data;
+	struct i2c_client *i2c;
 };
 
 static const u8 dac33_reg[DAC33_CACHEREGNUM] = {
@@ -200,7 +200,7 @@ static int dac33_read(struct snd_soc_codec *codec, unsigned int reg,
 
 	/* If powered off, return the cached value */
 	if (dac33->chip_power) {
-		val = i2c_smbus_read_byte_data(codec->control_data, value[0]);
+		val = i2c_smbus_read_byte_data(dac33->i2c, value[0]);
 		if (val < 0) {
 			dev_err(codec->dev, "Read failed (%d)\n", val);
 			value[0] = dac33_read_reg_cache(codec, reg);
@@ -233,7 +233,7 @@ static int dac33_write(struct snd_soc_codec *codec, unsigned int reg,
 
 	dac33_write_reg_cache(codec, data[0], data[1]);
 	if (dac33->chip_power) {
-		ret = codec->hw_write(codec->control_data, data, 2);
+		ret = i2c_master_send(dac33->i2c, data, 2);
 		if (ret != 2)
 			dev_err(codec->dev, "Write failed (%d)\n", ret);
 		else
@@ -280,7 +280,7 @@ static int dac33_write16(struct snd_soc_codec *codec, unsigned int reg,
 	if (dac33->chip_power) {
 		/* We need to set autoincrement mode for 16 bit writes */
 		data[0] |= DAC33_I2C_ADDR_AUTOINC;
-		ret = codec->hw_write(codec->control_data, data, 3);
+		ret = i2c_master_send(dac33->i2c, data, 3);
 		if (ret != 3)
 			dev_err(codec->dev, "Write failed (%d)\n", ret);
 		else
@@ -1379,8 +1379,6 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	codec->control_data = dac33->control_data;
-	codec->hw_write = (hw_write_t) i2c_master_send;
 	dac33->codec = codec;
 
 	/* Read the tlv320dac33 ID registers */
@@ -1499,7 +1497,7 @@ static int dac33_i2c_probe(struct i2c_client *client,
 	if (dac33 == NULL)
 		return -ENOMEM;
 
-	dac33->control_data = client;
+	dac33->i2c = client;
 	mutex_init(&dac33->mutex);
 	spin_lock_init(&dac33->lock);
 
-- 
2.15.0
