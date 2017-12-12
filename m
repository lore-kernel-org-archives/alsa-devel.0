From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas5720: add basic support for TAS5722
	devices" to the asoc tree
Date: Tue, 12 Dec 2017 12:05:52 +0000
Message-ID: <E1eOjJo-0002CV-ID@debutante>
References: <20171211190157.12371-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8224A267761
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 13:05:56 +0100 (CET)
In-Reply-To: <20171211190157.12371-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, "Andrew F . Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas5720: add basic support for TAS5722 devices

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

>From 872bcad246e30f0ae8009a0f8c13874009601445 Mon Sep 17 00:00:00 2001
From: Andreas Dannenberg <dannenberg@ti.com>
Date: Mon, 11 Dec 2017 13:01:54 -0600
Subject: [PATCH] ASoC: tas5720: add basic support for TAS5722 devices

The TI TAS5722 digital amplifier is very similar to the TAS5720 from an
overall and register map perspective. Therefore the existing driver can be
extended easily to support this additional device. This commit allows
TAS5722 devices to be used in a "subset" type of fashion, without exposing
any of the additional features they offer.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/tas5720.txt          |  4 ++-
 sound/soc/codecs/tas5720.c                         | 38 ++++++++++++++++++----
 sound/soc/codecs/tas5720.h                         |  1 +
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas5720.txt b/Documentation/devicetree/bindings/sound/tas5720.txt
index 40d94f82beb3..7481653fe8e3 100644
--- a/Documentation/devicetree/bindings/sound/tas5720.txt
+++ b/Documentation/devicetree/bindings/sound/tas5720.txt
@@ -6,10 +6,12 @@ audio playback. For more product information please see the links below:
 
 http://www.ti.com/product/TAS5720L
 http://www.ti.com/product/TAS5720M
+http://www.ti.com/product/TAS5722L
 
 Required properties:
 
-- compatible : "ti,tas5720"
+- compatible : "ti,tas5720",
+               "ti,tas5722"
 - reg : I2C slave address
 - dvdd-supply : phandle to a 3.3-V supply for the digital circuitry
 - pvdd-supply : phandle to a supply used for the Class-D amp and the analog
diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index a736a2a6976c..5def54d1336d 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -36,6 +36,11 @@
 /* Define how often to check (and clear) the fault status register (in ms) */
 #define TAS5720_FAULT_CHECK_INTERVAL		200
 
+enum tas572x_type {
+	TAS5720,
+	TAS5722,
+};
+
 static const char * const tas5720_supply_names[] = {
 	"dvdd",		/* Digital power supply. Connect to 3.3-V supply. */
 	"pvdd",		/* Class-D amp and analog power supply (connected). */
@@ -47,6 +52,7 @@ struct tas5720_data {
 	struct snd_soc_codec *codec;
 	struct regmap *regmap;
 	struct i2c_client *tas5720_client;
+	enum tas572x_type devtype;
 	struct regulator_bulk_data supplies[TAS5720_NUM_SUPPLIES];
 	struct delayed_work fault_check_work;
 	unsigned int last_fault;
@@ -264,7 +270,7 @@ static void tas5720_fault_check_work(struct work_struct *work)
 static int tas5720_codec_probe(struct snd_soc_codec *codec)
 {
 	struct tas5720_data *tas5720 = snd_soc_codec_get_drvdata(codec);
-	unsigned int device_id;
+	unsigned int device_id, expected_device_id;
 	int ret;
 
 	tas5720->codec = codec;
@@ -276,6 +282,11 @@ static int tas5720_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
+	/*
+	 * Take a liberal approach to checking the device ID to allow the
+	 * driver to be used even if the device ID does not match, however
+	 * issue a warning if there is a mismatch.
+	 */
 	ret = regmap_read(tas5720->regmap, TAS5720_DEVICE_ID_REG, &device_id);
 	if (ret < 0) {
 		dev_err(codec->dev, "failed to read device ID register: %d\n",
@@ -283,13 +294,22 @@ static int tas5720_codec_probe(struct snd_soc_codec *codec)
 		goto probe_fail;
 	}
 
-	if (device_id != TAS5720_DEVICE_ID) {
-		dev_err(codec->dev, "wrong device ID. expected: %u read: %u\n",
-			TAS5720_DEVICE_ID, device_id);
-		ret = -ENODEV;
-		goto probe_fail;
+	switch (tas5720->devtype) {
+	case TAS5720:
+		expected_device_id = TAS5720_DEVICE_ID;
+		break;
+	case TAS5722:
+		expected_device_id = TAS5722_DEVICE_ID;
+		break;
+	default:
+		dev_err(codec->dev, "unexpected private driver data\n");
+		return -EINVAL;
 	}
 
+	if (device_id != expected_device_id)
+		dev_warn(codec->dev, "wrong device ID. expected: %u read: %u\n",
+			 expected_device_id, device_id);
+
 	/* Set device to mute */
 	ret = snd_soc_update_bits(codec, TAS5720_DIGITAL_CTRL2_REG,
 				  TAS5720_MUTE, TAS5720_MUTE);
@@ -552,6 +572,8 @@ static int tas5720_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	data->tas5720_client = client;
+	data->devtype = id->driver_data;
+
 	data->regmap = devm_regmap_init_i2c(client, &tas5720_regmap_config);
 	if (IS_ERR(data->regmap)) {
 		ret = PTR_ERR(data->regmap);
@@ -592,7 +614,8 @@ static int tas5720_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tas5720_id[] = {
-	{ "tas5720", 0 },
+	{ "tas5720", TAS5720 },
+	{ "tas5722", TAS5722 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tas5720_id);
@@ -600,6 +623,7 @@ MODULE_DEVICE_TABLE(i2c, tas5720_id);
 #if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id tas5720_of_match[] = {
 	{ .compatible = "ti,tas5720", },
+	{ .compatible = "ti,tas5722", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tas5720_of_match);
diff --git a/sound/soc/codecs/tas5720.h b/sound/soc/codecs/tas5720.h
index 3d077c779b12..bef802afcc69 100644
--- a/sound/soc/codecs/tas5720.h
+++ b/sound/soc/codecs/tas5720.h
@@ -32,6 +32,7 @@
 
 /* TAS5720_DEVICE_ID_REG */
 #define TAS5720_DEVICE_ID		0x01
+#define TAS5722_DEVICE_ID		0x12
 
 /* TAS5720_POWER_CTRL_REG */
 #define TAS5720_DIG_CLIP_MASK		GENMASK(7, 2)
-- 
2.15.1
