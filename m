From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: use snd_soc_card_set/get_drvdata
Date: Mon, 13 Jan 2014 17:08:08 +0800
Message-ID: <1389604088-16536-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Remove asoc_simple_get_card_info macro and use snd_soc_card_set_drvdata
and snd_soc_card_get_drvdata instead.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index dbd93cc..c025b6d 100644
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
@@ -268,6 +266,8 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	cinfo->snd_card.dai_link	= &cinfo->snd_link;
 	cinfo->snd_card.num_links	= 1;
 
+	snd_soc_card_set_drvdata(&cinfo->snd_card, cinfo);
+
 	return devm_snd_soc_register_card(&pdev->dev, &cinfo->snd_card);
 }
 
-- 
1.8.4
