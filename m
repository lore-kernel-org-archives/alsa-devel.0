From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: cht_bsw_max98090_ti: Add quirk
	for boards using pmc_plt_clk_0" to the asoc tree
Date: Mon,  5 Nov 2018 11:57:21 +0000 (GMT)
Message-ID: <20181105115721.AFD5A1124D98@debutante.sirena.org.uk>
References: <20181031142225.16109-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E4002679B1
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 12:57:23 +0100 (CET)
In-Reply-To: <20181031142225.16109-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, stable@vger.kernel.org, Dean Wallace <duffydack73@gmail.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: cht_bsw_max98090_ti: Add quirk for boards using pmc_plt_clk_0

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a182ecd3809c8d5a2da80c520f3602e301c5317e Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 31 Oct 2018 15:22:25 +0100
Subject: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Add quirk for boards using
 pmc_plt_clk_0

Some boards such as the Swanky model Chromebooks use pmc_plt_clk_0 for the
mclk instead of pmc_plt_clk_3.

This commit adds a DMI based quirk for this.

This fixing audio no longer working on these devices after
commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
that commit fixes us unnecessary keeping unused clocks on, but in case
of the Swanky that was breaking audio support since we were not using
the right clock in the cht_bsw_max98090_ti machine driver.

Cc: stable@vger.kernel.org
Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Reported-and-tested-by: Dean Wallace <duffydack73@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 32 ++++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index db6976f4ddaa..9d9f6e41d81c 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -19,6 +19,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -35,6 +36,8 @@
 #define CHT_PLAT_CLK_3_HZ	19200000
 #define CHT_CODEC_DAI	"HiFi"
 
+#define QUIRK_PMC_PLT_CLK_0				0x01
+
 struct cht_mc_private {
 	struct clk *mclk;
 	struct snd_soc_jack jack;
@@ -385,11 +388,29 @@ static struct snd_soc_card snd_soc_card_cht = {
 	.num_controls = ARRAY_SIZE(cht_mc_controls),
 };
 
+static const struct dmi_system_id cht_max98090_quirk_table[] = {
+	{
+		/* Swanky model Chromebook (Toshiba Chromebook 2) */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Swanky"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{}
+};
+
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
+	const struct dmi_system_id *dmi_id;
 	struct device *dev = &pdev->dev;
 	int ret_val = 0;
 	struct cht_mc_private *drv;
+	const char *mclk_name;
+	int quirks = 0;
+
+	dmi_id = dmi_first_match(cht_max98090_quirk_table);
+	if (dmi_id)
+		quirks = (unsigned long)dmi_id->driver_data;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
@@ -411,11 +432,16 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	snd_soc_card_cht.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
 
-	drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+	if (quirks & QUIRK_PMC_PLT_CLK_0)
+		mclk_name = "pmc_plt_clk_0";
+	else
+		mclk_name = "pmc_plt_clk_3";
+
+	drv->mclk = devm_clk_get(&pdev->dev, mclk_name);
 	if (IS_ERR(drv->mclk)) {
 		dev_err(&pdev->dev,
-			"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
-			PTR_ERR(drv->mclk));
+			"Failed to get MCLK from %s: %ld\n",
+			mclk_name, PTR_ERR(drv->mclk));
 		return PTR_ERR(drv->mclk);
 	}
 
-- 
2.19.0.rc2
