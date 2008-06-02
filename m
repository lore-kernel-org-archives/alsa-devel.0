From: Timur Tabi <timur@freescale.com>
Subject: [PATCH][ASoC v2] Update Freescale MPC8610 codec driver
	naming
Date: Mon,  2 Jun 2008 17:55:36 -0500
Message-ID: <1212447336-13492-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D92E243E5
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jun 2008 00:55:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lg@opensource.wolfsonmicro.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Change the Freescale MPC8610 HPCD codec and fabric drivers to use the codec
name and id, instead of just the name, to match codec instances.  Previously,
the codec and fabric drivers would create a name string based on the
I2C bus and address.  Instead, keep the name as "cs4270" and combine the
bus and address into a unique number.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

My patch, "Add CS4270 i2c data to fsl_soc.c" must be applied for these drivers
to work.

 sound/soc/codecs/cs4270.c    |   21 ++++--
 sound/soc/fsl/mpc8610_hpcd.c |  147 +++++++++++++++++++++---------------------
 2 files changed, 88 insertions(+), 80 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 410fed5..df3294d 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -23,6 +23,8 @@
  * 7) The only supported control is volume and hardware mute (if enabled)
  */
 
+#define DEBUG
+
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -119,7 +121,6 @@
  */
 struct cs4270_private {
 	struct snd_soc_codec codec;
-	char name[16];
 	unsigned int mclk;
 	unsigned int mode;
 	struct snd_soc_dai *dai;
@@ -557,9 +558,6 @@ static int cs4270_i2c_probe(struct i2c_client *client,
 		goto error;
 	}
 
-	sprintf(cs4270->name, "%s@%s", dev_driver_string(&client->dev),
-		dev_name(&client->dev));
-
 	/* Initialize the playback and capture stream data.  The sample rate
 	 * fields are initialized later when the fabric driver calls
 	 * cs4270_set_dai_sysclk().  Hopefully, this won't cause any problems.
@@ -574,14 +572,19 @@ static int cs4270_i2c_probe(struct i2c_client *client,
 	cs4270->capture.channels_max = 2;
 	cs4270->capture.formats = CS4270_FORMATS;
 
+	/* Register the codec */
+
 	codec = &cs4270->codec;
 
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->list);
 	INIT_LIST_HEAD(&codec->dai_list);
-	codec->name = cs4270->name;
+
+	codec->name = "cs4270";
+	codec->num = client->adapter->nr << 16 | client->addr;
 
 	snd_soc_card_config_codec(codec, NULL, NULL, client);
+
 	codec->init = cs4270_codec_init;
 	codec->reg_cache = cs4270->reg_cache;
 	codec->codec_read = cs4270_read_reg_cache;
@@ -593,8 +596,12 @@ static int cs4270_i2c_probe(struct i2c_client *client,
 		dev_err(&client->dev, "failed to register card\n");
 		goto error;
 	}
