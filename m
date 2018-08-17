From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v7 3/7] ASoC: Intel: Skylake: use HDAudio if
	ACPI enumeration fails
Date: Fri, 17 Aug 2018 15:37:19 -0500
Message-ID: <20180817203723.32305-4-pierre-louis.bossart@linux.intel.com>
References: <20180817203723.32305-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 317F226779C
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2018 22:37:30 +0200 (CEST)
In-Reply-To: <20180817203723.32305-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
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
 sound/soc/intel/skylake/skl.c | 38 ++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index dce649485649..c83194de4aed 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -472,6 +472,25 @@ static struct skl_ssp_clk skl_ssp_clks[] = {
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
+	/* point to common table */
+	mach = snd_soc_acpi_intel_hda_machines;
+
+	/* all entries in the machine table use the same firmware */
+	mach->fw_filename = machines->fw_filename;
+
+	return mach;
+}
+
 static int skl_find_machine(struct skl *skl, void *driver_data)
 {
 	struct hdac_bus *bus = skl_to_bus(skl);
@@ -479,9 +498,13 @@ static int skl_find_machine(struct skl *skl, void *driver_data)
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
@@ -498,8 +521,9 @@ static int skl_find_machine(struct skl *skl, void *driver_data)
 
 static int skl_machine_device_register(struct skl *skl)
 {
-	struct hdac_bus *bus = skl_to_bus(skl);
 	struct snd_soc_acpi_mach *mach = skl->mach;
+	struct hdac_bus *bus = skl_to_bus(skl);
+	struct skl_machine_pdata *pdata;
 	struct platform_device *pdev;
 	int ret;
 
@@ -516,8 +540,12 @@ static int skl_machine_device_register(struct skl *skl)
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
 
-- 
2.17.1
