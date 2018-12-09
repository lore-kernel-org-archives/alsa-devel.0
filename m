From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/7] ALSA: hda: Make snd_hdac_display_power()
	void function
Date: Sun,  9 Dec 2018 10:33:16 +0100
Message-ID: <20181209093318.27829-6-tiwai@suse.de>
References: <20181209093318.27829-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DEA96267AB7
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2018 10:33:29 +0100 (CET)
In-Reply-To: <20181209093318.27829-1-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

After the recent refactoring, snd_hdac_display_power() doesn't return
any error, hence it can be defined to return void.
This makes many error checks redundant and allows us to reduce them
gracefully.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hda_component.h |  9 ++++----
 sound/hda/hdac_component.c    |  8 ++-----
 sound/pci/hda/hda_intel.c     |  9 +-------
 sound/soc/codecs/hdac_hdmi.c  | 21 +++++-------------
 sound/soc/intel/skylake/skl.c | 40 ++++++++++-------------------------
 5 files changed, 23 insertions(+), 64 deletions(-)

diff --git a/include/sound/hda_component.h b/include/sound/hda_component.h
index b78add315b1f..1916f4928bf3 100644
--- a/include/sound/hda_component.h
+++ b/include/sound/hda_component.h
@@ -10,8 +10,8 @@
 
 #ifdef CONFIG_SND_HDA_COMPONENT
 int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable);
-int snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx,
-			   bool enable);
+void snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx,
+			    bool enable);
 int snd_hdac_sync_audio_rate(struct hdac_device *codec, hda_nid_t nid,
 			     int dev_id, int rate);
 int snd_hdac_acomp_get_eld(struct hdac_device *codec, hda_nid_t nid, int dev_id,
@@ -28,10 +28,9 @@ static inline int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable)
 {
 	return 0;
 }
-static inline int snd_hdac_display_power(struct hdac_bus *bus,
-					 unsigned int idx, bool enable)
+static inline void snd_hdac_display_power(struct hdac_bus *bus,
+					  unsigned int idx, bool enable)
 {
-	return 0;
 }
 static inline int snd_hdac_sync_audio_rate(struct hdac_device *codec,
 					   hda_nid_t nid, int dev_id, int rate)
diff --git a/sound/hda/hdac_component.c b/sound/hda/hdac_component.c
index dd766414436b..a6d37b9d6413 100644
--- a/sound/hda/hdac_component.c
+++ b/sound/hda/hdac_component.c
@@ -62,10 +62,8 @@ EXPORT_SYMBOL_GPL(snd_hdac_set_codec_wakeup);
  *
  * This function updates the power status, and calls the get_power() and
  * put_power() ops accordingly, toggling the codec wakeup, too.
- *
- * Returns zero for success or a negative error code.
  */
-int snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx, bool enable)
+void snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx, bool enable)
 {
 	struct drm_audio_component *acomp = bus->audio_component;
 
@@ -77,7 +75,7 @@ int snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx, bool enable)
 		clear_bit(idx, &bus->display_power_status);
 
 	if (!acomp || !acomp->ops)
-		return 0;
+		return;
 
 	if (bus->display_power_status) {
 		if (!bus->display_power_active) {
@@ -94,8 +92,6 @@ int snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx, bool enable)
 			bus->display_power_active = false;
 		}
 	}
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_display_power);
 
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 48b29f02f72d..e89b8933b464 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2222,12 +2222,7 @@ static int azx_probe_continue(struct azx *chip)
 	 * this power. For other platforms, like Baytrail/Braswell, only the
 	 * display codec needs the power and it can be released after probe.
 	 */
-	err = display_power(chip, true);
-	if (err < 0) {
-		dev_err(chip->card->dev,
-			"Cannot turn on display power on i915\n");
-		goto i915_power_fail;
-	}
+	display_power(chip, true);
 
 	err = azx_first_init(chip);
 	if (err < 0)
@@ -2277,8 +2272,6 @@ static int azx_probe_continue(struct azx *chip)
 out_free:
 	if (err < 0 || !hda->need_i915_power)
 		display_power(chip, false);
