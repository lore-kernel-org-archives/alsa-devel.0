From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Make SND_SOC_SAARB and SND_SOC_TAVOREVB3
 depend on MFD_88PM860X
Date: Wed, 12 Oct 2011 19:49:52 +0800
Message-ID: <1318420192.28832.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BF7124514
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 13:50:06 +0200 (CEST)
Received: by ggnf2 with SMTP id f2so634451ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2011 04:50:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

In saarb_pm860x_init() and evb3_pm860x_init(), we call
pm860x_hs_jack_detect() and pm860x_mic_jack_detect() which in turn
calls pm860x_set_bits().
Thus make SND_SOC_SAARB and SND_SOC_TAVOREVB3 depend on MFD_88PM860X

This patch fixes below build error if CONFIG_MFD_88PM860X is not configured.

  LD      .tmp_vmlinux1
sound/built-in.o: In function `pm860x_write_reg_cache':
last.c:(.text+0x29e9c): undefined reference to `pm860x_reg_write'
sound/built-in.o: In function `pm860x_set_bias_level':
last.c:(.text+0x29ecc): undefined reference to `pm860x_set_bits'
last.c:(.text+0x29f00): undefined reference to `pm860x_reg_write'
last.c:(.text+0x29f18): undefined reference to `pm860x_reg_write'
sound/built-in.o: In function `pm860x_read_reg_cache':
last.c:(.text+0x29f40): undefined reference to `pm860x_reg_read'
sound/built-in.o: In function `pm860x_probe':
last.c:(.text+0x2a034): undefined reference to `pm860x_bulk_read'
sound/built-in.o: In function `pm860x_codec_handler':
last.c:(.text+0x2a344): undefined reference to `pm860x_reg_read'
last.c:(.text+0x2a354): undefined reference to `pm860x_reg_read'
sound/built-in.o: In function `pm860x_mic_jack_detect':
last.c:(.text+0x2a450): undefined reference to `pm860x_set_bits'
sound/built-in.o: In function `pm860x_hs_jack_detect':
last.c:(.text+0x2a4d0): undefined reference to `pm860x_set_bits'
last.c:(.text+0x2a4f8): undefined reference to `pm860x_set_bits'
last.c:(.text+0x2a510): undefined reference to `pm860x_set_bits'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 33ebc46b..b12b4af 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -121,6 +121,7 @@ config SND_PXA2XX_SOC_PALM27X
 config SND_SOC_SAARB
 	tristate "SoC Audio support for Marvell Saarb"
 	depends on SND_PXA2XX_SOC && MACH_SAARB
+	depends on MFD_88PM860X
 	select SND_PXA_SOC_SSP
 	select SND_SOC_88PM860X
 	help
@@ -130,6 +131,7 @@ config SND_SOC_SAARB
 config SND_SOC_TAVOREVB3
 	tristate "SoC Audio support for Marvell Tavor EVB3"
 	depends on SND_PXA2XX_SOC && MACH_TAVOREVB3
+	depends on MFD_88PM860X
 	select SND_PXA_SOC_SSP
 	select SND_SOC_88PM860X
 	help
-- 
1.7.4.1
