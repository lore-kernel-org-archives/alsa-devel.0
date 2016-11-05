From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: fsl: fix fsl_spdif.c build errors
Date: Sat, 5 Nov 2016 16:16:32 -0700
Message-ID: <7ea1cd5a-9215-18ed-2412-b6860a0b708f@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Geliang Tang <geliangtang@163.com>, Kees Cook <keescook@chromium.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors in sound/soc/fsl/fsl_spdif.c by selecting BITREVERSE.
Fixes these build errors:

sound/built-in.o: In function `spdif_write_channel_status':
fsl_spdif.c:(.text+0xbe39d): undefined reference to `byte_rev_table'
fsl_spdif.c:(.text+0xbe3a8): undefined reference to `byte_rev_table'
fsl_spdif.c:(.text+0xbe3be): undefined reference to `byte_rev_table'
fsl_spdif.c:(.text+0xbe3d8): undefined reference to `byte_rev_table'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Applies-to: all 3.x, all 4.x
---
 sound/soc/fsl/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- lnx-49-rc3.orig/sound/soc/fsl/Kconfig
+++ lnx-49-rc3/sound/soc/fsl/Kconfig
@@ -40,6 +40,7 @@ config SND_SOC_FSL_SPDIF
 	select REGMAP_MMIO
 	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
 	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && (MXC_TZIC || MXC_AVIC)
+	select BITREVERSE
 	help
 	  Say Y if you want to add Sony/Philips Digital Interface (SPDIF)
 	  support for the Freescale CPUs.
