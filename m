From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: remove snd_link and
	snd_card from struct asoc_xx_info
Date: Fri, 10 Jan 2014 20:55:57 +0800
Message-ID: <1389358557-2214-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 by alsa0.perex.cz (Postfix) with ESMTP id DC3E2261A22
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 14:52:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Whether the dt is used or not, almost all the simple card information
for the DAI link and sound card are initialized in the simple card driver.

And for the platform caller, the snd_link and snd_card are of no use, so
remove it from struct asoc_simple_card_info, and let them to be the simple
card driver's global data.

This is also fix one bug about writing to the platform data directly, for
it should be constant.

And now only one DAI link is supported for simple card.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---

This patch maybe not very perfect, such as supporting many DAI links, etc.
And there still need followed patches to fulfil these.





 include/sound/simple_card.h     |  4 ---
 sound/soc/generic/simple-card.c | 54 +++++++++++++++++++++++------------------
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index 6c74527..e1ac996 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -29,10 +29,6 @@ struct asoc_simple_card_info {
 	unsigned int daifmt;
 	struct asoc_simple_dai cpu_dai;
 	struct asoc_simple_dai codec_dai;
-
-	/* used in simple-card.c */
-	struct snd_soc_dai_link snd_link;
-	struct snd_soc_card snd_card;
 };
 
 #endif /* __SIMPLE_CARD_H */
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index dbd93cc..94dc743 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -14,9 +14,6 @@
 #include <linux/module.h>
 #include <sound/simple_card.h>
 
-#define asoc_simple_get_card_info(p) \
-	container_of(p->dai_link, struct asoc_simple_card_info, snd_link)
-
 static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 				       struct asoc_simple_dai *set,
 				       unsigned int daifmt)
@@ -41,7 +38,8 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 
 static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct asoc_simple_card_info *info = asoc_simple_get_card_info(rtd);
+	struct asoc_simple_card_info *info =
+				snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *codec = rtd->codec_dai;
 	struct snd_soc_dai *cpu = rtd->cpu_dai;
 	unsigned int daifmt = info->daifmt;
@@ -58,6 +56,16 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static struct snd_soc_dai_link simple_dai_link = {
+	.init = asoc_simple_card_dai_init,
+};
+
+static struct snd_soc_card simple_snd_card = {
+	.owner = THIS_MODULE,
+	.dai_link = &simple_dai_link,
+	.num_links = 1,
+};
+
 static int
 asoc_simple_card_sub_parse_of(struct device_node *np,
 			      struct asoc_simple_dai *dai,
@@ -144,7 +152,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 
 	/* DAPM routes */
 	if (of_property_read_bool(node, "simple-audio-card,routing")) {
-		ret = snd_soc_of_parse_audio_routing(&info->snd_card,
+		ret = snd_soc_of_parse_audio_routing(&simple_snd_card,
 					"simple-audio-card,routing");
 		if (ret)
 			return ret;
@@ -213,7 +221,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		cinfo = devm_kzalloc(dev, sizeof(*cinfo), GFP_KERNEL);
 		if (cinfo) {
 			int ret;
-			cinfo->snd_card.dev = &pdev->dev;
+			simple_snd_card.dev = dev;
 			ret = asoc_simple_card_parse_of(np, cinfo, dev,
 							&of_cpu,
 							&of_codec,
@@ -233,7 +241,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
-		cinfo->snd_card.dev = &pdev->dev;
+		simple_snd_card.dev = dev;
 	}
 
 	if (!cinfo->name	||
@@ -247,28 +255,26 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * init snd_soc_dai_link
+	 * init simple_dai_link
 	 */
-	cinfo->snd_link.name		= cinfo->name;
-	cinfo->snd_link.stream_name	= cinfo->name;
-	cinfo->snd_link.cpu_dai_name	= cinfo->cpu_dai.name;
-	cinfo->snd_link.platform_name	= cinfo->platform;
-	cinfo->snd_link.codec_name	= cinfo->codec;
-	cinfo->snd_link.codec_dai_name	= cinfo->codec_dai.name;
-	cinfo->snd_link.cpu_of_node	= of_cpu;
-	cinfo->snd_link.codec_of_node	= of_codec;
-	cinfo->snd_link.platform_of_node = of_platform;
-	cinfo->snd_link.init		= asoc_simple_card_dai_init;
+	simple_dai_link.name			= cinfo->name;
+	simple_dai_link.stream_name		= cinfo->name;
+	simple_dai_link.cpu_dai_name		= cinfo->cpu_dai.name;
+	simple_dai_link.platform_name		= cinfo->platform;
+	simple_dai_link.codec_name		= cinfo->codec;
+	simple_dai_link.codec_dai_name		= cinfo->codec_dai.name;
+	simple_dai_link.cpu_of_node		= of_cpu;
+	simple_dai_link.codec_of_node		= of_codec;
+	simple_dai_link.platform_of_node	= of_platform;
 
 	/*
-	 * init snd_soc_card
+	 * init simple_snd_card
 	 */
-	cinfo->snd_card.name		= cinfo->card;
-	cinfo->snd_card.owner		= THIS_MODULE;
-	cinfo->snd_card.dai_link	= &cinfo->snd_link;
-	cinfo->snd_card.num_links	= 1;
+	simple_snd_card.name			= cinfo->card;
+
+	snd_soc_card_set_drvdata(&simple_snd_card, cinfo);
 
-	return devm_snd_soc_register_card(&pdev->dev, &cinfo->snd_card);
+	return devm_snd_soc_register_card(dev, &simple_snd_card);
 }
 
 static const struct of_device_id asoc_simple_of_match[] = {
-- 
1.8.4
