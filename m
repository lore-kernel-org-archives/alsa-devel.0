From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH v2 2/6] ARM: DaVinci: ASoC: Adds McASP clock
	support for TI DM646X processor
Date: Thu, 16 Apr 2009 18:41:46 -0400
Message-ID: <1239921706-26878-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id BB14B10394E
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 13:29:38 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3GBTXaU023883
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 06:29:38 -0500
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

Adds McASP clock support for the two instances of mcasp (mcasp0,mcasp1). This
patch is part of the audio support for dm646x series.

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch applies to the DaVinci git tree available at
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git

 arch/arm/mach-davinci/dm646x.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index f4a71da..39ffd17 100755
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -220,6 +220,18 @@ static struct clk gpio_clk = {
 	.lpsc = DM646X_LPSC_GPIO,
 };
 
+static struct clk mcasp0_clk = {
+	.name = "mcasp0",
+	.parent = &pll1_sysclk3,
+	.lpsc = DM646X_LPSC_McASP0,
+};
+
+static struct clk mcasp1_clk = {
+	.name = "mcasp1",
+	.parent = &pll1_sysclk3,
+	.lpsc = DM646X_LPSC_McASP1,
+};
+
 static struct clk aemif_clk = {
 	.name = "aemif",
 	.parent = &pll1_sysclk3,
@@ -307,6 +319,8 @@ struct davinci_clk dm646x_clks[] = {
 	CLK(NULL, "uart2", &uart2_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK(NULL, "gpio", &gpio_clk),
+	CLK(NULL, "mcasp0", &mcasp0_clk),
+	CLK(NULL, "mcasp1", &mcasp1_clk),
 	CLK(NULL, "aemif", &aemif_clk),
 	CLK("davinci_emac.1", NULL, &emac_clk),
 	CLK(NULL, "pwm0", &pwm0_clk),
-- 
1.5.6
