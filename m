From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: depends on OF" to the asoc tree
Date: Wed, 26 Oct 2016 16:12:54 +0100
Message-ID: <E1bzPss-00089o-QS@debutante>
References: <877f8xclzq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC870267119
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 17:13:02 +0200 (CEST)
In-Reply-To: <877f8xclzq.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: depends on OF

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

>From 609c94865adcef3dba070a2d3905e4b67b4e6919 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 26 Oct 2016 04:12:34 +0000
Subject: [PATCH] ASoC: rsnd: depends on OF

Current Renesas sound driver is completely depends on CONFIG_OF

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 6db6405d952f..610fa85b3acd 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -37,6 +37,7 @@ config SND_SOC_SH4_SIU
 config SND_SOC_RCAR
 	tristate "R-Car series SRU/SCU/SSIU/SSI support"
 	depends on COMMON_CLK
+	depends on OF
 	select SND_SIMPLE_CARD
 	select REGMAP_MMIO
 	help
-- 
2.8.1
