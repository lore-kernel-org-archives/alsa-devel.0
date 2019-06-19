From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tegra: tegra_sgtl5000: don't select
	unnecessary Platform" to the asoc tree
Date: Wed, 19 Jun 2019 13:12:00 +0100 (BST)
Message-ID: <20190619121200.8B1A3440046@finisterre.sirena.org.uk>
References: <87sgs6tlvs.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D35FDF89735
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 14:12:01 +0200 (CEST)
In-Reply-To: <87sgs6tlvs.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: tegra: tegra_sgtl5000: don't select unnecessary Platform

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

>From cee1cf3f9f9ed7b5fecfcd194cbb7e3718d8da5f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Jun 2019 10:18:48 +0900
Subject: [PATCH] ASoC: tegra: tegra_sgtl5000: don't select unnecessary
 Platform

ALSA SoC is now supporting "no Platform". Sound card doesn't need to
select "CPU component" as "Platform" anymore if it doesn't need
special Platform.
This patch removes such settings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra_sgtl5000.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/tegra/tegra_sgtl5000.c b/sound/soc/tegra/tegra_sgtl5000.c
index c5d45a6147bd..2a9e1ceaa574 100644
--- a/sound/soc/tegra/tegra_sgtl5000.c
+++ b/sound/soc/tegra/tegra_sgtl5000.c
@@ -94,8 +94,7 @@ static const struct snd_soc_dapm_widget tegra_sgtl5000_dapm_widgets[] = {
 
 SND_SOC_DAILINK_DEFS(hifi,
 	DAILINK_COMP_ARRAY(COMP_EMPTY()),
-	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "sgtl5000")),
-	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "sgtl5000")));
 
 static struct snd_soc_dai_link tegra_sgtl5000_dai = {
 	.name = "sgtl5000",
@@ -157,8 +156,6 @@ static int tegra_sgtl5000_driver_probe(struct platform_device *pdev)
 		goto err_put_codec_of_node;
 	}
 
-	tegra_sgtl5000_dai.platforms->of_node = tegra_sgtl5000_dai.cpus->of_node;
-
 	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
 	if (ret)
 		goto err_put_cpu_of_node;
@@ -177,7 +174,6 @@ static int tegra_sgtl5000_driver_probe(struct platform_device *pdev)
 err_put_cpu_of_node:
 	of_node_put(tegra_sgtl5000_dai.cpus->of_node);
 	tegra_sgtl5000_dai.cpus->of_node = NULL;
-	tegra_sgtl5000_dai.platforms->of_node = NULL;
 err_put_codec_of_node:
 	of_node_put(tegra_sgtl5000_dai.codecs->of_node);
 	tegra_sgtl5000_dai.codecs->of_node = NULL;
@@ -197,7 +193,6 @@ static int tegra_sgtl5000_driver_remove(struct platform_device *pdev)
 
 	of_node_put(tegra_sgtl5000_dai.cpus->of_node);
 	tegra_sgtl5000_dai.cpus->of_node = NULL;
-	tegra_sgtl5000_dai.platforms->of_node = NULL;
 	of_node_put(tegra_sgtl5000_dai.codecs->of_node);
 	tegra_sgtl5000_dai.codecs->of_node = NULL;
 
-- 
2.20.1
