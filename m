From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: don't select DPCM via
	simple-audio-card" to the asoc tree
Date: Thu,  4 Apr 2019 15:17:06 +0700 (+07)
Message-ID: <20190404081706.6BB3C441D3C@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BC48F89756
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 10:17:10 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: don't select DPCM via simple-audio-card

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

>From 42bf029a55a9bb8036f1d738a28dba2f7ec1e79d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 4 Apr 2019 09:52:52 +0900
Subject: [PATCH] ASoC: simple-card: don't select DPCM via simple-audio-card

commit da215354eb55c ("ASoC: simple-card: merge simple-scu-card")
merged simple-scu-audio-card which can handle DPCM into
simple-audio-card.

By this patch, the judgement to select "normal sound card" or
"DPCM sound card" is based on its CPU/Codec DAI count.
But, because of it, existing "simple-audio-card" user who is
assuming "normal sound card" might select DPCM unintentionally.

To solve this issue, this patch allows "simple-audio-card" user
can select "normal sound card", and "simple-scu-audio-card" user
can select both "normal sound card" and "DPCM sound card".
This keeps compatibility collectry.

Fixes: da215354eb55c ("ASoC: simple-card: merge simple-scu-card")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 7147bba45a2a..34de32efc4c4 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -9,12 +9,15 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
 #include <sound/simple_card.h>
 #include <sound/soc-dai.h>
 #include <sound/soc.h>
 
+#define DPCM_SELECTABLE 1
+
 struct simple_priv {
 	struct snd_soc_card snd_card;
 	struct simple_dai_props {
@@ -441,6 +444,7 @@ static int simple_for_each_link(struct simple_priv *priv,
 	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *top = dev->of_node;
 	struct device_node *node;
+	uintptr_t dpcm_selectable = (uintptr_t)of_device_get_match_data(dev);
 	bool is_top = 0;
 	int ret = 0;
 
@@ -480,8 +484,9 @@ static int simple_for_each_link(struct simple_priv *priv,
 			 * if it has many CPUs,
 			 * or has convert-xxx property
 			 */
-			if (num > 2 ||
-			    adata.convert_rate || adata.convert_channels)
+			if (dpcm_selectable &&
+			    (num > 2 ||
+			     adata.convert_rate || adata.convert_channels))
 				ret = func_dpcm(priv, np, codec, li, is_top);
 			/* else normal sound */
 			else
@@ -822,7 +827,8 @@ static int simple_remove(struct platform_device *pdev)
 
 static const struct of_device_id simple_of_match[] = {
 	{ .compatible = "simple-audio-card", },
-	{ .compatible = "simple-scu-audio-card", },
+	{ .compatible = "simple-scu-audio-card",
+	  .data = (void *)DPCM_SELECTABLE },
 	{},
 };
 MODULE_DEVICE_TABLE(of, simple_of_match);
-- 
2.20.1
