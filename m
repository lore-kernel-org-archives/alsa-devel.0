From: <vm.rod25@gmail.com>
Subject: [PATCH v4 8/9] davinci: USB clocks for
	Omapl138-Hawkboard
Date: Thu, 14 Oct 2010 22:08:24 -0500
Message-ID: <1287112105-11968-9-git-send-email-vm.rod25@gmail.com>
References: <1287112105-11968-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 3831A103893
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 05:07:39 +0200 (CEST)
In-Reply-To: <1287112105-11968-1-git-send-email-vm.rod25@gmail.com>
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
Cc: nsekhar@ti.com, alsa-devel@alsa-project.org, khasim@ti.com, caglarakyuz@gmail.com, sshtylyov@mvista.com
List-Id: alsa-devel@alsa-project.org

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch adds USB1.1 and USB2.0 clocks for the Hawkboard-L138 system

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
---
 arch/arm/mach-davinci/da850.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 4458bff..2a4730e 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -345,6 +345,20 @@ static struct clk aemif_clk = {
 	.flags		= ALWAYS_ENABLED,
 };
 
+static struct clk usb11_clk = {
+	.name		= "usb11",
+	.parent		= &pll0_sysclk4,
+	.lpsc		= DA8XX_LPSC1_USB11,
+	.gpsc		= 1,
+	};
+
+static struct clk usb20_clk = {
+	.name		= "usb20",
+	.parent		= &pll0_sysclk2,
+	.lpsc		= DA8XX_LPSC1_USB20,
+	.gpsc		= 1,
+	};
+
 static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"ref",		&ref_clk),
 	CLK(NULL,		"pll0",		&pll0_clk),
@@ -387,6 +401,8 @@ static struct clk_lookup da850_clks[] = {
 	CLK("davinci_mmc.0",	NULL,		&mmcsd0_clk),
 	CLK("davinci_mmc.1",	NULL,		&mmcsd1_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
+	CLK(NULL,		"usb11",	&usb11_clk),
+	CLK(NULL,		"usb20",	&usb20_clk),
 	CLK(NULL,		NULL,		NULL),
 };
 
-- 
1.6.0.5
