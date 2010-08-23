From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] omap: rx51: Remove redefinition of
	rx51_aic3x_data
Date: Mon, 23 Aug 2010 10:35:05 +0300
Message-ID: <1282548905-10287-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 66E3824429
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 09:34:41 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2940966eyd.38
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 00:34:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Redefinition of rx51_aic3x_data got introduced when merging upstread changes
for 2.6.36 and ASoC Multi-Component Support.

This must go together with multi-component commit f0fba2a.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 897d960..11ce4b2 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -710,10 +710,6 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
 	.vio			= &rx51_vio,
 };
 
-static struct aic3x_pdata rx51_aic3x_data __initdata = {
-	.gpio_reset		= 60,
-};
-
 static struct tpa6130a2_platform_data rx51_tpa6130a2_data __initdata = {
 	.id			= TPA6130A2,
 	.power_gpio		= 98,
-- 
1.7.1
