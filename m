From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tegra: tegra_wm8753: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:18 +0100 (BST)
Message-ID: <20190606212618.F28AE440046@finisterre.sirena.org.uk>
References: <877e9zgy27.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF46AF89762
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:19 +0200 (CEST)
In-Reply-To: <877e9zgy27.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: tegra: tegra_wm8753: use modern dai_link style

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

>From efefce542260fb9c26634fa01582aabc72166259 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:18:36 +0900
Subject: [PATCH] ASoC: tegra: tegra_wm8753: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra_wm8753.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/tegra/tegra_wm8753.c b/sound/soc/tegra/tegra_wm8753.c
index 23a810e3bacc..8492b3dbb788 100644
--- a/sound/soc/tegra/tegra_wm8753.c
+++ b/sound/soc/tegra/tegra_wm8753.c
@@ -98,14 +98,19 @@ static const struct snd_soc_dapm_widget tegra_wm8753_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Mic Jack", NULL),
 };
 
+SND_SOC_DAILINK_DEFS(pcm,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm8753-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link tegra_wm8753_dai = {
 	.name = "WM8753",
 	.stream_name = "WM8753 PCM",
-	.codec_dai_name = "wm8753-hifi",
 	.ops = &tegra_wm8753_ops,
 	.dai_fmt = SND_SOC_DAIFMT_I2S |
 			SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
+	SND_SOC_DAILINK_REG(pcm),
 };
 
 static struct snd_soc_card snd_soc_tegra_wm8753 = {
@@ -142,25 +147,25 @@ static int tegra_wm8753_driver_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	tegra_wm8753_dai.codec_of_node = of_parse_phandle(np,
+	tegra_wm8753_dai.codecs->of_node = of_parse_phandle(np,
 			"nvidia,audio-codec", 0);
-	if (!tegra_wm8753_dai.codec_of_node) {
+	if (!tegra_wm8753_dai.codecs->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'nvidia,audio-codec' missing or invalid\n");
 		ret = -EINVAL;
 		goto err;
 	}
 
-	tegra_wm8753_dai.cpu_of_node = of_parse_phandle(np,
+	tegra_wm8753_dai.cpus->of_node = of_parse_phandle(np,
 			"nvidia,i2s-controller", 0);
-	if (!tegra_wm8753_dai.cpu_of_node) {
+	if (!tegra_wm8753_dai.cpus->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'nvidia,i2s-controller' missing or invalid\n");
 		ret = -EINVAL;
 		goto err;
 	}
 
-	tegra_wm8753_dai.platform_of_node = tegra_wm8753_dai.cpu_of_node;
+	tegra_wm8753_dai.platforms->of_node = tegra_wm8753_dai.cpus->of_node;
 
 	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
 	if (ret)
-- 
2.20.1
