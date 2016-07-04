From: Stephen Just <stephenjust@gmail.com>
Subject: [PATCH 2/3] ASoC: Intel: Atom: add quirk for CHT w/
	RT5645
Date: Sun,  3 Jul 2016 23:06:06 -0600
Message-ID: <20160704050607.32213-3-stephenjust@gmail.com>
References: <20160704045655.31198-1-stephenjust@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160704045655.31198-1-stephenjust@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Stephen Just <stephenjust@gmail.com>
List-Id: alsa-devel@alsa-project.org

The Surface 3 uses an RT5645 audio codec, but the ACPI
identifier used is that for the RT5640. Use a DMI match
to override the driver_data provided by ACPI to workaround
ID conflict.

Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Stephen Just <stephenjust@gmail.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c     | 29 ++++++++++++++++++++++++++++-
 sound/soc/intel/boards/cht_bsw_rt5645.c |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 3bc4b63..ef40608 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/dmi.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
@@ -131,6 +132,8 @@ static struct sst_platform_info chv_platform_data = {
 	.platform = "sst-mfld-platform",
 };
 
+static const struct dmi_system_id dmi_platform_quirk_table[];
+
 static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 {
 	struct resource *rsrc;
@@ -224,6 +227,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	struct platform_device *mdev;
 	struct platform_device *plat_dev;
 	struct sst_platform_info *pdata;
+	const struct dmi_system_id *dmi_match;
 	unsigned int dev_id;
 
 	id = acpi_match_device(dev->driver->acpi_match_table, dev);
@@ -231,7 +235,13 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	dev_dbg(dev, "for %s", id->id);
 
-	mach = (struct sst_acpi_mach *)id->driver_data;
+	/* check for quirk when getting driver_data */
+	dmi_match = dmi_first_match(dmi_platform_quirk_table);
+	if (dmi_match)
+		mach = (struct sst_acpi_mach *)dmi_match->driver_data;
+	else
+		mach = (struct sst_acpi_mach *)id->driver_data;
+
 	mach = sst_acpi_find_machine(mach);
 	if (mach == NULL) {
 		dev_err(dev, "No matching machine driver found\n");
@@ -345,7 +355,24 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
 	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", NULL,
 						&chv_platform_data },
+	{},
+};
 
+static struct sst_acpi_mach sst_acpi_chv_quirk[] = {
+	/* some CHT-T platforms rely on RT5645 but use the ID from RT5640 */
+	{"10EC5640", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
+						&chv_platform_data },
+	{},
+};
+
+static const struct dmi_system_id dmi_platform_quirk_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
+		},
+		.driver_data = (unsigned long *) &sst_acpi_chv_quirk,
+	},
 	{},
 };
 
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index d7ef292..bf99efb 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -340,6 +340,7 @@ static struct snd_soc_card snd_soc_card_chtrt5650 = {
 };
 
 static struct cht_acpi_card snd_soc_cards[] = {
+	{"10EC5640", CODEC_TYPE_RT5645, &snd_soc_card_chtrt5645},
 	{"10EC5645", CODEC_TYPE_RT5645, &snd_soc_card_chtrt5645},
 	{"10EC5650", CODEC_TYPE_RT5650, &snd_soc_card_chtrt5650},
 };
-- 
2.7.4
