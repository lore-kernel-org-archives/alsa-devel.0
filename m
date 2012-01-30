From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 1/3] ARM: ux500: Add placeholder for
	clk_set_parent
Date: Mon, 30 Jan 2012 15:18:14 +0100
Message-ID: <1327933094-22155-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog117.obsmtp.com (eu1sys200aog117.obsmtp.com
	[207.126.144.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 28CEA103972
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 15:18:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

Calling clk_set_parent (e.g. from Ux500 ASoC-driver) generates
build-errors.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 arch/arm/mach-ux500/clock.c |    7 +++++++
 arch/arm/mach-ux500/clock.h |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 7379075..ec35f0a 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -223,6 +223,13 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL(clk_set_rate);
 
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	/*TODO*/
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
 static void clk_prcmu_enable(struct clk *clk)
 {
 	void __iomem *cg_set_reg = __io_address(U8500_PRCMU_BASE)
diff --git a/arch/arm/mach-ux500/clock.h b/arch/arm/mach-ux500/clock.h
index 0744907..d776ada 100644
--- a/arch/arm/mach-ux500/clock.h
+++ b/arch/arm/mach-ux500/clock.h
@@ -21,6 +21,7 @@ struct clkops {
 	void (*enable) (struct clk *);
 	void (*disable) (struct clk *);
 	unsigned long (*get_rate) (struct clk *);
+	int (*set_parent)(struct clk *, struct clk *);
 };
 
 /**
-- 
1.7.8.3
