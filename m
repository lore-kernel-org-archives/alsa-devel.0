From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 08/10] ASoC: Intel: bytcr_rt5640: Use
	dmi_first_match() for DMI quirk handling
Date: Sun, 13 May 2018 09:24:33 +0200
Message-ID: <20180513072435.3358-9-hdegoede@redhat.com>
References: <20180513072435.3358-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id CC18D26767D
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 09:25:10 +0200 (CEST)
In-Reply-To: <20180513072435.3358-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Use dmi_first_match() instead of dmi_check_system() + callbacks, this
avoid the need to initialize dmi_system_id.callback for each
byt_rt5640_quirk_table entry.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 965721663749..0f80deaf7fce 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -395,16 +395,9 @@ static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 	return byt_rt5640_prepare_and_enable_pll1(dai, params_rate(params));
 }
 
-static int byt_rt5640_quirk_cb(const struct dmi_system_id *id)
-{
-	byt_rt5640_quirk = (unsigned long)id->driver_data;
-	return 1;
-}
-
 /* Please keep this list alphabetically sorted */
 static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
@@ -415,7 +408,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 
 	},
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
@@ -427,7 +419,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_MCLK_EN),
 	},
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
@@ -439,7 +430,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_MCLK_EN),
 	},
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
@@ -447,7 +437,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP),
 	},
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5830"),
@@ -460,7 +449,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_MCLK_EN),
 	},
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP ElitePad 1000 G2"),
@@ -469,7 +457,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_MCLK_EN),
 	},
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "TECLAST"),
 			DMI_MATCH(DMI_BOARD_NAME, "tPAD"),
@@ -479,7 +466,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1),
 	},
 	{	/* Catch-all for generic Insyde tablets, must be last */
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
 		},
@@ -894,6 +880,7 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
+	const struct dmi_system_id *dmi_id;
 	struct byt_rt5640_private *priv;
 	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
@@ -996,7 +983,9 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	}
 
 	/* check quirks before creating card */
-	dmi_check_system(byt_rt5640_quirk_table);
+	dmi_id = dmi_first_match(byt_rt5640_quirk_table);
+	if (dmi_id)
+		byt_rt5640_quirk = (unsigned long)dmi_id->driver_data;
 	if (quirk_override) {
 		dev_info(&pdev->dev, "Overriding quirk 0x%x => 0x%x\n",
 			 (unsigned int)byt_rt5640_quirk, quirk_override);
-- 
2.17.0
