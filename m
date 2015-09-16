From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: SND_SOC_RCAR depends on
	COMMON_CLK" to the asoc tree
Date: Wed, 16 Sep 2015 21:01:45 +0100
Message-ID: <E1ZcItl-0007rv-9j@finisterre>
References: <877fns4ddo.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 49FC5261AD0
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 22:01:51 +0200 (CEST)
In-Reply-To: <877fns4ddo.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: SND_SOC_RCAR depends on COMMON_CLK

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

>From e2f8445176c9e6e6b152b792d08abca8308bb8ff Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Sep 2015 02:41:05 +0000
Subject: [PATCH] ASoC: rsnd: SND_SOC_RCAR depends on COMMON_CLK

2a46db4a3("ASoC: rsnd: add AUDIO_CLKOUT support") uses
of_clk_add_provider() which is requesting struct clk_onecell_data.
But it is COMMON_CLK feature. SND_SOC_RCAR depends on COMMON_CLK

This patch also solved compile error of 7486d80f7("ASoC: rsnd: remove
unneeded sh_clk header")

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 07114b0..6ca90aa 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -37,6 +37,7 @@ config SND_SOC_SH4_SIU
 config SND_SOC_RCAR
 	tristate "R-Car series SRU/SCU/SSIU/SSI support"
 	depends on DMA_OF
+	depends on COMMON_CLK
 	select SND_SIMPLE_CARD
 	select REGMAP_MMIO
 	help
-- 
2.5.0
