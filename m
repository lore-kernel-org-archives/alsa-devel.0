From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: imx-mc13783: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:29 +0100 (BST)
Message-ID: <20190606212629.E6975440046@finisterre.sirena.org.uk>
References: <87zhmvgy6b.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A83E8F8978D
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:30 +0200 (CEST)
In-Reply-To: <87zhmvgy6b.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: fsl: imx-mc13783: use modern dai_link style

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

>From 8a147e503dd622fe744759bf6199b2a6da45e893 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:16:08 +0900
Subject: [PATCH] ASoC: fsl: imx-mc13783: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-mc13783.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index 545815a27074..2b679680c93f 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -46,17 +46,19 @@ static const struct snd_soc_ops imx_mc13783_hifi_ops = {
 	.hw_params = imx_mc13783_hifi_hw_params,
 };
 
+SND_SOC_DAILINK_DEFS(hifi,
+	DAILINK_COMP_ARRAY(COMP_CPU("imx-ssi.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("mc13783-codec", "mc13783-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("imx-ssi.0")));
+
 static struct snd_soc_dai_link imx_mc13783_dai_mc13783[] = {
 	{
 		.name = "MC13783",
 		.stream_name	 = "Sound",
-		.codec_dai_name	 = "mc13783-hifi",
-		.codec_name	 = "mc13783-codec",
-		.cpu_dai_name	 = "imx-ssi.0",
-		.platform_name	 = "imx-ssi.0",
 		.ops		 = &imx_mc13783_hifi_ops,
 		.symmetric_rates = 1,
 		.dai_fmt 	 = FMT_SSI,
+		SND_SOC_DAILINK_REG(hifi),
 	},
 };
 
-- 
2.20.1
