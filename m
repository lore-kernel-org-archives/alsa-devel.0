From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ASoC: pxa: SND_PXA2XX_SOC should depend on
	HAS_DMA
Date: Sun,  9 Jul 2017 21:30:32 +0200
Message-ID: <1499628632-15421-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
 by alsa0.perex.cz (Postfix) with ESMTP id CE8122669CD
 for <alsa-devel@alsa-project.org>; Sun,  9 Jul 2017 21:30:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If NO_DMA=y:

    ERROR: "bad_dma_ops" [sound/soc/pxa/snd-soc-pxa2xx.ko] undefined!
    ERROR: "bad_dma_ops" [sound/arm/snd-pxa2xx-lib.ko] undefined!
    ERROR: "dma_common_mmap" [sound/arm/snd-pxa2xx-lib.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Fixes: 73d7ee2e831f106c ("ASoC: pxa: add COMPILE_TEST on SND_PXA2XX_SOC")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/soc/pxa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 960744e46edc0549..484ab3c2ad672fc8 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -1,6 +1,7 @@
 config SND_PXA2XX_SOC
 	tristate "SoC Audio for the Intel PXA2xx chip"
 	depends on ARCH_PXA || COMPILE_TEST
+	depends on HAS_DMA
 	select SND_PXA2XX_LIB
 	help
 	  Say Y or M if you want to add support for codecs attached to
-- 
2.7.4
