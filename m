From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: Remove support for setting
	differing DAI formats" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:42 +0000
Message-ID: <E1a9twk-0006Da-LJ@debutante>
References: <87h9jhiyhd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6743E2665B1
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:47 +0100 (CET)
In-Reply-To: <87h9jhiyhd.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: Remove support for setting differing DAI formats

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ae638b725ee00afe3253e30df617a5531ea30ea2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Dec 2015 02:48:58 +0000
Subject: [PATCH] ASoC: rsrc-card: Remove support for setting differing DAI
 formats

1efb53a220 ("ASoC: simple-card: Remove support for setting differing
DAI formats") removed set_fmt support from simple-card.
rsrc-card follows same style, because it is based on simple-card.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index 3c308e2d696e..9f522ba881fa 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -48,7 +48,6 @@ MODULE_DEVICE_TABLE(of, rsrc_card_of_match);
 
 #define DAI_NAME_NUM	32
 struct rsrc_card_dai {
-	unsigned int fmt;
 	unsigned int sysclk;
 	unsigned int tx_slot_mask;
 	unsigned int rx_slot_mask;
@@ -114,14 +113,6 @@ static int rsrc_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 				rtd->cpu_dai :
 				rtd->codec_dai;
 
-	if (dai_props->fmt) {
-		ret = snd_soc_dai_set_fmt(dai, dai_props->fmt);
-		if (ret && ret != -ENOTSUPP) {
-			dev_err(dai->dev, "set_fmt error\n");
-			goto err;
-		}
-	}
-
 	if (dai_props->sysclk) {
 		ret = snd_soc_dai_set_sysclk(dai, 0, dai_props->sysclk, 0);
 		if (ret && ret != -ENOTSUPP) {
@@ -168,7 +159,7 @@ static int rsrc_card_parse_daifmt(struct device_node *node,
 				  struct rsrc_card_priv *priv,
 				  int idx, bool is_fe)
 {
-	struct rsrc_card_dai *dai_props = rsrc_priv_to_props(priv, idx);
+	struct snd_soc_dai_link *dai_link = rsrc_priv_to_link(priv, idx);
 	struct device_node *bitclkmaster = NULL;
 	struct device_node *framemaster = NULL;
 	struct device_node *codec = is_fe ? NULL : np;
@@ -188,7 +179,7 @@ static int rsrc_card_parse_daifmt(struct device_node *node,
 		daifmt |= (codec == framemaster) ?
 			SND_SOC_DAIFMT_CBS_CFM : SND_SOC_DAIFMT_CBS_CFS;
 
-	dai_props->fmt	= daifmt;
+	dai_link->dai_fmt = daifmt;
 
 	of_node_put(bitclkmaster);
 	of_node_put(framemaster);
@@ -340,6 +331,7 @@ static int rsrc_card_dai_link_of(struct device_node *node,
 				 int idx)
 {
 	struct device *dev = rsrc_priv_to_dev(priv);
+	struct snd_soc_dai_link *dai_link = rsrc_priv_to_link(priv, idx);
 	struct rsrc_card_dai *dai_props = rsrc_priv_to_props(priv, idx);
 	bool is_fe = false;
 	int ret;
@@ -361,7 +353,7 @@ static int rsrc_card_dai_link_of(struct device_node *node,
 
 	dev_dbg(dev, "\t%s / %04x / %d\n",
 		dai_props->dai_name,
-		dai_props->fmt,
+		dai_link->dai_fmt,
 		dai_props->sysclk);
 
 	return ret;
-- 
2.6.2
