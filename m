From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] alsa: make the CS4270 driver a new-style I2C
	driver
Date: Tue, 29 Jul 2008 16:35:52 -0500
Message-ID: <1217367352-23576-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 25ABC103839
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 23:35:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Update the CS4270 ALSA device driver to use the new-style I2C interface.
Starting with the 2.6.27 PowerPC kernel, I2C devices that have entries in the
device trees can no longer be probed by old-style I2C drivers.  The device
tree for Freescale MPC8610 HPCD has included an entry for the CS4270 since
2.6.25, but that entry was previously ignored by the PowerPC I2C subsystem.
Since that's no longer the case, the best solution is to update the CS4270
driver to a new-style interface, rather than try to revert the behavior of
new PowerPC I2C subsystem.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for 2.6.27 (ASoC V1).  It's not needed for 2.6.26, because that
kernel uses the older PowerPC I2C code.  It's not needed for ASoC V2, because
the ASoC V2 CS4270 driver has always been a new-style driver.

 sound/soc/codecs/cs4270.c |   71 +++++++++-----------------------------------
 1 files changed, 15 insertions(+), 56 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 9deb8c7..82d94f0 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -490,34 +490,7 @@ static int cs4270_mute(struct snd_soc_dai *dai, int mute)
 
 #endif
 
-static int cs4270_i2c_probe(struct i2c_adapter *adap, int addr, int kind);
-
-/*
- * Notify the driver that a new I2C bus has been found.
- *
- * This function is called for each I2C bus in the system.  The function
- * then asks the I2C subsystem to probe that bus at the addresses on which
- * our device (the CS4270) could exist.  If a device is found at one of
- * those addresses, then our probe function (cs4270_i2c_probe) is called.
- */
-static int cs4270_i2c_attach(struct i2c_adapter *adapter)
-{
-	return i2c_probe(adapter, &addr_data, cs4270_i2c_probe);
-}
-
-static int cs4270_i2c_detach(struct i2c_client *client)
-{
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-
-	i2c_detach_client(client);
-	codec->control_data = NULL;
-
-	kfree(codec->reg_cache);
-	codec->reg_cache = NULL;
-
-	kfree(client);
-	return 0;
-}
+static int cs4270_i2c_probe(struct i2c_client *, const struct i2c_device_id *);
 
 /* A list of non-DAPM controls that the CS4270 supports */
 static const struct snd_kcontrol_new cs4270_snd_controls[] = {
@@ -525,14 +498,19 @@ static const struct snd_kcontrol_new cs4270_snd_controls[] = {
 		CS4270_VOLA, CS4270_VOLB, 0, 0xFF, 1)
 };
 
+static const struct i2c_device_id cs4270_id[] = {
+	{"cs4270", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs4270_id);
+
 static struct i2c_driver cs4270_i2c_driver = {
 	.driver = {
 		.name = "CS4270 I2C",
 		.owner = THIS_MODULE,
 	},
-	.id =             I2C_DRIVERID_CS4270,
-	.attach_adapter = cs4270_i2c_attach,
-	.detach_client =  cs4270_i2c_detach,
+	.id_table = cs4270_id,
+	.probe = cs4270_i2c_probe,
 };
 
 /*
@@ -561,11 +539,11 @@ static struct snd_soc_device *cs4270_socdev;
  * Note: snd_soc_new_pcms() must be called before this function can be called,
  * because of snd_ctl_add().
  */
-static int cs4270_i2c_probe(struct i2c_adapter *adapter, int addr, int kind)
+static int cs4270_i2c_probe(struct i2c_client *i2c_client,
+	const struct i2c_device_id *id)
 {
 	struct snd_soc_device *socdev = cs4270_socdev;
 	struct snd_soc_codec *codec = socdev->codec;
-	struct i2c_client *i2c_client = NULL;
 	int i;
 	int ret = 0;
 
@@ -578,12 +556,6 @@ static int cs4270_i2c_probe(struct i2c_adapter *adapter, int addr, int kind)
 
 	/* Note: codec_dai->codec is NULL here */
 
-	i2c_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
-	if (!i2c_client) {
-		printk(KERN_ERR "cs4270: could not allocate I2C client\n");
-		return -ENOMEM;
-	}
-
 	codec->reg_cache = kzalloc(CS4270_NUMREGS, GFP_KERNEL);
 	if (!codec->reg_cache) {
 		printk(KERN_ERR "cs4270: could not allocate register cache\n");
@@ -591,13 +563,6 @@ static int cs4270_i2c_probe(struct i2c_adapter *adapter, int addr, int kind)
 		goto error;
 	}
 
-	i2c_set_clientdata(i2c_client, codec);
-	strcpy(i2c_client->name, "CS4270");
-
-	i2c_client->driver = &cs4270_i2c_driver;
-	i2c_client->adapter = adapter;
-	i2c_client->addr = addr;
-
 	/* Verify that we have a CS4270 */
 
 	ret = i2c_smbus_read_byte_data(i2c_client, CS4270_CHIPID);
@@ -612,18 +577,10 @@ static int cs4270_i2c_probe(struct i2c_adapter *adapter, int addr, int kind)
 		goto error;
 	}
 
-	printk(KERN_INFO "cs4270: found device at I2C address %X\n", addr);
+	printk(KERN_INFO "cs4270: found device at I2C address %X\n",
+		i2c_client->addr);
 	printk(KERN_INFO "cs4270: hardware revision %X\n", ret & 0xF);
 
-	/* Tell the I2C layer a new client has arrived */
-
-	ret = i2c_attach_client(i2c_client);
-	if (ret) {
-		printk(KERN_ERR "cs4270: could not attach codec, "
-			"I2C address %x, error code %i\n", addr, ret);
-		goto error;
-	}
-
 	codec->control_data = i2c_client;
 	codec->read = cs4270_read_reg_cache;
 	codec->write = cs4270_i2c_write;
@@ -648,6 +605,8 @@ static int cs4270_i2c_probe(struct i2c_adapter *adapter, int addr, int kind)
 			goto error;
 	}
 
+	i2c_set_clientdata(i2c_client, codec);
+
 	return 0;
 
 error:
-- 
1.5.5
