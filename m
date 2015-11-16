From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: SND_SOC_RCAR doesn't depend on
	DMA_OF" to the asoc tree
Date: Mon, 16 Nov 2015 17:51:45 +0000
Message-ID: <E1ZyNwP-0006mj-VZ@debutante>
References: <87twoziq9j.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F17A82604E1
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 18:51:54 +0100 (CET)
In-Reply-To: <87twoziq9j.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: SND_SOC_RCAR doesn't depend on DMA_OF

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 85d4a62140def5402bed3c6b914f6faafa185490 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 6 Nov 2015 06:46:30 +0000
Subject: [PATCH] ASoC: rsnd: SND_SOC_RCAR doesn't depend on DMA_OF

8616774("ASoC: rnsd: fix build regression without CONFIG_OF")
added "depends on DMA_OF" in SND_SOC_RCAR to avoid compile error of

    sound/built-in.o: In function `rsnd_dma_request_channel':
    :(.text+0x9fb84): undefined reference to `of_dma_request_slave_channel'

But, it was OF base DMAEngine API definition issue, not SND_SOC_RCAR
issue. This patch remove DMA_OF dependence.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 206d1edab07c..c9902a6d6fa0 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -36,7 +36,6 @@ config SND_SOC_SH4_SIU
 
 config SND_SOC_RCAR
 	tristate "R-Car series SRU/SCU/SSIU/SSI support"
-	depends on DMA_OF
 	depends on COMMON_CLK
 	select SND_SIMPLE_CARD
 	select REGMAP_MMIO
-- 
2.6.2
