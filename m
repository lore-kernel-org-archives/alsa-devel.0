From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5/7] ARM: ux500: Remove unused
	snowball_of_platform_devs struct
Date: Fri, 27 Jul 2012 13:38:52 +0100
Message-ID: <1343392734-11805-6-git-send-email-lee.jones@linaro.org>
References: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id CDEBD2652DD
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 14:39:07 +0200 (CEST)
Received: by mail-wg0-f51.google.com with SMTP id ed3so2087774wgb.20
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 05:39:10 -0700 (PDT)
In-Reply-To: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>, lrg@ti.com, linus.walleij@stericsson.com
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
