From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] clk: x86: add "mclk" alias for Baytrail/Cherrytrail
Date: Sun, 12 Feb 2017 16:06:52 -0600
Message-ID: <1486937212-10093-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Michael Turquette <mturquette@baylibre.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Due to timing requirements, TI and Conexant manage the audio
reference clock from their ASoC codec drivers using the "mclk"
string. This patch adds a default alias to "pmc_plt_clk_3" to
avoid Intel-specific tests in those codec drivers and use code
as-is.
"pmc_plt_clk_3" is used exclusively for audio on all known
Baytrail/CherryTrail designs and is e.g. routed on the MCLK
(pin 26) of the MinnowBoardMAX Turbot LSE connector.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---

Notes:
    This patch only applies on top of linux-next or clk-next, the
    previous clk-related patches are not yet merged in the audio
    trees

 drivers/clk/x86/clk-pmc-atom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
index 2b60577..ba00d27 100644
--- a/drivers/clk/x86/clk-pmc-atom.c
+++ b/drivers/clk/x86/clk-pmc-atom.c
@@ -340,6 +340,8 @@ static int plt_clk_probe(struct platform_device *pdev)
 
 	plt_clk_free_parent_names_loop(parent_names, data->nparents);
 
+	clk_add_alias("mclk", dev_name(&pdev->dev), "pmc_plt_clk_3", NULL);
+
 	platform_set_drvdata(pdev, data);
 	return 0;
 
-- 
2.7.4
