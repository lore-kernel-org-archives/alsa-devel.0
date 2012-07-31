From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 11/19] ARM: ux500: Stop registering the PCM
	driver from platform code
Date: Tue, 31 Jul 2012 14:39:05 +0100
Message-ID: <1343741953-17828-12-git-send-email-lee.jones@linaro.org>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 29290265DA8
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 15:39:38 +0200 (CEST)
Received: by wibhq4 with SMTP id hq4so2369316wib.2
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 06:39:40 -0700 (PDT)
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

We now initialise the PCM driver through the MSP DAI, so there is
no need to register it though platform code anymore. This patch
strips out all PCM platform registration.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-msp.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-msp.c b/arch/arm/mach-ux500/board-mop500-msp.c
index 71d62ed..7af2dce 100644
--- a/arch/arm/mach-ux500/board-mop500-msp.c
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -184,9 +184,6 @@ void mop500_of_msp_init(struct device *parent)
 			   &msp2_platform_data);
 	db8500_add_msp_i2s(parent, 3, U8500_MSP3_BASE, IRQ_DB8500_MSP1,
 			   &msp3_platform_data);
-
-	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
-	platform_device_register(&ux500_pcm);
 }
 
 void mop500_msp_init(struct device *parent)
@@ -203,7 +200,4 @@ void mop500_msp_init(struct device *parent)
 			   &msp2_platform_data);
 	db8500_add_msp_i2s(parent, 3, U8500_MSP3_BASE, IRQ_DB8500_MSP1,
 			   &msp3_platform_data);
-
-	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
-	platform_device_register(&ux500_pcm);
 }
-- 
1.7.9.5
