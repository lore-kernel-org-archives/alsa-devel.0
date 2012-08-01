From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/6 v2] ARM: ux500: Fix merge error,
 no matching driver name for, 'snd_soc_u8500'
Date: Wed, 01 Aug 2012 09:46:15 +0100
Message-ID: <5018ECD7.5030005@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-6-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A5060264FC1
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 10:46:15 +0200 (CEST)
Received: by eeke50 with SMTP id e50so1536097eek.38
 for <alsa-devel@alsa-project.org>; Wed, 01 Aug 2012 01:46:17 -0700 (PDT)
In-Reply-To: <1343741493-17671-6-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 27 Jul 2012 13:10:52 +0100
Subject: [PATCH 1/1] ARM: ux500: Fix merge error, no matching driver name for
 'snd_soc_u8500'

The platform attempts to register platform device 'snd_soc_u8500'
which doesn't actually exist. Here we change the reference to the
correct one 'snd_soc_mop500'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-msp.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-msp.c b/arch/arm/mach-ux500/board-mop500-msp.c
index 9960480..df15646 100644
--- a/arch/arm/mach-ux500/board-mop500-msp.c
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -191,9 +191,9 @@ static struct platform_device *db8500_add_msp_i2s(struct device *parent,
 	return pdev;
 }
 
-/* Platform device for ASoC U8500 machine */
-static struct platform_device snd_soc_u8500 = {
-		.name = "snd-soc-u8500",
+/* Platform device for ASoC MOP500 machine */
+static struct platform_device snd_soc_mop500 = {
+		.name = "snd-soc-mop500",
 		.id = 0,
 		.dev = {
 			.platform_data = NULL,
@@ -227,8 +227,8 @@ int mop500_msp_init(struct device *parent)
 {
 	struct platform_device *msp1;
 
-	pr_info("%s: Register platform-device 'snd-soc-u8500'.\n", __func__);
-	platform_device_register(&snd_soc_u8500);
+	pr_info("%s: Register platform-device 'snd-soc-mop500'.\n", __func__);
+	platform_device_register(&snd_soc_mop500);
 
 	pr_info("Initialize MSP I2S-devices.\n");
 	db8500_add_msp_i2s(parent, 0, U8500_MSP0_BASE, IRQ_DB8500_MSP0,
-- 
1.7.9.5
