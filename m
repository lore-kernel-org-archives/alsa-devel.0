From: Timur Tabi <timur@freescale.com>
Subject: [PATCH][ASoC v2] Update Freescale MPC8610HPCD fabric
	driver to support multiple codecs
Date: Thu, 12 Jun 2008 19:01:39 -0500
Message-ID: <1213315299-30592-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id B88902437E
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 02:01:45 +0200 (CEST)
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

Update the Freescale MPC8610 HPCD fabric driver to create a new platform device
for each SSI in the system, instead of registering multiple PCMs under one card.
This is necessary for alsamixer to control the individual codecs.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/mpc8610_hpcd.c |  236 +++++++++++++++++++++---------------------
 1 files changed, 117 insertions(+), 119 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 8813291..2cf7d95 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -40,13 +40,10 @@
 struct mpc8610_hpcd_data {
 	struct snd_soc_card soc_card;
 	struct ccsr_guts __iomem *guts;
-	unsigned int num_configs;
-	struct snd_soc_pcm_config configs[MAX_SSI];
-	struct mpc8610_hpcd_names {
-		char pcm_name[32];
-		char ssi_name[32];
-		char codec_name[32];
-	} names[MAX_SSI];
+	struct snd_soc_pcm_config pcm_config;
+	char pcm_name[32];
+	char ssi_name[32];
+	char codec_name[32];
 };
 
 /**
@@ -91,29 +88,25 @@ static int mpc8610_hpcd_audio_init(struct snd_soc_card *soc_card)
 {
 	struct snd_soc_codec *codec;
 	struct mpc8610_hpcd_data *soc_card_data = soc_card->private_data;
-	unsigned int i;
 	int ret = 0;
 
-	for (i = 0; i < soc_card_data->num_configs; i++) {
-		codec = snd_soc_card_get_codec(soc_card,
-			soc_card_data->names[i].codec_name,
-			soc_card_data->configs[i].codec_num);
+	codec = snd_soc_card_get_codec(soc_card, soc_card_data->codec_name,
+		soc_card_data->pcm_config.codec_num);
 
-		if (!codec) {
-			dev_err(soc_card->dev, "could not find codec\n");
-			return -ENODEV;
-		}
+	if (!codec) {
+		dev_err(soc_card->dev, "could not find codec\n");
+		return -ENODEV;
+	}
 
-		/* The codec driver should have called
-		 * snd_soc_card_config_codec() by now.
-		 */
-		ret = snd_soc_card_init_codec(codec, soc_card);
-		if (ret < 0) {
-			dev_err(soc_card->dev,
-				"could not initialize codec %s-%u\n",
-				codec->name, codec->num);
-			continue;
-		}
+	/* The codec driver should have called
+	 * snd_soc_card_config_codec() by now.
+	 */
+	ret = snd_soc_card_init_codec(codec, soc_card);
+	if (ret < 0) {
+		dev_err(soc_card->dev,
+			"could not initialize codec %s-%u\n",
+			codec->name, codec->num);
+		return -ENODEV;
 	}
 
 	return 0;
@@ -316,10 +309,16 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	struct snd_soc_card *soc_card = NULL;
 	struct mpc8610_hpcd_data *soc_card_data;
 	struct device_node *guts_np = NULL;
-	struct device_node *ssi_np;
-	unsigned int ssi = 0;
+	struct device_node *ssi_np =
+		(struct device_node *)platform_get_resource(pdev, 0, 0)->start;
 	int ret = -ENODEV;
 
