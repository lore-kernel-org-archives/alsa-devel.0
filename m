From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cirrus: edb93xx: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:37 +0100 (BST)
Message-ID: <20190606212637.443DE440046@finisterre.sirena.org.uk>
References: <87imtjicts.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9C52F897A5
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:37 +0200 (CEST)
In-Reply-To: <87imtjicts.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: cirrus: edb93xx: use modern dai_link style

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

>From 5e883ff15fc079a8004a104209e2ecb14e5b4bb0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:14:18 +0900
Subject: [PATCH] ASoC: cirrus: edb93xx: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/cirrus/edb93xx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/cirrus/edb93xx.c b/sound/soc/cirrus/edb93xx.c
index f678b4c1514a..1528d1410ff2 100644
--- a/sound/soc/cirrus/edb93xx.c
+++ b/sound/soc/cirrus/edb93xx.c
@@ -60,16 +60,18 @@ static const struct snd_soc_ops edb93xx_ops = {
 	.hw_params	= edb93xx_hw_params,
 };
 
+SND_SOC_DAILINK_DEFS(hifi,
+	DAILINK_COMP_ARRAY(COMP_CPU("ep93xx-i2s")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("spi0.0", "cs4271-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("ep93xx-i2s")));
+
 static struct snd_soc_dai_link edb93xx_dai = {
 	.name		= "CS4271",
 	.stream_name	= "CS4271 HiFi",
-	.platform_name	= "ep93xx-i2s",
-	.cpu_dai_name	= "ep93xx-i2s",
-	.codec_name	= "spi0.0",
-	.codec_dai_name	= "cs4271-hifi",
 	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			  SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &edb93xx_ops,
+	SND_SOC_DAILINK_REG(hifi),
 };
 
 static struct snd_soc_card snd_soc_edb93xx = {
-- 
2.20.1
