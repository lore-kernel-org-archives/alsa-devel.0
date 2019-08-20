From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: cht_bsw_max98090_ti: Add all Chromebooks that need pmc_plt_clk_0 quirk" to the asoc tree
Date: Tue, 20 Aug 2019 18:41:06 +0100 (BST)
Message-ID: <20190820174106.6E99D274314F@ypsilon.sirena.org.uk>
References: <20190815171300.30126-1-daniel.stuart14@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815171300.30126-1-daniel.stuart14@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Stuart <daniel.stuart14@gmail.com>
Cc: alsa-devel@alsa-project.org, "Cc:"@sirena.co.uk"Cc:"@sirena.co.uk, cezary.rojewski@intel.com, Daniel Stuart <daniel.stuart@pucpr.edu.br>, Hans de Goede <hdegoede@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Jie Yang <yang.jie@linux.intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: cht_bsw_max98090_ti: Add all Chromebooks that need pmc_plt_clk_0 quirk

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From d5e120422db8808e1c8b1507900ca393a877c58f Mon Sep 17 00:00:00 2001
From: Daniel Stuart <daniel.stuart14@gmail.com>
Date: Thu, 15 Aug 2019 14:12:55 -0300
Subject: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Add all Chromebooks that
 need pmc_plt_clk_0 quirk

Every single baytrail chromebook sets PMC to 0, as can be seeing
below by searching through coreboot source code:
	$ grep -rl "PMC_PLT_CLK\[0\]" .
	./rambi/variants/glimmer/devicetree.cb
	./rambi/variants/clapper/devicetree.cb
	./rambi/variants/swanky/devicetree.cb
	./rambi/variants/enguarde/devicetree.cb
	./rambi/variants/winky/devicetree.cb
	./rambi/variants/kip/devicetree.cb
	./rambi/variants/squawks/devicetree.cb
	./rambi/variants/orco/devicetree.cb
	./rambi/variants/ninja/devicetree.cb
	./rambi/variants/heli/devicetree.cb
	./rambi/variants/sumo/devicetree.cb
	./rambi/variants/banjo/devicetree.cb
	./rambi/variants/candy/devicetree.cb
	./rambi/variants/gnawty/devicetree.cb
	./rambi/variants/rambi/devicetree.cb
	./rambi/variants/quawks/devicetree.cb

Plus, Cyan (only non-baytrail chromebook with max98090) also needs
this patch for audio to work.

Thus, this commit adds all the missing devices to bsw_max98090 quirk
table, implemented by commit a182ecd3809c ("ASoC: intel:
cht_bsw_max98090_ti: Add quirk for boards using pmc_plt_clk_0").

Signed-off-by: Daniel Stuart <daniel.stuart14@gmail.com>
Link: https://lore.kernel.org/r/20190815171300.30126-1-daniel.stuart14@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 98 ++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 1db9a95e6a79..eaf3e2208a06 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -398,6 +398,20 @@ static struct snd_soc_card snd_soc_card_cht = {
 };
 
 static const struct dmi_system_id cht_max98090_quirk_table[] = {
+	{
+		/* Banjo model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Banjo"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Candy model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Candy"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
 	{
 		/* Clapper model Chromebook */
 		.matches = {
@@ -405,6 +419,27 @@ static const struct dmi_system_id cht_max98090_quirk_table[] = {
 		},
 		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
 	},
+	{
+		/* Cyan model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Cyan"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Enguarde model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Enguarde"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Glimmer model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Glimmer"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
 	{
 		/* Gnawty model Chromebook (Acer Chromebook CB3-111) */
 		.matches = {
@@ -412,6 +447,62 @@ static const struct dmi_system_id cht_max98090_quirk_table[] = {
 		},
 		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
 	},
+	{
+		/* Heli model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Heli"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Kip model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Kip"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Ninja model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Ninja"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Orco model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Orco"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Quawks model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Quawks"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Rambi model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Rambi"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Squawks model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Squawks"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Sumo model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Sumo"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
 	{
 		/* Swanky model Chromebook (Toshiba Chromebook 2) */
 		.matches = {
@@ -419,6 +510,13 @@ static const struct dmi_system_id cht_max98090_quirk_table[] = {
 		},
 		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
 	},
+	{
+		/* Winky model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Winky"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
 	{}
 };
 
-- 
2.20.1