+	struct device_node *codec_np;
+	const char *compat;
+	const char *p;
+	unsigned int bus;
+	unsigned int address;
+
 	soc_card_data = kzalloc(sizeof(struct mpc8610_hpcd_data), GFP_KERNEL);
 	if (!soc_card_data) {
 		dev_err(&pdev->dev, "could not allocate card structure\n");
@@ -353,100 +352,68 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	soc_card->private_data = soc_card_data;
 	soc_card->dev = &pdev->dev;
 
-	/* Scan the device tree for SSI nodes.  Each one we find that has a
-	 * codec is registered.  Remember, we only support MAX_SSI of these.
-	 */
-	for_each_compatible_node(ssi_np, NULL, "fsl,mpc8610-ssi") {
-		struct snd_soc_pcm_config *pcm_config;
-		struct mpc8610_hpcd_names *name;
-		struct device_node *codec_np;
-		const char *compat;
-		const char *p;
-		unsigned int bus;
-		unsigned int address;
-		int i;
-
-		name = &soc_card_data->names[ssi];
-		pcm_config = &soc_card_data->configs[ssi];
-
-		pcm_config->name = name->pcm_name;
-		pcm_config->codec = name->codec_name;
-		pcm_config->codec_dai = name->codec_name;
-		pcm_config->platform = "fsl-elo";
-		pcm_config->cpu_dai = name->ssi_name;
-		pcm_config->ops = &mpc8610_hpcd_ops;
-		pcm_config->playback = 1;
-		pcm_config->capture = 1;
-
-		sprintf(name->pcm_name, "MPC8610HPCD.%u", ssi);
-
-		/* Get the SSI name */
-		i = of_get_integer(ssi_np, "cell-index");
-		if (i < 0) {
-			dev_err(soc_card->dev, "no cell-index for %s\n",
-				ssi_np->full_name);
-			continue;
-		}
-		sprintf(name->ssi_name, "ssi%u", i);
-
-		/* Get the codec name and ID */
-		codec_np = find_codec(ssi_np);
-		if (!codec_np) {
-			dev_err(soc_card->dev, "missing codec node for %s\n",
-				ssi_np->full_name);
-			continue;
-		}
-
-		/* We assume that the first (or only) string in the compatible
-		 * field is the one that counts.
-		 */
-		compat = of_get_property(codec_np, "compatible", NULL);
-		if (!compat) {
-			dev_err(soc_card->dev,
-				"missing compatible property for %s\n",
-				ssi_np->full_name);
-			continue;
-		}
-
-		/* We only care about the part after the comma */
-		p = strchr(compat, ',');
-		strcpy(name->codec_name, p ? p + 1 : compat);
-
-		/* Now determine the I2C bus and address of the codec */
-		bus = of_get_integer(of_get_parent(codec_np), "cell-index");
-		if (bus < 0) {
-			dev_err(soc_card->dev,
-				"cannot determine I2C bus number for %s\n",
-				codec_np->full_name);
-			continue;
-		}
+	soc_card_data->pcm_config.name = soc_card_data->pcm_name;
+	soc_card_data->pcm_config.codec = soc_card_data->codec_name;
+	soc_card_data->pcm_config.codec_dai = soc_card_data->codec_name;
+	soc_card_data->pcm_config.platform = "fsl-elo";
+	soc_card_data->pcm_config.cpu_dai = soc_card_data->ssi_name;
+	soc_card_data->pcm_config.ops = &mpc8610_hpcd_ops;
+	soc_card_data->pcm_config.playback = 1;
+	soc_card_data->pcm_config.capture = 1;
+
+	sprintf(soc_card_data->pcm_name, "MPC8610HPCD.%u", pdev->id);
+
+	/* Get the SSI name */
+	sprintf(soc_card_data->ssi_name, "ssi%u", pdev->id);
+
+	/* Get the codec name and ID */
+	codec_np = find_codec(ssi_np);
+	if (!codec_np) {
+		dev_err(soc_card->dev, "missing codec node for %s\n",
+			ssi_np->full_name);
+		goto error;
+	}
 
-		address = of_get_integer(codec_np, "reg");
-		if (address < 0) {
-			dev_err(soc_card->dev,
-				"cannot determine I2C address for %s\n",
-				codec_np->full_name);
-			continue;
-		}
+	/* We assume that the first (or only) string in the compatible
+	 * field is the one that counts.
+	 */
+	compat = of_get_property(codec_np, "compatible", NULL);
+	if (!compat) {
+		dev_err(soc_card->dev,
+			"missing compatible property for %s\n",
+			ssi_np->full_name);
+		goto error;
+	}
 
-		pcm_config->codec_num = bus << 16 | address;
+	/* We only care about the part after the comma */
+	p = strchr(compat, ',');
+	strcpy(soc_card_data->codec_name, p ? p + 1 : compat);
 
-		dev_dbg(soc_card->dev, "registering cpu %s with codec %s-%x\n",
-			pcm_config->cpu_dai, pcm_config->codec,
-			pcm_config->codec_num);
+	/* Now determine the I2C bus and address of the codec */
+	bus = of_get_integer(of_get_parent(codec_np), "cell-index");
+	if (bus < 0) {
+		dev_err(soc_card->dev,
+			"cannot determine I2C bus number for %s\n",
+			codec_np->full_name);
+		goto error;
+	}
 
-		if (++ssi == MAX_SSI)
-			break;
+	address = of_get_integer(codec_np, "reg");
+	if (address < 0) {
+		dev_err(soc_card->dev,
+			"cannot determine I2C address for %s\n",
+			codec_np->full_name);
+		goto error;
 	}
 
-	ret = snd_soc_card_create_pcms(soc_card, soc_card_data->configs, ssi);
+	soc_card_data->pcm_config.codec_num = bus << 16 | address;
+
+	ret = snd_soc_card_create_pcms(soc_card, &soc_card_data->pcm_config, 1);
 	if (ret) {
 		dev_err(soc_card->dev, "could not create PCMs\n");
 		return ret;
 	}
 
-	soc_card_data->num_configs = ssi;
-
 	platform_set_drvdata(pdev, soc_card);
 
 	ret = snd_soc_card_register(soc_card);
@@ -493,7 +460,8 @@ static struct platform_driver mpc8610_hpcd_driver = {
 	.remove 	= __devexit_p(mpc8610_hpcd_remove),
 };
 
-static struct platform_device *pdev;
+/* Platform device pointers for each SSI  */
+static struct platform_device *pdev[MAX_SSI];
 
 /**
  * mpc8610_hpcd_init: fabric driver initialization.
@@ -502,6 +470,9 @@ static struct platform_device *pdev;
  */
 static int __init mpc8610_hpcd_init(void)
 {
+	struct resource res;
+	struct device_node *ssi_np;
+	unsigned int i = 0;
 	int ret;
 
 	pr_info("Freescale MPC8610 HPCD ASoC fabric driver\n");
@@ -512,12 +483,35 @@ static int __init mpc8610_hpcd_init(void)
 		return ret;
 	}
 
-	pdev = platform_device_register_simple(mpc8610_hpcd_driver.driver.name,
-		0, NULL, 0);
-	if (!pdev) {
-		pr_err("mpc8610-hpcd: could not register device\n");
-		platform_driver_unregister(&mpc8610_hpcd_driver);
-		return ret;
+	memset(pdev, 0, sizeof(pdev));
+
+	memset(&res, 0, sizeof(res));
+	res.name = "ssi";
+
+	for_each_compatible_node(ssi_np, NULL, "fsl,mpc8610-ssi") {
+		int id;
+
+		id = of_get_integer(ssi_np, "cell-index");
+		if (id < 0) {
+			pr_err("mpc8610-hpcd: no cell-index for %s\n",
+				ssi_np->full_name);
+			continue;
+		}
+		if (!find_codec(ssi_np))
+			/* No codec node? Skip it */
+			continue;
+
+		res.start = (resource_size_t) ssi_np;
+
+		pdev[i] = platform_device_register_simple(
+			mpc8610_hpcd_driver.driver.name, id, &res, 1);
+		if (!pdev[i]) {
+			pr_err("mpc8610-hpcd: could not register %s\n",
+				ssi_np->full_name);
+			continue;
+		}
+
+		i++;
 	}
 
 	return 0;
@@ -530,7 +524,11 @@ static int __init mpc8610_hpcd_init(void)
  */
 static void __exit mpc8610_hpcd_exit(void)
 {
-	platform_device_unregister(pdev);
+	unsigned int i;
+
+	for (i = 0; i < MAX_SSI; i++)
+		platform_device_unregister(pdev[i]);
+
 	platform_driver_unregister(&mpc8610_hpcd_driver);
 }
 
-- 
1.5.5
