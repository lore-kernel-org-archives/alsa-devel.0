From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH 7/7] ASoC: fsl: register the wm9712-codec
Date: Thu, 13 Sep 2012 17:43:16 -0400
Message-ID: <1347572596-37540-8-git-send-email-emillbrandt@dekaresearch.com>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 23EA526533F
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 23:43:28 +0200 (CEST)
In-Reply-To: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anatolij Gustschin <agust@denx.de>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

The mpc5200-psc-ac97 driver does not enumerate attached ac97 devices, so
register the device here.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index 893e240..4b63ec8 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -22,6 +22,11 @@
 
 #define DRV_NAME "pcm030-audio-fabric"
 
+struct pcm030_audio_data {
+	struct snd_soc_card *card;
+	struct platform_device *codec_device;
+};
+
 static struct snd_soc_dai_link pcm030_fabric_dai[] = {
 {
 	.name = "AC97",
@@ -51,14 +56,22 @@ static int __init pcm030_fabric_probe(struct platform_device *op)
 	struct device_node *np = op->dev.of_node;
 	struct device_node *platform_np;
 	struct snd_soc_card *card = &pcm030_card;
+	struct pcm030_audio_data *pdata;
 	int ret;
 	int i;
 
 	if (!of_machine_is_compatible("phytec,pcm030"))
 		return -ENODEV;
 
+	pdata = devm_kzalloc(&op->dev, sizeof(struct pcm030_audio_data),
+			     GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
 	card->dev = &op->dev;
-	platform_set_drvdata(op, card);
+	platform_set_drvdata(op, pdata);
+
+	pdata->card = card;
 
 	platform_np = of_parse_phandle(np, "asoc-platform", 0);
 	if (!platform_np) {
@@ -69,6 +82,18 @@ static int __init pcm030_fabric_probe(struct platform_device *op)
 	for (i = 0; i < card->num_links; i++)
 		card->dai_link[i].platform_of_node = platform_np;
 
+	ret = request_module("snd-soc-wm9712");
+	if (ret)
+		dev_err(&op->dev, "request_module returned: %d\n", ret);
+
+	pdata->codec_device = platform_device_alloc("wm9712-codec", -1);
+	if (!pdata->codec_device)
+		dev_err(&op->dev, "platform_device_alloc() failed\n");
+
+	ret = platform_device_add(pdata->codec_device);
+	if (ret)
+		dev_err(&op->dev, "platform_device_add() failed: %d\n", ret);
+
 	ret = snd_soc_register_card(card);
 	if (ret)
 		dev_err(&op->dev, "snd_soc_register_card() failed: %d\n", ret);
@@ -78,10 +103,11 @@ static int __init pcm030_fabric_probe(struct platform_device *op)
 
 static int __devexit pcm030_fabric_remove(struct platform_device *op)
 {
-	struct snd_soc_card *card = platform_get_drvdata(op);
+	struct pcm030_audio_data *pdata = platform_get_drvdata(op);
 	int ret;
 
-	ret = snd_soc_unregister_card(card);
+	ret = snd_soc_unregister_card(pdata->card);
+	platform_device_unregister(pdata->codec_device);
 
 	return ret;
 }
-- 
1.7.2.5
