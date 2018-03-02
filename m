From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [PATCH v2 03/10] ASoC: Intel: Skylake: Add entry in
	sst_acpi_mach for HDA codecs
Date: Fri,  2 Mar 2018 16:22:31 +0530
Message-ID: <1519987958-5482-4-git-send-email-rakesh.a.ughreja@intel.com>
References: <1519987958-5482-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AD1AD267D10
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 11:50:19 +0100 (CET)
In-Reply-To: <1519987958-5482-1-git-send-email-rakesh.a.ughreja@intel.com>
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

When no I2S based codec entries are found in the BIOS, check if there are
any HDA codecs detected on the bus. Based on the number of codecs found
take appropriate action in machine driver. If there are two HDA codecs
i.e. iDisp + HDA found on the bus, register DAIs and DAI links for both.
If only one codec i.e. iDisp is found then load only iDisp machine driver.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/soc/intel/skylake/skl.c | 60 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index f948f29..e7f048c 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -442,6 +442,24 @@ static struct skl_ssp_clk skl_ssp_clks[] = {
 						{.name = "ssp5_sclkfs"},
 };
 
+static struct snd_soc_acpi_mach *skl_find_hda_machine(struct skl *skl,
+					struct snd_soc_acpi_mach *machines)
+{
+
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
@@ -450,8 +468,12 @@ static int skl_find_machine(struct skl *skl, void *driver_data)
 
 	mach = snd_soc_acpi_find_machine(mach);
 	if (mach == NULL) {
-		dev_err(bus->dev, "No matching machine driver found\n");
-		return -ENODEV;
+		dev_dbg(bus->dev, "No matching I2S machine driver found\n");
+		mach = skl_find_hda_machine(skl, driver_data);
+		if (mach == NULL) {
+			dev_err(bus->dev, "No matching machine driver found\n");
+			return -ENODEV;
+		}
 	}
 
 	skl->mach = mach;
@@ -466,8 +488,9 @@ static int skl_find_machine(struct skl *skl, void *driver_data)
 
 static int skl_machine_device_register(struct skl *skl)
 {
-	struct hdac_bus *bus = skl_to_bus(skl);
 	struct snd_soc_acpi_mach *mach = skl->mach;
+	struct hdac_bus *bus = skl_to_bus(skl);
+	struct skl_machine_pdata *pdata;
 	struct platform_device *pdev;
 	int ret;
 
@@ -484,8 +507,12 @@ static int skl_machine_device_register(struct skl *skl)
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
 
@@ -1030,6 +1057,14 @@ static struct snd_soc_acpi_mach sst_skl_devdata[] = {
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
 
@@ -1046,6 +1081,14 @@ static struct snd_soc_acpi_mach sst_bxtp_devdata[] = {
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
 
@@ -1100,7 +1143,14 @@ static struct snd_soc_acpi_mach sst_kbl_devdata[] = {
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
2.7.4
