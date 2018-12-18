From: Mark Brown <broonie@kernel.org>
Subject: Applied "ARM: davinci: dm365-evm: Update for the new
	ASoC Kcofnig options" to the asoc tree
Date: Tue, 18 Dec 2018 12:23:41 +0000 (GMT)
Message-ID: <20181218122341.F345711254FF@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C3F2726793C
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 13:23:42 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ARM: davinci: dm365-evm: Update for the new ASoC Kcofnig options

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

>From 4d8c1e7efb9f915034c3dba2bc85ed1f8509ae0c Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 17 Dec 2018 14:21:38 +0200
Subject: [PATCH] ARM: davinci: dm365-evm: Update for the new ASoC Kcofnig
 options

The codec selection config options for DMA365 has been changed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 8143756ff38b..09e439d4abf5 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -794,9 +794,9 @@ static __init void dm365_evm_init(void)
 	/* maybe setup mmc1/etc ... _after_ mmc0 */
 	evm_init_cpld();
 
-#ifdef CONFIG_SND_DM365_AIC3X_CODEC
+#ifdef CONFIG_SND_SOC_DM365_AIC3X_CODEC
 	dm365_init_asp();
-#elif defined(CONFIG_SND_DM365_VOICE_CODEC)
+#elif defined(CONFIG_SND_SOC_DM365_VOICE_CODEC)
 	dm365_init_vc();
 #endif
 	dm365_init_rtc();
-- 
2.19.0.rc2
