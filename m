From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH] ASoC: simple-card: overwrite DAIFMT_MASTER of cpu_dai->fmt
Date: Tue, 11 Mar 2014 20:54:32 +0800
Message-ID: <1394542472-16580-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, moinejf@free.fr, Li.Xiubo@freescale.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The current simple-card driver separates the daimft for cpu_dai and codec_dai.
So we might get different values for them (0x4003 and 0x1003 for example):

asoc-simple-card sound-cs42888.12: cpu : 2024000.esai / 4003 / 132000000
asoc-simple-card sound-cs42888.12: codec : cs42888 / 1003 / 24576000
asoc-simple-card sound-cs42888.12: cs42888 <-> 2024000.esai mapping ok

It's pretty fair to do it for DAIFMT_INV since two dais might have differnt
definitions in their drivers even though it'd be better to keep it same if
we could.

But for DAIFMT_MASTER bit, we should keep them identical. Otherwise, it'll
make one of dai work in an incorrect mode.

Thus this patch fixes it by overwriting the DAIFMT_MASTER bit of cpu_dai->fmt
with the one of codec_dai->fmt since we defined DAIFMT_MASTER basing on CODEC
at the first place.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/generic/simple-card.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 5dd4769..f9a3c8a 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -157,6 +157,8 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 				     struct device *dev)
 {
 	struct snd_soc_dai_link *dai_link = priv->snd_card.dai_link;
+	struct asoc_simple_dai *codec_dai = &priv->codec_dai;
+	struct asoc_simple_dai *cpu_dai = &priv->cpu_dai;
 	struct device_node *np;
 	char *name;
 	int ret;
@@ -189,7 +191,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	np = of_get_child_by_name(node, "simple-audio-card,cpu");
 	if (np)
 		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
-						  &priv->cpu_dai,
+						  cpu_dai,
 						  &dai_link->cpu_of_node,
 						  &dai_link->cpu_dai_name);
 	if (ret < 0)
@@ -200,12 +202,16 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	np = of_get_child_by_name(node, "simple-audio-card,codec");
 	if (np)
 		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
-						  &priv->codec_dai,
+						  codec_dai,
 						  &dai_link->codec_of_node,
 						  &dai_link->codec_dai_name);
 	if (ret < 0)
 		return ret;
 
+	/* overwrite DAIFMT_MASTER of cpu_dai since it's based on CODEC */
+	cpu_dai->fmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
+	cpu_dai->fmt |= codec_dai->fmt & SND_SOC_DAIFMT_MASTER_MASK;
+
 	if (!dai_link->cpu_dai_name || !dai_link->codec_dai_name)
 		return -EINVAL;
 
@@ -227,12 +233,12 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	dev_dbg(dev, "platform : %04x\n", priv->daifmt);
 	dev_dbg(dev, "cpu : %s / %04x / %d\n",
 		dai_link->cpu_dai_name,
-		priv->cpu_dai.fmt,
-		priv->cpu_dai.sysclk);
+		cpu_dai->fmt,
+		cpu_dai->sysclk);
 	dev_dbg(dev, "codec : %s / %04x / %d\n",
 		dai_link->codec_dai_name,
-		priv->codec_dai.fmt,
-		priv->codec_dai.sysclk);
+		codec_dai->fmt,
+		codec_dai->sysclk);
 
 	/*
 	 * soc_bind_dai_link() will check cpu name
-- 
1.8.4
