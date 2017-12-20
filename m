From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Ensure dai and dailink
	registration happens in sequence." to the asoc tree
Date: Wed, 20 Dec 2017 10:50:19 +0000
Message-ID: <E1eRbx5-0007JZ-1n@debutante>
References: <20171218051650.7027-2-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 35DC32677C7
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 11:50:41 +0100 (CET)
In-Reply-To: <20171218051650.7027-2-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Ensure dai and dailink registration happens in sequence.

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

>From 752c93aa72e60ba573bbcfcd508b9cc550db0b94 Mon Sep 17 00:00:00 2001
From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Date: Mon, 18 Dec 2017 10:46:50 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Ensure dai and dailink registration
 happens in sequence.

Platform registration happens in probe work handler whereas machine
device is registered during skl_probe. This sometimes results in cpu
dais not found if the work handler is sufficiently delayed due to system
load, even with deferred probe of machine driver.

So move machine device registration after registering platform.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 56 +++++++++++++++++++++++++++++--------------
 sound/soc/intel/skylake/skl.h |  1 +
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index a89592b2850e..32ce64c6b2dc 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -453,19 +453,34 @@ static struct skl_ssp_clk skl_ssp_clks[] = {
 						{.name = "ssp5_sclkfs"},
 };
 
-static int skl_machine_device_register(struct skl *skl, void *driver_data)
+static int skl_find_machine(struct skl *skl, void *driver_data)
 {
-	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
-	struct platform_device *pdev;
 	struct snd_soc_acpi_mach *mach = driver_data;
-	int ret;
+	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
+	struct skl_machine_pdata *pdata;
 
 	mach = snd_soc_acpi_find_machine(mach);
 	if (mach == NULL) {
 		dev_err(bus->dev, "No matching machine driver found\n");
 		return -ENODEV;
 	}
+
+	skl->mach = mach;
 	skl->fw_name = mach->fw_filename;
+	pdata = skl->mach->pdata;
+
+	if (mach->pdata)
+		skl->use_tplg_pcm = pdata->use_tplg_pcm;
+
+	return 0;
+}
+
+static int skl_machine_device_register(struct skl *skl)
+{
+	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
+	struct snd_soc_acpi_mach *mach = skl->mach;
+	struct platform_device *pdev;
+	int ret;
 
 	pdev = platform_device_alloc(mach->drv_name, -1);
 	if (pdev == NULL) {
@@ -480,11 +495,8 @@ static int skl_machine_device_register(struct skl *skl, void *driver_data)
 		return -EIO;
 	}
 
-	if (mach->pdata) {
-		skl->use_tplg_pcm =
-			((struct skl_machine_pdata *)mach->pdata)->use_tplg_pcm;
+	if (mach->pdata)
 		dev_set_drvdata(&pdev->dev, mach->pdata);
-	}
 
 	skl->i2s_dev = pdev;
 
@@ -701,18 +713,30 @@ static void skl_probe_work(struct work_struct *work)
 	/* create codec instances */
 	skl_codec_create(ebus);
 
+	/* register platform dai and controls */
+	err = skl_platform_register(bus->dev);
+	if (err < 0) {
+		dev_err(bus->dev, "platform register failed: %d\n", err);
+		return;
+	}
+
+	if (bus->ppcap) {
+		err = skl_machine_device_register(skl);
+		if (err < 0) {
+			dev_err(bus->dev, "machine register failed: %d\n", err);
+			goto out_err;
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
 		err = snd_hdac_display_power(bus, false);
 		if (err < 0) {
 			dev_err(bus->dev, "Cannot turn off display power on i915\n");
+			skl_machine_device_unregister(skl);
 			return;
 		}
 	}
 
-	/* register platform dai and controls */
-	err = skl_platform_register(bus->dev);
-	if (err < 0)
-		return;
 	/*
 	 * we are done probing so decrement link counts
 	 */
@@ -882,18 +906,16 @@ static int skl_probe(struct pci_dev *pci,
 		if (err < 0)
 			goto out_clk_free;
 
-		err = skl_machine_device_register(skl,
-				  (void *)pci_id->driver_data);
+		err = skl_find_machine(skl, (void *)pci_id->driver_data);
 		if (err < 0)
 			goto out_nhlt_free;
 
 		err = skl_init_dsp(skl);
 		if (err < 0) {
 			dev_dbg(bus->dev, "error failed to register dsp\n");
-			goto out_mach_free;
+			goto out_nhlt_free;
 		}
 		skl->skl_sst->enable_miscbdcge = skl_enable_miscbdcge;
-
 	}
 	if (bus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(ebus);
@@ -911,8 +933,6 @@ static int skl_probe(struct pci_dev *pci,
 
 out_dsp_free:
 	skl_free_dsp(skl);
-out_mach_free:
-	skl_machine_device_unregister(skl);
 out_clk_free:
 	skl_clock_device_unregister(skl);
 out_nhlt_free:
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 46dda88ba139..f411579bc713 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -94,6 +94,7 @@ struct skl {
 	struct skl_module **modules;
 	bool use_tplg_pcm;
 	struct skl_fw_config cfg;
+	struct snd_soc_acpi_mach *mach;
 };
 
 #define skl_to_ebus(s)	(&(s)->ebus)
-- 
2.15.1
