From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 05/13] ASoC: Intel: Skylake: Add entry in
	sst_acpi_mach for HDA codecs
Date: Fri,  1 Jun 2018 22:53:53 -0500
Message-ID: <20180602035401.26934-6-pierre-louis.bossart@linux.intel.com>
References: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id F2212267846
 for <alsa-devel@alsa-project.org>; Sat,  2 Jun 2018 05:54:15 +0200 (CEST)
In-Reply-To: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, rakesh.a.ughreja@intel.com
List-Id: alsa-devel@alsa-project.org

From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>

When no I2S based codec entries are found in the BIOS, check if there are
any HDA codecs detected on the bus. Based on the number of codecs found
take appropriate action in machine driver. If there are two HDA codecs
i.e. iDisp + HDA found on the bus, register DAIs and DAI links for both.
If only one codec i.e. iDisp is found then load only iDisp machine driver.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl.c | 61 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 9c5a701d68ac..e5b2fc44f56a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -473,6 +473,23 @@ static struct skl_ssp_clk skl_ssp_clks[] = {
 						{.name = "ssp5_sclkfs"},
 };
 
+static struct snd_soc_acpi_mach *skl_find_hda_machine(struct skl *skl,
+					struct snd_soc_acpi_mach *machines)
+{
+	struct hdac_bus *bus = skl_to_bus(skl);
+	struct snd_soc_acpi_mach *mach;
+
+	/* check if we have any codecs detected on bus */
+	if (bus->codec_mask == 0)
+		return NULL;
+
+	for (mach = machines; mach->id[0]; mach++) {
+		if (!strcmp(mach->id, "HDA_GEN"))
+			return mach;
+	}
+	return NULL;
+}
+
 static int skl_find_machine(struct skl *skl, void *driver_data)
 {
 	struct hdac_bus *bus = skl_to_bus(skl);
@@ -480,9 +497,13 @@ static int skl_find_machine(struct skl *skl, void *driver_data)
 	struct skl_machine_pdata *pdata;
 
 	mach = snd_soc_acpi_find_machine(mach);
-	if (mach == NULL) {
-		dev_err(bus->dev, "No matching machine driver found\n");
-		return -ENODEV;
+	if (!mach) {
+		dev_dbg(bus->dev, "No matching I2S machine driver found\n");
+		mach = skl_find_hda_machine(skl, driver_data);
+		if (!mach) {
+			dev_err(bus->dev, "No matching machine driver found\n");
+			return -ENODEV;
+		}
 	}
 
 	skl->mach = mach;
@@ -497,8 +518,9 @@ static int skl_find_machine(struct skl *skl, void *driver_data)
 
 static int skl_machine_device_register(struct skl *skl)
 {
-	struct hdac_bus *bus = skl_to_bus(skl);
 	struct snd_soc_acpi_mach *mach = skl->mach;
+	struct hdac_bus *bus = skl_to_bus(skl);
+	struct skl_machine_pdata *pdata;
 	struct platform_device *pdev;
 	int ret;
 
@@ -515,8 +537,12 @@ static int skl_machine_device_register(struct skl *skl)
 		return -EIO;
 	}
 
-	if (mach->pdata)
+	if (mach->pdata) {
+		pdata = (struct skl_machine_pdata *)mach->pdata;
+		pdata->platform = dev_name(bus->dev);
+		pdata->codec_mask = bus->codec_mask;
 		dev_set_drvdata(&pdev->dev, mach->pdata);
+	}
 
 	skl->i2s_dev = pdev;
 
@@ -1062,6 +1088,14 @@ static struct snd_soc_acpi_mach sst_skl_devdata[] = {
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
 
@@ -1078,6 +1112,14 @@ static struct snd_soc_acpi_mach sst_bxtp_devdata[] = {
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &bxt_codecs,
 	},
+	{
+		.id = "HDA_GEN",
+		.drv_name = "skl_hda_generic",
+		.fw_filename = "intel/dsp_fw_bxtn.bin",
+		.machine_quirk = NULL,
+		.quirk_data = NULL,
+		.pdata = &cnl_pdata,
+	},
 	{}
 };
 
@@ -1132,7 +1174,14 @@ static struct snd_soc_acpi_mach sst_kbl_devdata[] = {
 		.quirk_data = &kbl_7219_98357_codecs,
 		.pdata = &skl_dmic_data
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
2.14.1
