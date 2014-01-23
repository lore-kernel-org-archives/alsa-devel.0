From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH Resend 3/8] ASoC: simple-card: simplify the daifmt code
Date: Thu, 23 Jan 2014 13:02:45 +0800
Message-ID: <1390453370-29194-4-git-send-email-Li.Xiubo@freescale.com>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, shawn.guo@linaro.org, kuninori.morimoto.gx@renesas.com
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

In the asoc_simple_card_parse_of() will parse the device node's CPU/CODEC
DAI commone fmts, and then in asoc_simple_card_sub_parse_of() will parse
the CPU/CODEC DAI's sub-node fmts, so we can combine the info->daifmt and
info->set.fmt in asoc_simple_card_sub_parse_of() not while just before
_set_fmt().

And this will be more easy to add new functions, such as supporting
_set_tdm_slot(), etc.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 3b8c9a2..f38e56e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -24,15 +24,12 @@ struct simple_card_data {
 };
 
 static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
-				       struct asoc_simple_dai *set,
-				       unsigned int daifmt)
+				       struct asoc_simple_dai *set)
 {
 	int ret = 0;
 
-	daifmt |= set->fmt;
-
-	if (daifmt) {
-		ret = snd_soc_dai_set_fmt(dai, daifmt);
+	if (set->fmt) {
+		ret = snd_soc_dai_set_fmt(dai, set->fmt);
 		if (ret && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "simple-card: set_fmt error\n");
 			return ret;
@@ -56,14 +53,13 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 				snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *codec = rtd->codec_dai;
 	struct snd_soc_dai *cpu = rtd->cpu_dai;
-	unsigned int daifmt = priv->daifmt;
 	int ret;
 
-	ret = __asoc_simple_card_dai_init(codec, &priv->codec_dai, daifmt);
+	ret = __asoc_simple_card_dai_init(codec, &priv->codec_dai);
 	if (ret < 0)
 		return ret;
 
-	ret = __asoc_simple_card_dai_init(cpu, &priv->cpu_dai, daifmt);
+	ret = __asoc_simple_card_dai_init(cpu, &priv->cpu_dai);
 	if (ret < 0)
 		return ret;
 
@@ -72,6 +68,7 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 static int
 asoc_simple_card_sub_parse_of(struct device_node *np,
+			      unsigned int daifmt,
 			      struct asoc_simple_dai *dai,
 			      const struct device_node **p_node,
 			      const char **name)
@@ -100,6 +97,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	 * and specific "format" if it has
 	 */
 	dai->fmt = snd_soc_of_parse_daifmt(np, NULL);
+	dai->fmt |= daifmt;
 
 	/*
 	 * dai->sysclk come from
@@ -158,7 +156,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	ret = -EINVAL;
 	np = of_get_child_by_name(node, "simple-audio-card,cpu");
 	if (np)
-		ret = asoc_simple_card_sub_parse_of(np,
+		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
 						  &priv->cpu_dai,
 						  &dai_link->cpu_of_node,
 						  &dai_link->cpu_dai_name);
@@ -169,7 +167,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	ret = -EINVAL;
 	np = of_get_child_by_name(node, "simple-audio-card,codec");
 	if (np)
-		ret = asoc_simple_card_sub_parse_of(np,
+		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
 						  &priv->codec_dai,
 						  &dai_link->codec_of_node,
 						  &dai_link->codec_dai_name);
-- 
1.8.4
