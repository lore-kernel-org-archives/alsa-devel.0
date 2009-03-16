From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH 6/9] ARM: DaVinci: ASoC: Adds McASP clock
	support for TI DM646X processor
Date: Mon, 16 Mar 2009 08:05:25 -0400
Message-ID: <1237205125-30211-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id E3384103835
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 13:22:39 +0100 (CET)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2GCMYtw021864
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 07:22:39 -0500
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

Adds McASP clock support for TI DM646X processor

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch applies to the DaVinci git tree available at http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=commit;h=486afa37130356662213cc1a2199a285b4fd72af.

 arch/arm/mach-davinci/dm646x.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index af040cf..0aee774 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -185,6 +185,18 @@ static struct clk gpio_clk = {
 	.lpsc = DM646X_LPSC_GPIO,
 };
 
+static struct clk mcasp0_clk = {
+	.name = "mcasp0",
+	.parent = &pll1_sysclk3,
+	.lpsc = DM646X_LPSC_McASP0,
+};
+
+static struct clk mcasp1_clk = {
+	.name = "mcasp0",
+	.parent = &pll1_sysclk3,
+	.lpsc = DM646X_LPSC_McASP1,
+};
+
 static struct clk aemif_clk = {
 	.name = "aemif",
 	.parent = &pll1_sysclk3,
@@ -253,6 +265,8 @@ struct davinci_clk dm646x_clks[] = {
 	CLK(NULL, "uart2", &uart2_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK(NULL, "gpio", &gpio_clk),
+	CLK("soc-audio.0", NULL, &mcasp0_clk),
+	CLK("soc-audio.1", NULL, &mcasp1_clk),
 	CLK(NULL, "aemif", &aemif_clk),
 	CLK("davinci_emac.1", NULL, &emac_clk),
 	CLK(NULL, "pwm0", &pwm0_clk),
-- 
1.5.6
