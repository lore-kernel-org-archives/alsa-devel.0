From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 10/19] ARM: ux500: Stop registering the MOP500
	Audio driver from platform code
Date: Tue, 31 Jul 2012 14:39:04 +0100
Message-ID: <1343741953-17828-11-git-send-email-lee.jones@linaro.org>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 65657265D9F
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 15:39:36 +0200 (CEST)
Received: by mail-wg0-f51.google.com with SMTP id ed3so4575643wgb.20
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 06:39:38 -0700 (PDT)
In-Reply-To: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com
Cc: STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>, linus.walleij@stericsson.com, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

In this patch we prevent MOP500 driver registration from platform
code and rely solely on Device Tree to do the probing for us.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-msp.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-msp.c b/arch/arm/mach-ux500/board-mop500-msp.c
index 3328c3a..71d62ed 100644
--- a/arch/arm/mach-ux500/board-mop500-msp.c
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -175,9 +175,6 @@ struct msp_i2s_platform_data msp3_platform_data = {
 /* Due for removal once the MSP driver has been fully DT:ed. */
 void mop500_of_msp_init(struct device *parent)
 {
-	pr_info("%s: Register platform-device 'snd-soc-u8500'.\n", __func__);
-	platform_device_register(&snd_soc_mop500);
-
 	pr_info("Initialize MSP I2S-devices.\n");
 	db8500_add_msp_i2s(parent, 0, U8500_MSP0_BASE, IRQ_DB8500_MSP0,
 			   &msp0_platform_data);
-- 
1.7.9.5
