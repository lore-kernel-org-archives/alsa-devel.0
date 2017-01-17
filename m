From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v7 5/5] platform/x86: fix typo in comment
Date: Tue, 17 Jan 2017 15:57:50 -0600
Message-ID: <1484690270-28425-6-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1484690270-28425-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1484690270-28425-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: alsa-devel@alsa-project.org, Irina Tirdea <irina.tirdea@intel.com>, Michael Turquette <mturquette@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

s/Acumulate/Accumulate/

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/platform_data/x86/pmc_atom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/x86/pmc_atom.h b/include/linux/platform_data/x86/pmc_atom.h
index aa8744c..e4905fe 100644
--- a/include/linux/platform_data/x86/pmc_atom.h
+++ b/include/linux/platform_data/x86/pmc_atom.h
@@ -50,7 +50,7 @@
 				BIT_ORED_DEDICATED_IRQ_GPSC | \
 				BIT_SHARED_IRQ_GPSS)
 
-/* The timers acumulate time spent in sleep state */
+/* The timers accumulate time spent in sleep state */
 #define	PMC_S0IR_TMR		0x80
 #define	PMC_S0I1_TMR		0x84
 #define	PMC_S0I2_TMR		0x88
-- 
2.7.4

