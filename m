From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] sound: rockchip: fix build when SPI is
	not enabled
Date: Mon, 22 Aug 2016 11:32:45 -0700
Message-ID: <14691987-ab74-96c4-de5d-8caa06e94d3f@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id B6E80266661
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 20:32:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: LKML <linux-kernel@vger.kernel.org>, moderated for non-subscribers <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors found in rt5514 drivers when SPI is not enabled.

Fixes these build errors:
ERROR: "__spi_register_driver" [sound/soc/codecs/snd-soc-rt5514-spi.ko] undefined!
ERROR: "spi_sync" [sound/soc/codecs/snd-soc-rt5514-spi.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Bard Liao <bardliao@realtek.com>
Cc:	Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/rockchip/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This builds without errors, but if you always want to have the SPI
interface available in this driver, change the first "depends" to
include "&& SPI_MASTER".

--- linux-next-20160822.orig/sound/soc/rockchip/Kconfig
+++ linux-next-20160822/sound/soc/rockchip/Kconfig
@@ -49,7 +49,7 @@ config SND_SOC_RK3399_GRU_SOUND
 	select SND_SOC_MAX98357A
 	select SND_SOC_RT5514
 	select SND_SOC_DA7219
-	select SND_SOC_RT5514_SPI
+	select SND_SOC_RT5514_SPI if SPI_MASTER
 	help
 	  Say Y or M here if you want to add support multiple codecs for SoC
 	  audio on Rockchip RK3399 GRU boards.
