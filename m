From: han.lu@intel.com
Subject: [PATCH 1/1] HDA: Intel: enable automatic runtime pm
	for HDMI codecs by default
Date: Tue,  9 Jun 2015 16:15:10 +0800
Message-ID: <1433837710-5087-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 32ADE264F47
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 10:17:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, daniel.vetter@intel.com
Cc: "Lu, Han" <han.lu@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Enable runtime PM of the HDMI audio codec on the latest Intel platforms.
So the HD-A controller or HDMI codec can suspend when idle timeout by
default and release the GFX power well.
The patch influences HSW/BDW/BYT/BSW/SKL. Eariler platforms and third
party analog codecs will not be influenced.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 54380ed..804ec24 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3491,10 +3491,13 @@ int snd_hda_add_new_ctls(struct hda_codec *codec,
 EXPORT_SYMBOL_GPL(snd_hda_add_new_ctls);
 
 #ifdef CONFIG_PM
-static void codec_set_power_save(struct hda_codec *codec, int delay)
+static void codec_set_power_save(struct hda_codec *codec, int delay, bool force)
 {
 	struct device *dev = hda_codec_dev(codec);
 
+	if (force && delay == 0 && codec->auto_runtime_pm)
+		delay = 3000;
+
 	if (delay > 0) {
 		pm_runtime_set_autosuspend_delay(dev, delay);
 		pm_runtime_use_autosuspend(dev);
@@ -3511,15 +3514,16 @@ static void codec_set_power_save(struct hda_codec *codec, int delay)
  * snd_hda_set_power_save - reprogram autosuspend for the given delay
  * @bus: HD-audio bus
  * @delay: autosuspend delay in msec, 0 = off
+ * @force: force to enable autosuspend
  *
  * Synchronize the runtime PM autosuspend state from the power_save option.
  */
-void snd_hda_set_power_save(struct hda_bus *bus, int delay)
+void snd_hda_set_power_save(struct hda_bus *bus, int delay, bool force)
 {
 	struct hda_codec *c;
 
 	list_for_each_codec(c, bus)
-		codec_set_power_save(c, delay);
+		codec_set_power_save(c, delay, force);
 }
 EXPORT_SYMBOL_GPL(snd_hda_set_power_save);
 
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 6c57258..9f525ba 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -251,6 +251,7 @@ struct hda_codec {
 	unsigned int dp_mst:1; /* support DP1.2 Multi-stream transport */
 	unsigned int dump_coef:1; /* dump processing coefs in codec proc file */
 	unsigned int power_save_node:1; /* advanced PM for each widget */
+	unsigned int auto_runtime_pm:1; /* enable automatic codec runtime pm */
 #ifdef CONFIG_PM
 	unsigned long power_on_acct;
 	unsigned long power_off_acct;
@@ -482,10 +483,11 @@ const char *snd_hda_get_jack_location(u32 cfg);
 #define snd_hda_power_down(codec)	snd_hdac_power_down(&(codec)->core)
 #define snd_hda_power_down_pm(codec)	snd_hdac_power_down_pm(&(codec)->core)
 #ifdef CONFIG_PM
-void snd_hda_set_power_save(struct hda_bus *bus, int delay);
+void snd_hda_set_power_save(struct hda_bus *bus, int delay, bool force);
 void snd_hda_update_power_acct(struct hda_codec *codec);
 #else
-static inline void snd_hda_set_power_save(struct hda_bus *bus, int delay) {}
+static inline void
+snd_hda_set_power_save(struct hda_bus *bus, int delay, bool force) {}
 #endif
 
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 7933fb0..11d52e5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -797,7 +797,7 @@ static int param_set_xint(const char *val, const struct kernel_param *kp)
 		chip = &hda->chip;
 		if (!hda->probe_continued || chip->disabled)
 			continue;
-		snd_hda_set_power_save(&chip->bus, power_save * 1000);
+		snd_hda_set_power_save(&chip->bus, power_save * 1000, false);
 	}
 	mutex_unlock(&card_list_lock);
 	return 0;
@@ -2034,7 +2034,7 @@ static int azx_probe_continue(struct azx *chip)
 
 	chip->running = 1;
 	azx_add_card_list(chip);
-	snd_hda_set_power_save(&chip->bus, power_save * 1000);
+	snd_hda_set_power_save(&chip->bus, power_save * 1000, true);
 	if (azx_has_pm_runtime(chip) || hda->use_vga_switcheroo)
 		pm_runtime_put_noidle(&pci->dev);
 
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 477742c..bec3a37 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -518,7 +518,7 @@ static int hda_tegra_probe(struct platform_device *pdev)
 		goto out_free;
 
 	chip->running = 1;
-	snd_hda_set_power_save(&chip->bus, power_save * 1000);
+	snd_hda_set_power_save(&chip->bus, power_save * 1000, false);
 
 	return 0;
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 407978b..7941d81 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2356,6 +2356,9 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		codec->dp_mst = true;
 	}
 
+	if (is_haswell_plus(codec) || is_valleyview_plus(codec))
+		codec->auto_runtime_pm = 1;
+
 	generic_hdmi_init_per_pins(codec);
 
 	init_channel_allocations();
-- 
1.9.1
