From: Jean Delvare <khali@linux-fr.org>
Subject: snd-soc-cs4270: Convert to a new-style i2c driver
 (work in progress)
Date: Sun, 31 Aug 2008 16:18:43 +0200
Message-ID: <20080831161843.227b31f3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A5B5244FD
	for <alsa-devel@alsa-project.org>;
	Sun, 31 Aug 2008 16:18:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Tibur,

I am in the process of converting your cs4270 codec driver from the
legacy i2c model to the new (standard) one. This is work in progress.
The patch below converts the cs4270 driver itself. However we also need
to convert its users. As far as I can see there's only one user at this
point: mpc8610_hpcd.

The problem is that this driver doesn't look like the other codec
drivers I have already converted. So, we need to add code to
instantiate the cs4270 i2c device, but I don't know where this should
happen. Given that the mpc8610_hpcd is apparently based on Open
Firmware, I guess that the i2c device should be instantiated directly
by the platform code. I see that the device is declared in
mpc8610_hpcd.dts, so maybe it's already done and my patch should work
already? What do you think?

Thanks.

* * * * *

Convert the cs4270 codec driver to the new (standard) device driver
binding model. After this change, CS4720 devices are no longer
discovered automatically and must instead be instantiated explicitly.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |   79 +++++++++------------------------------------
 1 file changed, 16 insertions(+), 63 deletions(-)

--- linux-2.6.27-rc5.orig/sound/soc/codecs/cs4270.c	2008-08-31 14:23:34.000000000 +0200
+++ linux-2.6.27-rc5/sound/soc/codecs/cs4270.c	2008-08-31 15:16:43.000000000 +0200
@@ -272,17 +272,6 @@ static int cs4270_set_dai_fmt(struct snd
 }
 
 /*
- * A list of addresses on which this CS4270 could use.  I2C addresses are
- * 7 bits.  For the CS4270, the upper four bits are always 1001, and the
- * lower three bits are determined via the AD2, AD1, and AD0 pins
- * (respectively).
- */
-static const unsigned short normal_i2c[] = {
-	0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, I2C_CLIENT_END
-};
-I2C_CLIENT_INSMOD;
-
-/*
  * Pre-fill the CS4270 register cache.
  *
  * We use the auto-increment feature of the CS4270 to read all registers in
@@ -490,32 +479,18 @@ static int cs4270_mute(struct snd_soc_da
 
 #endif
 
-static int cs4270_i2c_probe(struct i2c_adapter *adap, int addr, int kind);
+static int cs4270_i2c_probe(struct i2c_client *i2c_client,
+			    const struct i2c_device_id *id);
 
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
+static int cs4270_i2c_remove(struct i2c_client *client)
 {
 	struct snd_soc_codec *codec = i2c_get_clientdata(client);
 
-	i2c_detach_client(client);
 	codec->control_data = NULL;
 
 	kfree(codec->reg_cache);
 	codec->reg_cache = NULL;
 
-	kfree(client);
 	return 0;
 }
 
@@ -525,14 +500,19 @@ static const struct snd_kcontrol_new cs4
 		CS4270_VOLA, CS4270_VOLB, 0, 0xFF, 1)
 };
 
+static const struct i2c_device_id cs4270_i2c_id[] = {
+	{ "cs4270", 0 },
+	{ }
+};
+
 static struct i2c_driver cs4270_i2c_driver = {
 	.driver = {
 		.name = "CS4270 I2C",
 		.owner = THIS_MODULE,
 	},
-	.id =             I2C_DRIVERID_CS4270,
-	.attach_adapter = cs4270_i2c_attach,
-	.detach_client =  cs4270_i2c_detach,
+	.probe =    cs4270_i2c_probe,
+	.remove =   cs4270_i2c_remove,
+	.id_table = cs4270_i2c_id,
 };
 
 /*
@@ -555,17 +535,14 @@ static struct snd_soc_device *cs4270_soc
 /*
  * Initialize the I2C interface of the CS4270
  *
- * This function is called for whenever the I2C subsystem finds a device
- * at a particular address.
- *
  * Note: snd_soc_new_pcms() must be called before this function can be called,
  * because of snd_ctl_add().
  */
-static int cs4270_i2c_probe(struct i2c_adapter *adapter, int addr, int kind)
+static int cs4270_i2c_probe(struct i2c_client *i2c_client,
+			    const struct i2c_device_id *id)
 {
 	struct snd_soc_device *socdev = cs4270_socdev;
 	struct snd_soc_codec *codec = socdev->codec;
-	struct i2c_client *i2c_client = NULL;
 	int i;
 	int ret = 0;
 
@@ -578,12 +555,6 @@ static int cs4270_i2c_probe(struct i2c_a
 
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
@@ -592,11 +563,6 @@ static int cs4270_i2c_probe(struct i2c_a
 	}
 
 	i2c_set_clientdata(i2c_client, codec);
-	strcpy(i2c_client->name, "CS4270");
-
-	i2c_client->driver = &cs4270_i2c_driver;
-	i2c_client->adapter = adapter;
-	i2c_client->addr = addr;
 
 	/* Verify that we have a CS4270 */
 
@@ -612,18 +578,10 @@ static int cs4270_i2c_probe(struct i2c_a
 		goto error;
 	}
 
-	printk(KERN_INFO "cs4270: found device at I2C address %X\n", addr);
+	printk(KERN_INFO "cs4270: found device at I2C address %X\n",
+	       i2c_client->addr);
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
@@ -651,17 +609,12 @@ static int cs4270_i2c_probe(struct i2c_a
 	return 0;
 
 error:
-	if (codec->control_data) {
-		i2c_detach_client(i2c_client);
-		codec->control_data = NULL;
-	}
+	codec->control_data = NULL;
 
 	kfree(codec->reg_cache);
 	codec->reg_cache = NULL;
 	codec->reg_cache_size = 0;
 
-	kfree(i2c_client);
-
 	return ret;
 }
 


-- 
Jean Delvare
