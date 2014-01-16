From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: simplify the daifmt code
Date: Thu, 16 Jan 2014 11:12:18 +0800
Message-ID: <1389841938-17177-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A333265099
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 05:10:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

In the asoc_simple_card_parse_of() will parse the device node's CPU/CODEC
DAI commone fmts, and then in asoc_simple_card_sub_parse_of() will parse
the CPU/CODEC DAI's sub-node fmts, so we can combine the info->daifmt and
info->set.fmt in asoc_simple_card_sub_parse_of() not while just before
set_fmt().

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index b6014fe..0e2fbdd 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -16,15 +16,12 @@
 #include <sound/simple_card.h>
 
 static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
-				       struct asoc_simple_dai *set,
-				       unsigned int daifmt)
+				       struct asoc_simple_dai *set)
 {
 	int ret;
 
-	daifmt |= set->fmt;
-
-	if (daifmt) {
-		ret = snd_soc_dai_set_fmt(dai, daifmt);
+	if (set->fmt) {
+		ret = snd_soc_dai_set_fmt(dai, set->fmt);
 		if (ret && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "simple-card: set_fmt error\n");
 			return ret;
@@ -48,14 +45,13 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 				snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *codec = rtd->codec_dai;
 	struct snd_soc_dai *cpu = rtd->cpu_dai;
-	unsigned int daifmt = info->daifmt;
 	int ret;
 
-	ret = __asoc_simple_card_dai_init(codec, &info->codec_dai, daifmt);
+	ret = __asoc_simple_card_dai_init(codec, &info->codec_dai);
 	if (ret < 0)
 		return ret;
 
-	ret = __asoc_simple_card_dai_init(cpu, &info->cpu_dai, daifmt);
+	ret = __asoc_simple_card_dai_init(cpu, &info->cpu_dai);
 	if (ret < 0)
 		return ret;
 
@@ -64,6 +60,7 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 static int
 asoc_simple_card_sub_parse_of(struct device_node *np,
+			      unsigned int daifmt,
 			      struct asoc_simple_dai *dai,
 			      struct device_node **node)
 {
@@ -89,6 +86,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	 * and specific "format" if it has
 	 */
 	dai->fmt = snd_soc_of_parse_daifmt(np, NULL);
+	dai->fmt |= daifmt;
 
 	/*
 	 * dai->sysclk come from
@@ -149,7 +147,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	ret = -EINVAL;
 	np = of_get_child_by_name(node, "simple-audio-card,cpu");
 	if (np)
-		ret = asoc_simple_card_sub_parse_of(np,
+		ret = asoc_simple_card_sub_parse_of(np, info->daifmt,
 						  &info->cpu_dai,
 						  of_cpu);
 	if (ret < 0)
@@ -159,7 +157,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	ret = -EINVAL;
 	np = of_get_child_by_name(node, "simple-audio-card,codec");
 	if (np)
-		ret = asoc_simple_card_sub_parse_of(np,
+		ret = asoc_simple_card_sub_parse_of(np, info->daifmt,
 						  &info->codec_dai,
 						  of_codec);
 	if (ret < 0)
-- 
1.8.4
