From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 1/2] ASoC: Intel: Skylake: Move i915
	registration to worker thread
Date: Thu,  4 May 2017 14:09:10 +0530
Message-ID: <1493887151-508-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A0F1A26684C
 for <alsa-devel@alsa-project.org>; Thu,  4 May 2017 10:52:51 +0200 (CEST)
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Sodhi, VunnyX" <vunnyx.sodhi@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

The i915 component framework expects the caller to be invoking
snd_hdac_i915_init() from a thread context. Otherwise it results in
lockups on drm side.

So move the registering of component interface and probing of codecs on
this bus to a worker thread.

init_failed in skl structure is not used currently, so renamed to
init_done and used to track the initialization done in worker thread.

Reported-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sodhi, VunnyX <vunnyx.sodhi@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
v1->v2
   - no change

 sound/soc/intel/skylake/skl.c | 162 +++++++++++++++++++++++-------------------
 sound/soc/intel/skylake/skl.h |   4 +-
 2 files changed, 91 insertions(+), 75 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 6df3b317a476..4c9b5781282b 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -410,7 +410,7 @@ static int skl_free(struct hdac_ext_bus *ebus)
 	struct skl *skl  = ebus_to_skl(ebus);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 
-	skl->init_failed = 1; /* to be sure */
+	skl->init_done = 0; /* to be sure */
 
 	snd_hdac_ext_stop_streams(ebus);
 
@@ -428,8 +428,10 @@ static int skl_free(struct hdac_ext_bus *ebus)
 
 	snd_hdac_ext_bus_exit(ebus);
 
+	cancel_work_sync(&skl->probe_work);
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
 		snd_hdac_i915_exit(&ebus->bus);
+
 	return 0;
 }
 
@@ -566,6 +568,84 @@ static int skl_codec_create(struct hdac_ext_bus *ebus)
 	.get_response = snd_hdac_bus_get_response,
 };
 
+static int skl_i915_init(struct hdac_bus *bus)
+{
+	int err;
+
+	/*
+	 * The HDMI codec is in GPU so we need to ensure that it is powered
+	 * up and ready for probe
+	 */
+	err = snd_hdac_i915_init(bus);
+	if (err < 0)
+		return err;
+
+	err = snd_hdac_display_power(bus, true);
+	if (err < 0)
+		dev_err(bus->dev, "Cannot turn on display power on i915\n");
+
+	return err;
+}
+
+static void skl_probe_work(struct work_struct *work)
+{
+	struct skl *skl = container_of(work, struct skl, probe_work);
+	struct hdac_ext_bus *ebus = &skl->ebus;
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_ext_link *hlink = NULL;
+	int err;
+
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
+		err = skl_i915_init(bus);
+		if (err < 0)
+			return;
+	}
+
+	err = skl_init_chip(bus, true);
+	if (err < 0) {
+		dev_err(bus->dev, "Init chip failed with err: %d\n", err);
+		goto out_err;
+	}
+
+	/* codec detection */
+	if (!bus->codec_mask)
+		dev_info(bus->dev, "no hda codecs found!\n");
+
+	/* create codec instances */
+	err = skl_codec_create(ebus);
+	if (err < 0)
+		goto out_err;
+
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
+		err = snd_hdac_display_power(bus, false);
+		if (err < 0) {
+			dev_err(bus->dev, "Cannot turn off display power on i915\n");
+			return;
+		}
+	}
+
+	/* register platform dai and controls */
+	err = skl_platform_register(bus->dev);
+	if (err < 0)
+		return;
+	/*
+	 * we are done probing so decrement link counts
+	 */
+	list_for_each_entry(hlink, &ebus->hlink_list, list)
+		snd_hdac_ext_bus_link_put(ebus, hlink);
+
+	/* configure PM */
+	pm_runtime_put_noidle(bus->dev);
+	pm_runtime_allow(bus->dev);
+	skl->init_done = 1;
+
+	return;
+
+out_err:
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
+		err = snd_hdac_display_power(bus, false);
+}
+
 /*
  * constructor
  */
