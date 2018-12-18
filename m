From: Mark Brown <broonie@kernel.org>
Subject: Applied "ARM: OMAP2: Update for new MCBSP Kconfig
	option" to the asoc tree
Date: Tue, 18 Dec 2018 12:23:43 +0000 (GMT)
Message-ID: <20181218122343.C568E11254FF@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 61DD726798A
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 13:23:44 +0100 (CET)
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

   ARM: OMAP2: Update for new MCBSP Kconfig option

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

>From 558eb0bfb271323cfd9f864f34d3253a65f352dd Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 17 Dec 2018 14:21:37 +0200
Subject: [PATCH] ARM: OMAP2: Update for new MCBSP Kconfig option

The MCBSP config option has been changed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-omap2/Makefile       | 2 +-
 arch/arm/mach-omap2/pdata-quirks.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 01377c292db4..899c60fac159 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_SOC_OMAP5)	 += $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_AM43XX) += $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_DRA7XX) += $(hwmod-common) $(secure-common)
 
-ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
+ifneq ($(CONFIG_SND_SOC_OMAP_MCBSP),)
 obj-y += mcbsp.o
 endif
 
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 9fec5f84bf77..8a5b6ed4ec36 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -524,7 +524,7 @@ void omap_auxdata_legacy_init(struct device *dev)
 	dev->platform_data = &twl_gpio_auxdata;
 }
 
-#if IS_ENABLED(CONFIG_SND_OMAP_SOC_MCBSP)
+#if IS_ENABLED(CONFIG_SND_SOC_OMAP_MCBSP)
 static struct omap_mcbsp_platform_data mcbsp_pdata;
 static void __init omap3_mcbsp_init(void)
 {
@@ -572,7 +572,7 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
 	OF_DEV_AUXDATA("ti,am3517-emac", 0x5c000000, "davinci_emac.0",
 		       &am35xx_emac_pdata),
 	/* McBSP modules with sidetone core */
-#if IS_ENABLED(CONFIG_SND_OMAP_SOC_MCBSP)
+#if IS_ENABLED(CONFIG_SND_SOC_OMAP_MCBSP)
 	OF_DEV_AUXDATA("ti,omap3-mcbsp", 0x49022000, "49022000.mcbsp", &mcbsp_pdata),
 	OF_DEV_AUXDATA("ti,omap3-mcbsp", 0x49024000, "49024000.mcbsp", &mcbsp_pdata),
 #endif
-- 
2.19.0.rc2