-	memset(&dai_new, 0, sizeof(dai_new));
-	dai_new.name = cs4270->name;
+
+	/* Register the codec DAI */
+
+        memset(&dai_new, 0, sizeof(dai_new));
+	dai_new.name = codec->name;
+	dai_new.id = codec->num;
 	dai_new.playback = &cs4270->playback;
 	dai_new.capture = &cs4270->capture;
 	dai_new.ops = &dai_ops;
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 4beb61e..45c3311 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -42,7 +42,7 @@ struct mpc8610_hpcd_data {
 	struct snd_soc_card soc_card;
 	struct ccsr_guts __iomem *guts;
 	unsigned int num_configs;
-	struct snd_soc_pcm_config pcm_configs[MAX_SSI];
+	struct snd_soc_pcm_config configs[MAX_SSI];
 	struct mpc8610_hpcd_names {
 		char pcm_name[32];
 		char ssi_name[32];
@@ -265,72 +265,33 @@ static void mpc8610_hpcd_shutdown(struct snd_pcm_substream *substream)
 }
 
 /**
- * get_codec_name: get the name of the codec that a given SSI is using
- * @ssi_np: pointer to the SSI node
- * @name: returned name of the codec driver
- *
- * This function returns the name of the codec device that matches a given
- * SSI.
- *
- * The purpose behind this function is to make the device tree the sole
- * source of information concerning the linkage between devices in the ASoC
- * device chain.  Unfortunately, it's not really as elegant as it should be.
- *
- * With this function, we should be able to mix-and-match codecs just by
- * loading the right codec driver.
+ * find_codec: return the node for the codec of a given SSI
+ * @ssi_np: the device node for the SSI to look up
  */
-static int get_codec_name(struct device_node *ssi_np, char *name)
+static struct device_node *find_codec(struct device_node *ssi_np)
 {
 	const phandle *codec_ph;
-	struct device_node *codec_np;
-	struct device_node *i2c_np;
-	unsigned int bus;
-	unsigned int addr;
-	const unsigned int *iprop;
-	const char *compat;
 
 	codec_ph = of_get_property(ssi_np, "codec-handle", NULL);
-	if (!codec_ph) {
-		pr_debug("%s: no codec handle\n", ssi_np->full_name);
-		return 0;
-	}
-
-	codec_np = of_find_node_by_phandle(*codec_ph);
-	if (!codec_np) {
-		pr_debug("%s: codec node does not exist\n", ssi_np->full_name);
-		return -1;
-	}
+	if (!codec_ph)
+		return NULL;
 
-	/* We assume that the first (or only) string in the compatible field is
-	 * the one that counts.
-	 */
-	compat = of_get_property(codec_np, "compatible", NULL);
+	return of_find_node_by_phandle(*codec_ph);
+}
 
-	/* We only care about the part after the comma */
-	compat = strchr(compat, ',') + 1;
+static int of_get_integer(struct device_node *np, const char *string)
+{
+	const u32 *iprop;
+	int len;
 
-	/* Now determine the I2C bus and address it's on */
-	i2c_np = of_get_parent(codec_np);
-	iprop = of_get_property(i2c_np, "cell-index", NULL);
-	if (!iprop) {
-		pr_debug("%s: cannot determine I2C bus number\n",
-			codec_np->full_name);
+	iprop = of_get_property(np, string, &len);
+	if (!iprop)
 		return -1;
-	}
-	bus = *iprop;
 
-	iprop = of_get_property(codec_np, "reg", NULL);
-	if (!iprop) {
-		pr_debug("%s: cannot determine I2C address\n",
-			codec_np->full_name);
+	if (len != sizeof(u32))
 		return -1;
-	}
-	addr = *iprop;
-
-	/* Now build the string */
-	sprintf(name, "%s@%d-%04x", compat, bus, addr);
 
-	return 1;
+	return *iprop;
 }
 
 /**
@@ -356,7 +317,7 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	struct mpc8610_hpcd_data *soc_card_data;
 	struct device_node *guts_np = NULL;
 	struct device_node *ssi_np;
-	unsigned int i = 0;
+	unsigned int ssi = 0;
 	int ret = -ENODEV;
 
 	soc_card_data = kzalloc(sizeof(struct mpc8610_hpcd_data), GFP_KERNEL);
@@ -396,12 +357,17 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	 * codec is registered.  Remember, we only support MAX_SSI of these.
 	 */
 	for_each_compatible_node(ssi_np, NULL, "fsl,mpc8610-ssi") {
-		const unsigned int *iprop;
 		struct snd_soc_pcm_config *pcm_config;
 		struct mpc8610_hpcd_names *name;
+		struct device_node *codec_np;
+		const char *compat;
+		const char *p;
+		unsigned int bus;
+		unsigned int address;
+		int i;
 
-		name = &soc_card_data->names[i];
-		pcm_config = &soc_card_data->pcm_configs[i];
+		name = &soc_card_data->names[ssi];
+		pcm_config = &soc_card_data->configs[ssi];
 
 		pcm_config->name = name->pcm_name;
 		pcm_config->codec = name->codec_name;
@@ -412,39 +378,74 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 		pcm_config->playback = 1;
 		pcm_config->capture = 1;
 
-		sprintf(name->pcm_name, "MPC8610HPCD.%u", i);
+		sprintf(name->pcm_name, "MPC8610HPCD.%u", ssi);
 
 		/* Get the SSI name */
-		iprop = of_get_property(ssi_np, "cell-index", NULL);
-		if (!iprop) {
+		i = of_get_integer(ssi_np, "cell-index");
+		if (i < 0) {
 			dev_err(soc_card->dev, "no cell-index for %s\n",
 				ssi_np->full_name);
 			continue;
 		}
-		sprintf(name->ssi_name, "ssi%u", *iprop);
+		sprintf(name->ssi_name, "ssi%u", i);
 
-		/* Get the codec name  */
-		ret = get_codec_name(ssi_np, name->codec_name);
-		if (ret < 0)
-			dev_err(soc_card->dev, "could not get codec for %s\n",
+		/* Get the codec name and ID */
+		codec_np = find_codec(ssi_np);
+		if (!codec_np) {
+			dev_err(soc_card->dev, "missing codec node for %s\n",
 				ssi_np->full_name);
-		if (ret < 1)
 			continue;
+		}
+
+		/* We assume that the first (or only) string in the compatible
+		 * field is the one that counts.
+		 */
+		compat = of_get_property(codec_np, "compatible", NULL);
+		if (!compat) {
+			dev_err(soc_card->dev,
+				"missing compatible property for %s\n",
+				ssi_np->full_name);
+			continue;
+		}
+
+		/* We only care about the part after the comma */
+		p = strchr(compat, ',');
+		strcpy(name->codec_name, p ? p + 1 : compat);
+
+		/* Now determine the I2C bus and address of the codec */
+		bus = of_get_integer(of_get_parent(codec_np), "cell-index");
+		if (bus < 0) {
+			dev_err(soc_card->dev,
+				"cannot determine I2C bus number for %s\n",
+				codec_np->full_name);
+			continue;
+		}
+
+		address = of_get_integer(codec_np, "reg");
+		if (address < 0) {
+			dev_err(soc_card->dev,
+				"cannot determine I2C address for %s\n",
+				codec_np->full_name);
+			continue;
+		}
+
+		pcm_config->codec_num = bus << 16 | address;
 
-		dev_dbg(soc_card->dev, "registering cpu %s with codec %s\n",
-			pcm_config->cpu_dai, pcm_config->codec);
+		dev_dbg(soc_card->dev, "registering cpu %s with codec %s-%x\n",
+			pcm_config->cpu_dai, pcm_config->codec,
+			pcm_config->codec_num);
 
-		if (++i == MAX_SSI)
+		if (++ssi == MAX_SSI)
 			break;
 	}
 
-	ret = snd_soc_card_create_pcms(soc_card, soc_card_data->pcm_configs, i);
+	ret = snd_soc_card_create_pcms(soc_card, soc_card_data->configs, ssi);
 	if (ret) {
 		dev_err(soc_card->dev, "could not create PCMs\n");
 		return ret;
 	}
 
-	soc_card_data->num_configs = i;
+	soc_card_data->num_configs = ssi;
 
 	platform_set_drvdata(pdev, soc_card);
 
-- 
1.5.5
