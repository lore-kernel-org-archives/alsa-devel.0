From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ASoC: sh: Drop SUPERH platform dependency
Date: Fri, 20 Apr 2018 16:22:14 +0200
Message-ID: <1524234134-14297-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 781AC2673D4
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 16:22:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The SIU sound peripheral is used only on SuperH SH-Mobile platforms.
As both SUPERH and ARCH_SHMOBILE are set for these platforms, the SUPERH
dependency can be dropped.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index c1b7fb91e3063f2b..0ae0800bf3a8b471 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -28,7 +28,7 @@ config SND_SOC_SH4_FSI
 
 config SND_SOC_SH4_SIU
 	tristate
-	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
+	depends on ARCH_SHMOBILE && HAVE_CLK
 	select DMA_ENGINE
 	select DMADEVICES
 	select SH_DMAE
-- 
2.7.4
