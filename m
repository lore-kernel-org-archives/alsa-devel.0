From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: cht_bsw_max98090_ti: Add pmc_plt_clk_0 quirk for Chromebook Gnawty" to the asoc tree
Date: Thu,  6 Dec 2018 20:26:07 +0000 (GMT)
Message-ID: <20181206202607.E134511252F7@debutante.sirena.org.uk>
References: <20181203204514.3991-1-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181203204514.3991-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: stable@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>stable@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: cht_bsw_max98090_ti: Add pmc_plt_clk_0 quirk for Chromebook Gnawty

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

>From 94ea56cff506c769a509c5dd87904c7fe3806a81 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 3 Dec 2018 21:45:14 +0100
Subject: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Add pmc_plt_clk_0 quirk for
 Chromebook Gnawty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Gnawty model Chromebook uses pmc_plt_clk_0 instead of pmc_plt_clk_3
for the mclk, just like the Clapper and Swanky models.

This commit adds a DMI based quirk for this.

This fixing audio no longer working on these devices after
commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
that commit fixes us unnecessary keeping unused clocks on, but in case of
the Gnawty that was breaking audio support since we were not using the
right clock in the cht_bsw_max98090_ti machine driver.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201787
Cc: stable@vger.kernel.org
Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Reported-and-tested-by: Jaime Pérez <19.jaime.91@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index ad0c98383853..08a5152e635a 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -396,6 +396,13 @@ static const struct dmi_system_id cht_max98090_quirk_table[] = {
 		},
 		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
 	},
+	{
+		/* Gnawty model Chromebook (Acer Chromebook CB3-111) */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Gnawty"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
 	{
 		/* Swanky model Chromebook (Toshiba Chromebook 2) */
 		.matches = {
-- 
2.19.0.rc2
