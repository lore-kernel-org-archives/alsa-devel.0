From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: MMP audio needs sram support
Date: Thu, 05 Jun 2014 12:40:04 +0200
Message-ID: <4367111.vzeoBg4u5h@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, lgirdwood@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Qiao Zhou <zhouqiao@marvell.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

>From e7a94bb7fb871c73cc85712d89c1f48d0271c1be Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Jun 2014 12:31:28 +0200
Subject: [PATCH] ASoC: MMP audio needs sram support

Building the pxa/mmp audio driver without support for the mmp
sram driver enabled results in this link error:

sound/built-in.o: In function `mmp_pcm_free_dma_buffers':
:(.text+0x3e734): undefined reference to `sram_get_gpool'
sound/built-in.o: In function `mmp_pcm_new':
:(.text+0x3e7c0): undefined reference to `sram_get_gpool'

The sram driver is cannot be manually enabled and needs to
be turned on by selecting MMP_SRAM from each module that
needs it, which is what this patch does.

Ideally, MMP should move over to the generic SRAM support, but
for the moment, we can avoid the build error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Qiao Zhou <zhouqiao@marvell.com>

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 42b305e..12a6da8 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -11,6 +11,7 @@ config SND_PXA2XX_SOC
 config SND_MMP_SOC
 	bool "Soc Audio for Marvell MMP chips"
 	depends on ARCH_MMP
+	select MMP_SRAM
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select SND_ARM
 	help
