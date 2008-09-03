From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ALSA: ASoC: Fix memory leaks for the CS4270
	driver
Date: Wed,  3 Sep 2008 17:07:14 -0500
Message-ID: <1220479634-26912-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 45282103815
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 00:07:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

The CS4270 ASoC driver was not cleaning up resources completely during an
I2C unbind.  The same problem could occur if the bind failed.

Rearranged a couple functions to eliminate an unnecessary function declaration.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is a fix for 2.6.27.  It applies only to the ASoC V1 version of the
driver.  A similar fix for the V2 version will be posted later.

 sound/soc/codecs/cs4270.c |   94 ++++++++++++++++++++++++++++++--------------
 1 files changed, 64 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 82d94f0..eb38e92 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -490,29 +490,6 @@ static int cs4270_mute(struct snd_soc_dai *dai, int mute)
 
 #endif
 
-static int cs4270_i2c_probe(struct i2c_client *, const struct i2c_device_id *);
-
-/* A list of non-DAPM controls that the CS4270 supports */
-static const struct snd_kcontrol_new cs4270_snd_controls[] = {
-	SOC_DOUBLE_R("Master Playback Volume",
-		CS4270_VOLA, CS4270_VOLB, 0, 0xFF, 1)
-};
-
-static const struct i2c_device_id cs4270_id[] = {
-	{"cs4270", 0},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, cs4270_id);
-
-static struct i2c_driver cs4270_i2c_driver = {
-	.driver = {
-		.name = "CS4270 I2C",
-		.owner = THIS_MODULE,
-	},
-	.id_table = cs4270_id,
-	.probe = cs4270_i2c_probe,
-};
-
 /*
  * Global variable to store socdev for i2c probe function.
  *
@@ -530,6 +507,12 @@ static struct i2c_driver cs4270_i2c_driver = {
  */
 static struct snd_soc_device *cs4270_socdev;
 
+/* A list of non-DAPM controls that the CS4270 supports */
+static const struct snd_kcontrol_new cs4270_snd_controls[] = {
+	SOC_DOUBLE_R("Master Playback Volume",
+		CS4270_VOLA, CS4270_VOLB, 0, 0xFF, 1)
+};
+
 /*
  * Initialize the I2C interface of the CS4270
  *
@@ -559,8 +542,7 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	codec->reg_cache = kzalloc(CS4270_NUMREGS, GFP_KERNEL);
 	if (!codec->reg_cache) {
 		printk(KERN_ERR "cs4270: could not allocate register cache\n");
-		ret = -ENOMEM;
-		goto error;
+		return -ENOMEM;
 	}
 
 	/* Verify that we have a CS4270 */
@@ -610,20 +592,72 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	return 0;
 
 error:
-	if (codec->control_data) {
-		i2c_detach_client(i2c_client);
-		codec->control_data = NULL;
+	for (i = 1; i <= ARRAY_SIZE(cs4270_snd_controls); i++) {
+		struct snd_kcontrol *kctrl =
+			snd_ctl_find_numid(codec->card, i);
+
+		if (kctrl)
+			snd_ctl_remove(codec->card, kctrl);
 	}
 
+	codec->control_data = NULL;
+
 	kfree(codec->reg_cache);
 	codec->reg_cache = NULL;
 	codec->reg_cache_size = 0;
 
-	kfree(i2c_client);
-
 	return ret;
 }
 
+/*
+ * Remove I2C interface of the CS4270
+ *
+ * Since this driver cannot be compiled as a module, the only way this
+ * function can be called is if the I2C subsystem unbinds it.  This can be
+ * triggered, for instance, by writing the device ID to this drivers
+ * 'unbind' file in /sys.
+ */
+static int cs4270_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct snd_soc_codec *codec = i2c_get_clientdata(i2c_client);
+
+	if (codec) {
+		unsigned int i;
+
+		for (i = 1; i <= ARRAY_SIZE(cs4270_snd_controls); i++) {
+			struct snd_kcontrol *kctrl =
+				snd_ctl_find_numid(codec->card, i);
+
+			if (kctrl)
+				snd_ctl_remove(codec->card, kctrl);
+		}
+
+		codec->control_data = NULL;
+
+		kfree(codec->reg_cache);
+		codec->reg_cache = NULL;
+		codec->reg_cache_size = 0;
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id cs4270_id[] = {
+	{"cs4270", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs4270_id);
+
+static struct i2c_driver cs4270_i2c_driver = {
+	.driver = {
+		.name = "cs4270",
+		.owner = THIS_MODULE,
+	},
+	.id_table = cs4270_id,
+	.probe = cs4270_i2c_probe,
+	.remove = cs4270_i2c_remove,
+};
+
 #endif /* USE_I2C*/
 
 struct snd_soc_dai cs4270_dai = {
-- 
1.5.5
