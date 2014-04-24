From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 3/3] ASoC: simple-card: Improve coding style
Date: Thu, 24 Apr 2014 19:14:00 +0800
Message-ID: <8270833b6e3d1d2b6c4d20397c33b3cd645e8e38.1398337861.git.Guangyu.Chen@freescale.com>
References: <cover.1398337861.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 525F2265253
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 13:12:30 +0200 (CEST)
In-Reply-To: <cover.1398337861.git.Guangyu.Chen@freescale.com>
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
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, lgirdwood@gmail.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Improve indentation and space.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/generic/simple-card.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index c091557..98f97e5 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -66,8 +66,7 @@ err:
 
 static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct simple_card_data *priv =
-				snd_soc_card_get_drvdata(rtd->card);
+	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *codec = rtd->codec_dai;
 	struct snd_soc_dai *cpu = rtd->cpu_dai;
 	struct simple_dai_props *dai_props;
@@ -177,7 +176,7 @@ static int simple_card_dai_link_of(struct device_node *node,
 		goto dai_link_of_err;
 
 	dai_props->cpu_dai.fmt = daifmt;
-	switch (((np == bitclkmaster)<<4)|(np == framemaster)) {
+	switch (((np == bitclkmaster) << 4) | (np == framemaster)) {
 	case 0x11:
 		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBS_CFS;
 		break;
@@ -218,7 +217,7 @@ static int simple_card_dai_link_of(struct device_node *node,
 			(daifmt & ~SND_SOC_DAIFMT_CLOCK_MASK);
 	} else {
 		dai_props->codec_dai.fmt = daifmt;
-		switch (((np == bitclkmaster)<<4)|(np == framemaster)) {
+		switch (((np == bitclkmaster) << 4) | (np == framemaster)) {
 		case 0x11:
 			dai_props->codec_dai.fmt |= SND_SOC_DAIFMT_CBM_CFM;
 			break;
@@ -235,8 +234,8 @@ static int simple_card_dai_link_of(struct device_node *node,
 	}
 
 	if (!dai_link->cpu_dai_name || !dai_link->codec_dai_name) {
-			ret = -EINVAL;
-			goto dai_link_of_err;
+		ret = -EINVAL;
+		goto dai_link_of_err;
 	}
 
 	/* simple-card assumes platform == cpu */
@@ -417,10 +416,10 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
-		if (!cinfo->name	||
-		    !cinfo->codec_dai.name	||
-		    !cinfo->codec	||
-		    !cinfo->platform	||
+		if (!cinfo->name ||
+		    !cinfo->codec_dai.name ||
+		    !cinfo->codec ||
+		    !cinfo->platform ||
 		    !cinfo->cpu_dai.name) {
 			dev_err(dev, "insufficient asoc_simple_card_info settings\n");
 			return -EINVAL;
@@ -464,11 +463,11 @@ MODULE_DEVICE_TABLE(of, asoc_simple_of_match);
 
 static struct platform_driver asoc_simple_card = {
 	.driver = {
-		.name	= "asoc-simple-card",
+		.name = "asoc-simple-card",
 		.owner = THIS_MODULE,
 		.of_match_table = asoc_simple_of_match,
 	},
-	.probe		= asoc_simple_card_probe,
+	.probe = asoc_simple_card_probe,
 };
 
 module_platform_driver(asoc_simple_card);
-- 
1.8.4
