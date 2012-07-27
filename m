From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 6/7] ARM: ux500: Fix merge error,
	so such struct 'snd_soc_u8500'
Date: Fri, 27 Jul 2012 13:38:53 +0100
Message-ID: <1343392734-11805-7-git-send-email-lee.jones@linaro.org>
References: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 35263265CC7
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 14:39:09 +0200 (CEST)
Received: by mail-we0-f179.google.com with SMTP id x10so1836409wey.38
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 05:39:11 -0700 (PDT)
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

The platform attempts to register platform device 'snd_soc_u8500'
which doesn't actually exist. Here we change the reference to the
correct one 'snd_soc_mop500'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-msp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500-msp.c b/arch/arm/mach-ux500/board-mop500-msp.c
index 9960480..1b6a193 100644
--- a/arch/arm/mach-ux500/board-mop500-msp.c
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -228,7 +228,7 @@ int mop500_msp_init(struct device *parent)
 	struct platform_device *msp1;
 
 	pr_info("%s: Register platform-device 'snd-soc-u8500'.\n", __func__);
-	platform_device_register(&snd_soc_u8500);
+	platform_device_register(&snd_soc_mop500);
 
 	pr_info("Initialize MSP I2S-devices.\n");
 	db8500_add_msp_i2s(parent, 0, U8500_MSP0_BASE, IRQ_DB8500_MSP0,
-- 
1.7.9.5
