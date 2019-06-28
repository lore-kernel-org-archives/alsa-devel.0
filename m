From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tegra: tegra_rt5677: consider
	CPU-Platform possibility" to the asoc tree
Date: Fri, 28 Jun 2019 17:56:24 +0100 (BST)
Message-ID: <20190628165624.9A967440049@finisterre.sirena.org.uk>
References: <871rzev5vx.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92E89F89731
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2019 18:56:25 +0200 (CEST)
In-Reply-To: <871rzev5vx.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tegra: tegra_rt5677: consider CPU-Platform possibility

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 1dd2e91b08d52eced666e1c1343960ac6374c6a7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Jun 2019 10:48:53 +0900
Subject: [PATCH] ASoC: tegra: tegra_rt5677: consider CPU-Platform possibility

commit d035d13b2277 ("ASoC: tegra: tegra_rt5677: don't select unnecessary
Platform")

Current ALSA SoC avoid to add duplicate component to rtd,
and this driver was selecting CPU component as Platform component.
Thus, above patch removed Platform settings from this driver,
because it assumed these are same component.

But, some CPU driver is using generic DMAEngine, in such case, both
CPU component and Platform component will have same of_node/name.
In other words, there are some components which are different but
have same of_node/name.

In such case, Card driver definitely need to select Platform even
though it is same as CPU.
It is depends on CPU driver, but is difficult to know it from Card driver.
This patch reverts above patch.

Fixes: commit d035d13b2277 ("ASoC: tegra: tegra_rt5677: don't select unnecessary Platform")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra_rt5677.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_rt5677.c b/sound/soc/tegra/tegra_rt5677.c
index 738bdf876b13..81cb6cc6236e 100644
--- a/sound/soc/tegra/tegra_rt5677.c
+++ b/sound/soc/tegra/tegra_rt5677.c
@@ -160,7 +160,8 @@ static int tegra_rt5677_asoc_init(struct snd_soc_pcm_runtime *rtd)
 
 SND_SOC_DAILINK_DEFS(pcm,
 	DAILINK_COMP_ARRAY(COMP_EMPTY()),
-	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "rt5677-aif1")));
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "rt5677-aif1")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 static struct snd_soc_dai_link tegra_rt5677_dai = {
 	.name = "RT5677",
@@ -259,6 +260,7 @@ static int tegra_rt5677_probe(struct platform_device *pdev)
 		ret = -EINVAL;
 		goto err_put_codec_of_node;
 	}
+	tegra_rt5677_dai.platforms->of_node = tegra_rt5677_dai.cpus->of_node;
 
 	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
 	if (ret)
@@ -278,6 +280,7 @@ static int tegra_rt5677_probe(struct platform_device *pdev)
 err_put_cpu_of_node:
 	of_node_put(tegra_rt5677_dai.cpus->of_node);
 	tegra_rt5677_dai.cpus->of_node = NULL;
+	tegra_rt5677_dai.platforms->of_node = NULL;
 err_put_codec_of_node:
 	of_node_put(tegra_rt5677_dai.codecs->of_node);
 	tegra_rt5677_dai.codecs->of_node = NULL;
@@ -294,6 +297,7 @@ static int tegra_rt5677_remove(struct platform_device *pdev)
 
 	tegra_asoc_utils_fini(&machine->util_data);
 
+	tegra_rt5677_dai.platforms->of_node = NULL;
 	of_node_put(tegra_rt5677_dai.codecs->of_node);
 	tegra_rt5677_dai.codecs->of_node = NULL;
 	of_node_put(tegra_rt5677_dai.cpus->of_node);
-- 
2.20.1
