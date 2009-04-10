From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 1/2] keywest: Convert to new-style i2c driver
Date: Fri, 10 Apr 2009 17:07:26 +0200
Message-ID: <20090410170726.3616b6d5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 83FA8243CC
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Apr 2009 17:07:33 +0200 (CEST)
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
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: alsa-devel@alsa-project.org

The legacy i2c binding model is going away soon, so convert the ppc
keywest sound driver to the new model or it will break.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 sound/ppc/keywest.c |   81 +++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 41 deletions(-)

--- linux-2.6.30-rc1.orig/sound/ppc/keywest.c	2009-04-10 15:22:18.000000000 +0200
+++ linux-2.6.30-rc1/sound/ppc/keywest.c	2009-04-10 16:41:36.000000000 +0200
@@ -33,26 +33,25 @@
 static struct pmac_keywest *keywest_ctx;
 
 
-static int keywest_attach_adapter(struct i2c_adapter *adapter);
-static int keywest_detach_client(struct i2c_client *client);
-
-struct i2c_driver keywest_driver = {  
-	.driver = {
-		.name = "PMac Keywest Audio",
-	},
-	.attach_adapter = &keywest_attach_adapter,
-	.detach_client = &keywest_detach_client,
-};
-
-
 #ifndef i2c_device_name
 #define i2c_device_name(x)	((x)->name)
 #endif
 
+static int keywest_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	i2c_set_clientdata(client, keywest_ctx);
+	return 0;
+}
+
+/*
+ * This is kind of a hack, best would be to turn powermac to fixed i2c
+ * bus numbers and declare the sound device as part of platform
+ * initialization
+ */
 static int keywest_attach_adapter(struct i2c_adapter *adapter)
 {
-	int err;
-	struct i2c_client *new_client;
+	struct i2c_board_info info;
 
 	if (! keywest_ctx)
 		return -EINVAL;
@@ -60,46 +59,46 @@ static int keywest_attach_adapter(struct
 	if (strncmp(i2c_device_name(adapter), "mac-io", 6))
 		return 0; /* ignored */
 
-	new_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
-	if (! new_client)
-		return -ENOMEM;
-
-	new_client->addr = keywest_ctx->addr;
-	i2c_set_clientdata(new_client, keywest_ctx);
-	new_client->adapter = adapter;
-	new_client->driver = &keywest_driver;
-	new_client->flags = 0;
-
-	strcpy(i2c_device_name(new_client), keywest_ctx->name);
-	keywest_ctx->client = new_client;
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	strlcpy(info.type, "keywest", I2C_NAME_SIZE);
+	info.addr = keywest_ctx->addr;
+	keywest_ctx->client = i2c_new_device(adapter, &info);
 	
-	/* Tell the i2c layer a new client has arrived */
-	if (i2c_attach_client(new_client)) {
-		snd_printk(KERN_ERR "tumbler: cannot attach i2c client\n");
-		err = -ENODEV;
-		goto __err;
-	}
-
+	/*
+	 * Let i2c-core delete that device on driver removal.
+	 * This is safe because i2c-core holds the core_lock mutex for us.
+	 */
+	list_add_tail(&keywest_ctx->client->detected,
+		      &keywest_ctx->client->driver->clients);
 	return 0;
-
- __err:
-	kfree(new_client);
-	keywest_ctx->client = NULL;
-	return err;
 }
 
-static int keywest_detach_client(struct i2c_client *client)
+static int keywest_remove(struct i2c_client *client)
 {
 	if (! keywest_ctx)
 		return 0;
 	if (client == keywest_ctx->client)
 		keywest_ctx->client = NULL;
 
-	i2c_detach_client(client);
-	kfree(client);
 	return 0;
 }
 
+
+static const struct i2c_device_id keywest_i2c_id[] = {
+	{ "keywest", 0 },
+	{ }
+};
+
+struct i2c_driver keywest_driver = {
+	.driver = {
+		.name = "PMac Keywest Audio",
+	},
+	.attach_adapter = keywest_attach_adapter,
+	.probe = keywest_probe,
+	.remove = keywest_remove,
+	.id_table = keywest_i2c_id,
+};
+
 /* exported */
 void snd_pmac_keywest_cleanup(struct pmac_keywest *i2c)
 {


-- 
Jean Delvare
