From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: omap3pandora: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:47 +0100 (BST)
Message-ID: <20190606212647.DB483440049@finisterre.sirena.org.uk>
References: <87a7evjrgm.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B35E0F897B9
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:48 +0200 (CEST)
In-Reply-To: <87a7evjrgm.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: ti: omap3pandora: use modern dai_link style

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

>From 77723f1c262f39b4d82eb5fda7ac045c0aea8e3d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:12:52 +0900
Subject: [PATCH] ASoC: ti: omap3pandora: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/omap3pandora.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/ti/omap3pandora.c b/sound/soc/ti/omap3pandora.c
index 4e3de712159c..3d52b6b008ce 100644
--- a/sound/soc/ti/omap3pandora.c
+++ b/sound/soc/ti/omap3pandora.c
@@ -189,29 +189,33 @@ static const struct snd_soc_ops omap3pandora_ops = {
 };
 
 /* Digital audio interface glue - connects codec <--> CPU */
+SND_SOC_DAILINK_DEFS(out,
+	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.2")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.2")));
+
+SND_SOC_DAILINK_DEFS(in,
+	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.4")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.4")));
+
 static struct snd_soc_dai_link omap3pandora_dai[] = {
 	{
 		.name = "PCM1773",
 		.stream_name = "HiFi Out",
-		.cpu_dai_name = "omap-mcbsp.2",
-		.codec_dai_name = "twl4030-hifi",
-		.platform_name = "omap-mcbsp.2",
-		.codec_name = "twl4030-codec",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
 		.ops = &omap3pandora_ops,
 		.init = omap3pandora_out_init,
+		SND_SOC_DAILINK_REG(out),
 	}, {
 		.name = "TWL4030",
 		.stream_name = "Line/Mic In",
-		.cpu_dai_name = "omap-mcbsp.4",
-		.codec_dai_name = "twl4030-hifi",
-		.platform_name = "omap-mcbsp.4",
-		.codec_name = "twl4030-codec",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
 		.ops = &omap3pandora_ops,
 		.init = omap3pandora_in_init,
+		SND_SOC_DAILINK_REG(in),
 	}
 };
 
-- 
2.20.1
