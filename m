From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Convert to using %pOFn instead of
	device_node.name" to the asoc tree
Date: Tue, 28 Aug 2018 21:49:23 +0100 (BST)
Message-ID: <20180828204923.9289244007A@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 57F9F26781A
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 22:49:37 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Convert to using %pOFn instead of device_node.name

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 5d585e1e756838d91144c3173323b96f5aa12874 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Tue, 28 Aug 2018 10:44:28 -0500
Subject: [PATCH] ASoC: Convert to using %pOFn instead of device_node.name

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c      | 2 +-
 sound/soc/fsl/fsl_utils.c     | 4 ++--
 sound/soc/meson/axg-card.c    | 2 +-
 sound/soc/stm/stm32_sai.c     | 2 +-
 sound/soc/stm/stm32_sai_sub.c | 7 +++----
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index c1d1d06783e5..57b484768a58 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -807,7 +807,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	esai_priv->pdev = pdev;
-	strncpy(esai_priv->name, np->name, sizeof(esai_priv->name) - 1);
+	snprintf(esai_priv->name, sizeof(esai_priv->name), "%pOFn", np);
 
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index 7f0fa4b52223..9981668ab590 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -57,8 +57,8 @@ int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
 		of_node_put(dma_channel_np);
 		return ret;
 	}
-	snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%s",
-		 (unsigned long long) res.start, dma_channel_np->name);
+	snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%pOFn",
+		 (unsigned long long) res.start, dma_channel_np);
 
 	iprop = of_get_property(dma_channel_np, "cell-index", NULL);
 	if (!iprop) {
diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 2914ba0d965b..b76a5f4f1785 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -478,7 +478,7 @@ static int axg_card_set_be_link(struct snd_soc_card *card,
 
 	ret = axg_card_set_link_name(card, link, "be");
 	if (ret)
-		dev_err(card->dev, "error setting %s link name\n", np->name);
+		dev_err(card->dev, "error setting %pOFn link name\n", np);
 
 	return ret;
 }
diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index f22654253c43..d597eba61992 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -104,7 +104,7 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 
 	if (!pdev) {
 		dev_err(&sai_client->pdev->dev,
-			"Device not found for node %s\n", np_provider->name);
+			"Device not found for node %pOFn\n", np_provider);
 		return -ENODEV;
 	}
 
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 06fba9650ac4..56a227e0bd71 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1124,16 +1124,15 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 	sai->sync = SAI_SYNC_NONE;
 	if (args.np) {
 		if (args.np == np) {
-			dev_err(&pdev->dev, "%s sync own reference\n",
-				np->name);
+			dev_err(&pdev->dev, "%pOFn sync own reference\n", np);
 			of_node_put(args.np);
 			return -EINVAL;
 		}
 
 		sai->np_sync_provider  = of_get_parent(args.np);
 		if (!sai->np_sync_provider) {
-			dev_err(&pdev->dev, "%s parent node not found\n",
-				np->name);
+			dev_err(&pdev->dev, "%pOFn parent node not found\n",
+				np);
 			of_node_put(args.np);
 			return -ENODEV;
 		}
-- 
2.18.0