@@ -593,6 +673,7 @@ static int skl_create(struct pci_dev *pci,
 	snd_hdac_ext_bus_init(ebus, &pci->dev, &bus_core_ops, io_ops);
 	ebus->bus.use_posbuf = 1;
 	skl->pci = pci;
+	INIT_WORK(&skl->probe_work, skl_probe_work);
 
 	ebus->bus.bdl_pos_adj = 0;
 
@@ -601,27 +682,6 @@ static int skl_create(struct pci_dev *pci,
 	return 0;
 }
 
-static int skl_i915_init(struct hdac_bus *bus)
-{
-	int err;
-
-	/*
-	 * The HDMI codec is in GPU so we need to ensure that it is powered
-	 * up and ready for probe
-	 */
-	err = snd_hdac_i915_init(bus);
-	if (err < 0)
-		return err;
-
-	err = snd_hdac_display_power(bus, true);
-	if (err < 0) {
-		dev_err(bus->dev, "Cannot turn on display power on i915\n");
-		return err;
-	}
-
-	return err;
-}
-
 static int skl_first_init(struct hdac_ext_bus *ebus)
 {
 	struct skl *skl = ebus_to_skl(ebus);
@@ -684,20 +744,7 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 	/* initialize chip */
 	skl_init_pci(skl);
 
-	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-		err = skl_i915_init(bus);
-		if (err < 0)
-			return err;
-	}
-
-	skl_init_chip(bus, true);
-
-	/* codec detection */
-	if (!bus->codec_mask) {
-		dev_info(bus->dev, "no hda codecs found!\n");
-	}
-
-	return 0;
+	return skl_init_chip(bus, true);
 }
 
 static int skl_probe(struct pci_dev *pci,
@@ -706,7 +753,6 @@ static int skl_probe(struct pci_dev *pci,
 	struct skl *skl;
 	struct hdac_ext_bus *ebus = NULL;
 	struct hdac_bus *bus = NULL;
-	struct hdac_ext_link *hlink = NULL;
 	int err;
 
 	/* we use ext core ops, so provide NULL for ops here */
@@ -729,7 +775,7 @@ static int skl_probe(struct pci_dev *pci,
 
 	if (skl->nhlt == NULL) {
 		err = -ENODEV;
-		goto out_display_power_off;
+		goto out_free;
 	}
 
 	err = skl_nhlt_create_sysfs(skl);
@@ -760,56 +806,24 @@ static int skl_probe(struct pci_dev *pci,
 	if (bus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(ebus);
 
+	snd_hdac_bus_stop_chip(bus);
+
 	/* create device for soc dmic */
 	err = skl_dmic_device_register(skl);
 	if (err < 0)
 		goto out_dsp_free;
 
-	/* register platform dai and controls */
-	err = skl_platform_register(bus->dev);
-	if (err < 0)
-		goto out_dmic_free;
-
-	/* create codec instances */
-	err = skl_codec_create(ebus);
-	if (err < 0)
-		goto out_unregister;
-
-	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-		err = snd_hdac_display_power(bus, false);
-		if (err < 0) {
-			dev_err(bus->dev, "Cannot turn off display power on i915\n");
-			return err;
-		}
-	}
-
-	/*
-	 * we are done probling so decrement link counts
-	 */
-	list_for_each_entry(hlink, &ebus->hlink_list, list)
-		snd_hdac_ext_bus_link_put(ebus, hlink);
-
-	/* configure PM */
-	pm_runtime_put_noidle(bus->dev);
-	pm_runtime_allow(bus->dev);
+	schedule_work(&skl->probe_work);
 
 	return 0;
 
-out_unregister:
-	skl_platform_unregister(bus->dev);
-out_dmic_free:
-	skl_dmic_device_unregister(skl);
 out_dsp_free:
 	skl_free_dsp(skl);
 out_mach_free:
 	skl_machine_device_unregister(skl);
 out_nhlt_free:
 	skl_nhlt_free(skl->nhlt);
-out_display_power_off:
-	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
-		snd_hdac_display_power(bus, false);
 out_free:
-	skl->init_failed = 1;
 	skl_free(ebus);
 
 	return err;
@@ -828,7 +842,7 @@ static void skl_shutdown(struct pci_dev *pci)
 
 	skl = ebus_to_skl(ebus);
 
-	if (skl->init_failed)
+	if (!skl->init_done)
 		return;
 
 	snd_hdac_ext_stop_streams(ebus);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 5b3fa4b91691..c1968a06174a 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -67,7 +67,7 @@ struct skl {
 	struct hdac_ext_bus ebus;
 	struct pci_dev *pci;
 
-	unsigned int init_failed:1; /* delayed init failed */
+	unsigned int init_done:1; /* delayed init status */
 	struct platform_device *dmic_dev;
 	struct platform_device *i2s_dev;
 	struct snd_soc_platform *platform;
@@ -85,6 +85,8 @@ struct skl {
 	const struct firmware *tplg;
 
 	int supend_active;
+
+	struct work_struct probe_work;
 };
 
 #define skl_to_ebus(s)	(&(s)->ebus)
-- 
1.9.1
