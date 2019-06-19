From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: imx-es8328: don't select
	unnecessary Platform" to the asoc tree
Date: Wed, 19 Jun 2019 13:12:02 +0100 (BST)
Message-ID: <20190619121202.E9AF6440046@finisterre.sirena.org.uk>
References: <87muiev0jh.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47671F89745
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 14:12:04 +0200 (CEST)
In-Reply-To: <87muiev0jh.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: fsl: imx-es8328: don't select unnecessary Platform

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

>From 577cf50d4dc865af13be05d201abbd5a4a4d4be8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Jun 2019 10:16:51 +0900
Subject: [PATCH] ASoC: fsl: imx-es8328: don't select unnecessary Platform

ALSA SoC is now supporting "no Platform". Sound card doesn't need to
select "CPU component" as "Platform" anymore if it doesn't need
special Platform.
This patch removes such settings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-es8328.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 15a27a2cd0ca..089ee140c718 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -148,7 +148,7 @@ static int imx_es8328_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	comp = devm_kzalloc(dev, 3 * sizeof(*comp), GFP_KERNEL);
+	comp = devm_kzalloc(dev, 2 * sizeof(*comp), GFP_KERNEL);
 	if (!comp) {
 		ret = -ENOMEM;
 		goto fail;
@@ -160,18 +160,15 @@ static int imx_es8328_probe(struct platform_device *pdev)
 
 	data->dai.cpus		= &comp[0];
 	data->dai.codecs	= &comp[1];
-	data->dai.platforms	= &comp[2];
 
 	data->dai.num_cpus	= 1;
 	data->dai.num_codecs	= 1;
-	data->dai.num_platforms	= 1;
 
 	data->dai.name = "hifi";
 	data->dai.stream_name = "hifi";
 	data->dai.codecs->dai_name = "es8328-hifi-analog";
 	data->dai.codecs->of_node = codec_np;
 	data->dai.cpus->of_node = ssi_np;
-	data->dai.platforms->of_node = ssi_np;
 	data->dai.init = &imx_es8328_dai_init;
 	data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			    SND_SOC_DAIFMT_CBM_CFM;
-- 
2.20.1
