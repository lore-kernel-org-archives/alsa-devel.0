From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: fix fsl_spdif.c build errors" to the asoc tree
Date: Wed, 09 Nov 2016 14:59:02 +0000
Message-ID: <E1c4UL8-0002bk-P8@finisterre>
References: <7ea1cd5a-9215-18ed-2412-b6860a0b708f@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7ea1cd5a-9215-18ed-2412-b6860a0b708f@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: kbuild test robot <fengguang.wu@intel.com>, Mark Brown <broonie@kernel.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Geliang Tang <geliangtang@163.com>, moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: fix fsl_spdif.c build errors

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

>From b3af6d3f966a86cc556f5048fe6fff4e8cf567bc Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Sat, 5 Nov 2016 16:16:32 -0700
Subject: [PATCH] ASoC: fsl: fix fsl_spdif.c build errors

Fix build errors in sound/soc/fsl/fsl_spdif.c by selecting BITREVERSE.
Fixes these build errors:

sound/built-in.o: In function `spdif_write_channel_status':
fsl_spdif.c:(.text+0xbe39d): undefined reference to `byte_rev_table'
fsl_spdif.c:(.text+0xbe3a8): undefined reference to `byte_rev_table'
fsl_spdif.c:(.text+0xbe3be): undefined reference to `byte_rev_table'
fsl_spdif.c:(.text+0xbe3d8): undefined reference to `byte_rev_table'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 19bdcac71775..37f9b6201918 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -40,6 +40,7 @@ config SND_SOC_FSL_SPDIF
 	select REGMAP_MMIO
 	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
 	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && (MXC_TZIC || MXC_AVIC)
+	select BITREVERSE
 	help
 	  Say Y if you want to add Sony/Philips Digital Interface (SPDIF)
 	  support for the Freescale CPUs.
-- 
2.10.2
