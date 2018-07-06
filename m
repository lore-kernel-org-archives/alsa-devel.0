From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: pxa: make SND_PXA_SOC_SSP depend on
	PLAT_PXA
Date: Fri,  6 Jul 2018 15:30:48 +0200
Message-ID: <20180706133104.129049-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by alsa0.perex.cz (Postfix) with ESMTP id A70CF2673C7
 for <alsa-devel@alsa-project.org>; Fri,  6 Jul 2018 15:31:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

For the moment, we can't enable CONFIG_SND_PXA_SOC_SSP unless we are
building for ARM PXA or MMP:

WARNING: unmet direct dependencies detected for PXA_SSP
  Depends on [n]: PLAT_PXA [=n]
  Selected by [y]:
  - SND_PXA_SOC_SSP [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y]

This adds an explicit dependency for it.

Fixes: 0a94cf345740 ("ASoC: pxa: make SND_PXA2XX_SOC_I2S selectable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 2fc02c227f69..776e148b0aa2 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -34,6 +34,7 @@ config SND_PXA2XX_SOC_I2S
 
 config SND_PXA_SOC_SSP
 	tristate "Soc Audio via PXA2xx/PXA3xx SSP ports"
+	depends on PLAT_PXA
 	select PXA_SSP
 	select SND_PXA2XX_LIB
 
-- 
2.9.0
