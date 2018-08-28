From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: use HDAudio if ACPI
	enumeration fails" to the asoc tree
Date: Tue, 28 Aug 2018 21:34:59 +0100 (BST)
Message-ID: <20180828203459.85C9D440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E2B626779D
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 22:35:02 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: use HDAudio if ACPI enumeration fails

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

>From 9cdae4352cba3f66d39a4ef78bb726940ae1e513 Mon Sep 17 00:00:00 2001
From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Date: Wed, 22 Aug 2018 15:25:00 -0500
Subject: [PATCH] ASoC: Intel: Skylake: use HDAudio if ACPI enumeration fails

When no I2S based codec entries are found in the BIOS, check if there are
any HDA codecs detected on the bus. Based on the number of codecs found
take appropriate action in machine driver. If there are two HDA codecs
i.e. iDisp + HDA found on the bus, register DAIs and DAI links for both.
If only one codec i.e. iDisp is found then load only iDisp machine driver.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 38 ++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index cf09721ca13e..3b836125d1de 100644
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
2.18.0
