From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH v3 1/6] ARM: DaVinci: ASoC: Adds McASP clock
	support for TI DM646X processor
Date: Thu, 28 May 2009 05:09:21 -0400
Message-ID: <1243501761-28420-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 784871038B7
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 11:45:57 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4S9jn4W017655
	for <alsa-devel@alsa-project.org>; Thu, 28 May 2009 04:45:54 -0500
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
Cc: Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

Adds McASP clock support for the two instances of mcasp (mcasp0,mcasp1). This
patch is part of the audio support for dm646x series.

Signed-off-by: Naresh Medisetty <naresh@ti.com>
Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
This patch applies to the DaVinci git tree available at
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git

 arch/arm/mach-davinci/dm646x.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index f95b5e9..07c8d88 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -227,6 +227,18 @@ static struct clk gpio_clk = {
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
@@ -314,6 +326,8 @@ struct davinci_clk dm646x_clks[] = {
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
