From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Skylake: Ensure dai and
	dailink registration happens in sequence.
Date: Mon, 18 Dec 2017 10:46:50 +0530
Message-ID: <20171218051650.7027-2-guneshwor.o.singh@intel.com>
References: <20171218051650.7027-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BB48267475
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 06:16:45 +0100 (CET)
In-Reply-To: <20171218051650.7027-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>

Platform registration happens in probe work handler whereas machine
device is registered during skl_probe. This sometimes results in cpu
dais not found if the work handler is sufficiently delayed due to system
load, even with deferred probe of machine driver.

So move machine device registration after registering platform.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl.c | 56 +++++++++++++++++++++++++++++--------------
 sound/soc/intel/skylake/skl.h |  1 +
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 90cc207869c7..90c2f0a96ab4 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -476,19 +476,34 @@ static struct skl_ssp_clk skl_ssp_clks[] = {
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
@@ -503,11 +518,8 @@ static int skl_machine_device_register(struct skl *skl, void *driver_data)
 		return -EIO;
 	}
 
-	if (mach->pdata) {
-		skl->use_tplg_pcm =
-			((struct skl_machine_pdata *)mach->pdata)->use_tplg_pcm;
+	if (mach->pdata)
 		dev_set_drvdata(&pdev->dev, mach->pdata);
-	}
 
 	skl->i2s_dev = pdev;
 
@@ -724,18 +736,30 @@ static void skl_probe_work(struct work_struct *work)
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
@@ -905,18 +929,16 @@ static int skl_probe(struct pci_dev *pci,
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
@@ -934,8 +956,6 @@ static int skl_probe(struct pci_dev *pci,
 
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