-
-i915_power_fail:
 	if (err < 0)
 		hda->init_failed = 1;
 	complete_all(&hda->probe_wait);
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index c3d551d2af7f..adce94a3b289 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2031,13 +2031,8 @@ static int hdac_hdmi_dev_probe(struct hdac_device *hdev)
 	 * Turned off in the runtime_suspend during the first explicit
 	 * pm_runtime_suspend call.
 	 */
-	ret = snd_hdac_display_power(hdev->bus, hdev->addr, true);
-	if (ret < 0) {
-		dev_err(&hdev->dev,
-			"Cannot turn on display power on i915 err: %d\n",
-			ret);
-		return ret;
-	}
+	snd_hdac_display_power(hdev->bus, hdev->addr, true);
+
 	ret = hdac_hdmi_parse_and_map_nid(hdev, &hdmi_dais, &num_dais);
 	if (ret < 0) {
 		dev_err(&hdev->dev,
@@ -2195,11 +2190,9 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 
 	snd_hdac_ext_bus_link_put(bus, hlink);
 
-	err = snd_hdac_display_power(bus, hdev->addr, false);
-	if (err < 0)
-		dev_err(dev, "Cannot turn off display power on i915\n");
+	snd_hdac_display_power(bus, hdev->addr, false);
 
-	return err;
+	return 0;
 }
 
 static int hdac_hdmi_runtime_resume(struct device *dev)
@@ -2223,11 +2216,7 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 
 	snd_hdac_ext_bus_link_get(bus, hlink);
 
-	err = snd_hdac_display_power(bus, hdev->addr, true);
-	if (err < 0) {
-		dev_err(dev, "Cannot turn on display power on i915\n");
-		return err;
-	}
+	snd_hdac_display_power(bus, hdev->addr, true);
 
 	hdac_hdmi_skl_enable_all_pins(hdev);
 	hdac_hdmi_skl_enable_dp12(hdev);
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 64f8433ae921..5c224a0e1c7a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -311,7 +311,7 @@ static int skl_suspend(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_bus *bus = pci_get_drvdata(pci);
 	struct skl *skl  = bus_to_skl(bus);
-	int ret = 0;
+	int ret;
 
 	/*
 	 * Do not suspend if streams which are marked ignore suspend are
@@ -333,14 +333,10 @@ static int skl_suspend(struct device *dev)
 		skl->skl_sst->fw_loaded = false;
 	}
 
-	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-		ret = snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
-		if (ret < 0)
-			dev_err(bus->dev,
-				"Cannot turn OFF display power on i915\n");
-	}
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
+		snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
 
-	return ret;
+	return 0;
 }
 
 static int skl_resume(struct device *dev)
@@ -352,14 +348,8 @@ static int skl_resume(struct device *dev)
 	int ret;
 
 	/* Turned OFF in HDMI codec driver after codec reconfiguration */
-	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-		ret = snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
-		if (ret < 0) {
-			dev_err(bus->dev,
-				"Cannot turn on display power on i915\n");
-			return ret;
-		}
-	}
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
+		snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
 
 	/*
 	 * resume only when we are not in suspend active, otherwise need to
@@ -783,11 +773,9 @@ static int skl_i915_init(struct hdac_bus *bus)
 	if (err < 0)
 		return err;
 
-	err = snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
-	if (err < 0)
-		dev_err(bus->dev, "Cannot turn on display power on i915\n");
+	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
 
-	return err;
+	return 0;
 }
 
 static void skl_probe_work(struct work_struct *work)
@@ -837,14 +825,8 @@ static void skl_probe_work(struct work_struct *work)
 	list_for_each_entry(hlink, &bus->hlink_list, list)
 		snd_hdac_ext_bus_link_put(bus, hlink);
 
-	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-		err = snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
-		if (err < 0) {
-			dev_err(bus->dev, "Cannot turn off display power on i915\n");
-			skl_machine_device_unregister(skl);
-			return;
-		}
-	}
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
+		snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
 
 	/* configure PM */
 	pm_runtime_put_noidle(bus->dev);
@@ -855,7 +837,7 @@ static void skl_probe_work(struct work_struct *work)
 
 out_err:
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
-		err = snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
+		snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
 }
 
 /*
-- 
2.19.2
