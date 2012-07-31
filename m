From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/6] ARM: ux500: Remove unused snowball_of_platform_devs struct
Date: Tue, 31 Jul 2012 14:31:24 +0100
Message-ID: <1343741493-17671-4-git-send-email-lee.jones@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

This was left over during a recent clean-up which removed Device Tree
helper structs. There is no longer a requirement for it, so we can just
remove it.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 80b4f0e..e641003 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -726,11 +726,6 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_UX500_DT
 
-static struct platform_device *snowball_of_platform_devs[] __initdata = {
-	&snowball_led_dev,
-	&snowball_key_dev,
-};
-
 struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	/* Requires call-back bindings. */
 	OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
-- 
1.7.9.5
