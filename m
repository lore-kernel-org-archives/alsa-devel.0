From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh: Drop SUPERH platform dependency" to
	the asoc tree
Date: Fri, 20 Apr 2018 18:00:49 +0100
Message-ID: <E1f9ZOz-0004Hg-U0@debutante>
References: <1524234134-14297-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8830E2673D4
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 19:01:07 +0200 (CEST)
In-Reply-To: <1524234134-14297-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sh: Drop SUPERH platform dependency

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 4070d91754039e88f7b64e462f3d0d8cdb4be041 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 20 Apr 2018 16:22:14 +0200
Subject: [PATCH] ASoC: sh: Drop SUPERH platform dependency

The SIU sound peripheral is used only on SuperH SH-Mobile platforms.
As both SUPERH and ARCH_SHMOBILE are set for these platforms, the SUPERH
dependency can be dropped.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 1aa5cd77ca24..365f46321147 100644
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
2.17.0
