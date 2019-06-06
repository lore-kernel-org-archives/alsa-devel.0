From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tegra: tegra_wm9712: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:15 +0100 (BST)
Message-ID: <20190606212615.A9A93440046@finisterre.sirena.org.uk>
References: <87y32ffjgx.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5587CF89710
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:16 +0200 (CEST)
In-Reply-To: <87y32ffjgx.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: tegra: tegra_wm9712: use modern dai_link style

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

>From ec7687d9a10a40dfc34d2d8f546b63195eebdad3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:19:05 +0900
Subject: [PATCH] ASoC: tegra: tegra_wm9712: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra_wm9712.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/tegra/tegra_wm9712.c b/sound/soc/tegra/tegra_wm9712.c
index 864a3345972e..7526aee3a0e3 100644
--- a/sound/soc/tegra/tegra_wm9712.c
+++ b/sound/soc/tegra/tegra_wm9712.c
@@ -49,12 +49,16 @@ static int tegra_wm9712_init(struct snd_soc_pcm_runtime *rtd)
 	return snd_soc_dapm_force_enable_pin(&rtd->card->dapm, "Mic Bias");
 }
 
+SND_SOC_DAILINK_DEFS(hifi,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm9712-codec", "wm9712-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link tegra_wm9712_dai = {
 	.name = "AC97 HiFi",
 	.stream_name = "AC97 HiFi",
-	.codec_dai_name = "wm9712-hifi",
-	.codec_name = "wm9712-codec",
 	.init = tegra_wm9712_init,
+	SND_SOC_DAILINK_REG(hifi),
 };
 
 static struct snd_soc_card snd_soc_tegra_wm9712 = {
@@ -101,16 +105,16 @@ static int tegra_wm9712_driver_probe(struct platform_device *pdev)
 	if (ret)
 		goto codec_unregister;
 
-	tegra_wm9712_dai.cpu_of_node = of_parse_phandle(np,
+	tegra_wm9712_dai.cpus->of_node = of_parse_phandle(np,
 				       "nvidia,ac97-controller", 0);
-	if (!tegra_wm9712_dai.cpu_of_node) {
+	if (!tegra_wm9712_dai.cpus->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'nvidia,ac97-controller' missing or invalid\n");
 		ret = -EINVAL;
 		goto codec_unregister;
 	}
 
-	tegra_wm9712_dai.platform_of_node = tegra_wm9712_dai.cpu_of_node;
+	tegra_wm9712_dai.platforms->of_node = tegra_wm9712_dai.cpus->of_node;
 
 	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
 	if (ret)
-- 
2.20.1
