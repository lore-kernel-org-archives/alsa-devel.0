From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: rnsd: fix build regression without
	CONFIG_OF
Date: Sat, 11 Apr 2015 00:18:37 +0200
Message-ID: <6164726.dCMByIoYOc@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 50A05260688
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 00:18:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The r-car sound driver only works when CONFIG_OF is set, and
after a recent change has a compile-time dependency as well:

sound/built-in.o: In function `rsnd_dma_request_channel':
:(.text+0x9fb84): undefined reference to `of_dma_request_slave_channel'

This could be fixed either by adding a static inline wrapper
for the function, or by adding a Kconfig dependency. This
implements the second approach, which seems appropriate
because the driver in fact has a hard dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 72adc61f4637aa3 ("ASoC: rsnd: 1st DMAC dma-names cares subnode")

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 2b3030415573..07114b0b0dc1 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -36,6 +36,7 @@ config SND_SOC_SH4_SIU
 
 config SND_SOC_RCAR
 	tristate "R-Car series SRU/SCU/SSIU/SSI support"
+	depends on DMA_OF
 	select SND_SIMPLE_CARD
 	select REGMAP_MMIO
 	help
