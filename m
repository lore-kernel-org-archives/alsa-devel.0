From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v8 1/5] clk: Make x86/ conditional on CONFIG_COMMON_CLK
Date: Mon, 23 Jan 2017 12:07:41 -0600
Message-ID: <1485194865-10400-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485194865-10400-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1485194865-10400-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: alsa-devel@alsa-project.org, Irina Tirdea <irina.tirdea@intel.com>, Michael Turquette <mturquette@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Fix Makefile for x86 support, dependency on CONFIG_COMMON_CLK
was not explicit

Fixes: 701190fd7419 ('clk: x86: add support for Lynxpoint LPSS clocks')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/clk/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 925081e..42042c0 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -87,6 +87,8 @@ obj-y					+= ti/
 obj-$(CONFIG_CLK_UNIPHIER)		+= uniphier/
 obj-$(CONFIG_ARCH_U8500)		+= ux500/
 obj-$(CONFIG_COMMON_CLK_VERSATILE)	+= versatile/
+ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_X86)			+= x86/
+endif
 obj-$(CONFIG_ARCH_ZX)			+= zte/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
-- 
2.7.4

