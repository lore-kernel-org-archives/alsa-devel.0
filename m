From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v4 2/9] ASoC: Intel: Skylake: Add entry in
	sst_acpi_mach for HDA codecs
Date: Fri, 22 Dec 2017 18:22:45 +0530
Message-ID: <1513947172-28136-3-git-send-email-rakesh.a.ughreja@intel.com>
References: <1513947172-28136-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B449B267913
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 13:48:14 +0100 (CET)
In-Reply-To: <1513947172-28136-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

When no I2S based codecs are detected in the BIOS, check if there are
any HDA codecs present. If yes, load the corresponding machine driver.

TODO:
support for detecting the presence of HDA codec is not implemented.
it will be implemented in the next revision.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/soc/intel/skylake/skl.c | 46 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 6fc2173..b99c1d8 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -442,6 +442,26 @@ static struct skl_ssp_clk skl_ssp_clks[] = {
 						{.name = "ssp5_sclkfs"},
 };
 
+static struct snd_soc_acpi_mach *skl_probe_hda_machine(
+					struct snd_soc_acpi_mach *machines)
+{
+
+	struct snd_soc_acpi_mach *mach;
+
+	/*
+	 * FIXME:
+	 * First check if there are any HDA codecs present on the system
+	 * then search the match table.
+	 * For now this function is not detecting the presence of any
+	 * HDA codecs.
+	 */
+	for (mach = machines; mach->id[0]; mach++) {
+		if (!strcmp(mach->id, "HDA_GEN"))
+			return mach;
+	}
+	return NULL;
+}
+
 static int skl_machine_device_register(struct skl *skl, void *driver_data)
 {
 	struct hdac_bus *bus = skl_to_bus(skl);
@@ -451,9 +471,14 @@ static int skl_machine_device_register(struct skl *skl, void *driver_data)
 
 	mach = snd_soc_acpi_find_machine(mach);
 	if (mach == NULL) {
-		dev_err(bus->dev, "No matching machine driver found\n");
-		return -ENODEV;
+		dev_dbg(bus->dev, "No matching I2S machine driver found\n");
+		mach = skl_probe_hda_machine(driver_data);
+		if (mach == NULL) {
+			dev_err(bus->dev, "No matching machine driver found\n");
+			return -ENODEV;
+		}
 	}
+
 	skl->fw_name = mach->fw_filename;
 
 	pdev = platform_device_alloc(mach->drv_name, -1);
@@ -1005,6 +1030,14 @@ static struct snd_soc_acpi_mach sst_skl_devdata[] = {
 		.quirk_data = &skl_codecs,
 		.pdata = &skl_dmic_data
 	},
+	{
+		.id = "HDA_GEN",
+		.drv_name = "skl_hda_generic",
+		.fw_filename = "intel/dsp_fw_release.bin",
+		.machine_quirk = NULL,
+		.quirk_data = NULL,
+		.pdata = &cnl_pdata,
+	},
 	{}
 };
 
@@ -1067,7 +1100,14 @@ static struct snd_soc_acpi_mach sst_kbl_devdata[] = {
 		.drv_name = "kbl_rt5663",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
 	},
-
+	{
+		.id = "HDA_GEN",
+		.drv_name = "skl_hda_generic",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = NULL,
+		.quirk_data = NULL,
+		.pdata = &cnl_pdata,
+	},
 	{}
 };
 
-- 
2.7.4
