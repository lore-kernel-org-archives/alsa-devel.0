From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Update BCLK also at hotplug for
	i915 HSW/BDW
Date: Tue, 26 Apr 2016 10:02:50 +0200
Message-ID: <1461657770-24778-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DAAD2604BE
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 10:02:59 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9BC69ABA6
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 08:02:56 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The recent bug report suggests that BCLK setup for i915 HSW/BDW needs
to be updated at each HDMI hotplug, not only at initialization and
resume.  That is, we need to update HSW_EM4 and HSW_EM5 registers at
ELD notification, too.  Otherwise the HDMI audio may be out of sync
and played in a wrong pitch.

However, the HDA codec driver has no access to the controller
registers, and currently the code managing these registers is in
hda_intel.c, i.e. local to the controller driver.  For allowing the
explicit BCLK update from the codec driver, as in this patch, the
former haswell_set_bclk() in hda_intel.c is moved to hdac_i915.c and
exposed as snd_hdac_i915_set_bclk().  This is called from both the HDA
controller driver and intel_pin_eld_notify() in HDMI codec driver.

Along with this change, snd_hdac_get_display_clk() gets dropped as
it's no longer used.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=91410
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hda_i915.h   |  5 ++--
 sound/hda/hdac_i915.c      | 62 +++++++++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/hda_intel.c  | 56 +++--------------------------------------
 sound/pci/hda/patch_hdmi.c |  1 +
 4 files changed, 68 insertions(+), 56 deletions(-)

diff --git a/include/sound/hda_i915.h b/include/sound/hda_i915.h
index fa341fcb5829..f5842bcd9c94 100644
--- a/include/sound/hda_i915.h
+++ b/include/sound/hda_i915.h
@@ -9,7 +9,7 @@
 #ifdef CONFIG_SND_HDA_I915
 int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable);
 int snd_hdac_display_power(struct hdac_bus *bus, bool enable);
-int snd_hdac_get_display_clk(struct hdac_bus *bus);
+void snd_hdac_i915_set_bclk(struct hdac_bus *bus);
 int snd_hdac_sync_audio_rate(struct hdac_bus *bus, hda_nid_t nid, int rate);
 int snd_hdac_acomp_get_eld(struct hdac_bus *bus, hda_nid_t nid,
 			   bool *audio_enabled, char *buffer, int max_bytes);
@@ -25,9 +25,8 @@ static inline int snd_hdac_display_power(struct hdac_bus *bus, bool enable)
 {
 	return 0;
 }
-static inline int snd_hdac_get_display_clk(struct hdac_bus *bus)
+static inline void snd_hdac_i915_set_bclk(struct hdac_bus *bus)
 {
-	return 0;
 }
 static inline int snd_hdac_sync_audio_rate(struct hdac_bus *bus, hda_nid_t nid,
 					   int rate)
diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 54babe1c0b16..181777b43aa1 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -20,6 +20,7 @@
 #include <sound/core.h>
 #include <sound/hdaudio.h>
 #include <sound/hda_i915.h>
+#include <sound/hda_register.h>
 
 static struct i915_audio_component *hdac_acomp;
 
@@ -116,7 +117,66 @@ int snd_hdac_get_display_clk(struct hdac_bus *bus)
 
 	return acomp->ops->get_cdclk_freq(acomp->dev);
 }
-EXPORT_SYMBOL_GPL(snd_hdac_get_display_clk);
+
+#define CONTROLLER_IN_GPU(pci) (((pci)->device == 0x0a0c) || \
+				((pci)->device == 0x0c0c) || \
+				((pci)->device == 0x0d0c) || \
+				((pci)->device == 0x160c))
+
+/**
+ * snd_hdac_i915_set_bclk - Reprogram BCLK for HSW/BDW
+ * @bus: HDA core bus
+ *
+ * Intel HSW/BDW display HDA controller is in GPU. Both its power and link BCLK
+ * depends on GPU. Two Extended Mode registers EM4 (M value) and EM5 (N Value)
+ * are used to convert CDClk (Core Display Clock) to 24MHz BCLK:
+ * BCLK = CDCLK * M / N
+ * The values will be lost when the display power well is disabled and need to
+ * be restored to avoid abnormal playback speed.
+ *
+ * Call this function at initializing and changing power well, as well as
+ * at ELD notifier for the hotplug.
+ */
+void snd_hdac_i915_set_bclk(struct hdac_bus *bus)
+{
+	struct i915_audio_component *acomp = bus->audio_component;
+	struct pci_dev *pci = to_pci_dev(bus->dev);
+	int cdclk_freq;
+	unsigned int bclk_m, bclk_n;
+
+	if (!acomp || !acomp->ops || !acomp->ops->get_cdclk_freq)
+		return; /* only for i915 binding */
+	if (!CONTROLLER_IN_GPU(pci))
+		return; /* only HSW/BDW */
+
+	cdclk_freq = acomp->ops->get_cdclk_freq(acomp->dev);
+	switch (cdclk_freq) {
+	case 337500:
+		bclk_m = 16;
+		bclk_n = 225;
+		break;
+
+	case 450000:
+	default: /* default CDCLK 450MHz */
+		bclk_m = 4;
+		bclk_n = 75;
+		break;
+
+	case 540000:
+		bclk_m = 4;
+		bclk_n = 90;
+		break;
+
+	case 675000:
+		bclk_m = 8;
+		bclk_n = 225;
+		break;
+	}
+
+	snd_hdac_chip_writew(bus, HSW_EM4, bclk_m);
+	snd_hdac_chip_writew(bus, HSW_EM5, bclk_n);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_i915_set_bclk);
 
 /* There is a fixed mapping between audio pin node and display port
  * on current Intel platforms:
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 637b8a0e2a91..9a0d1445ca5c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -857,50 +857,6 @@ static int param_set_xint(const char *val, const struct kernel_param *kp)
 #define azx_del_card_list(chip) /* NOP */
 #endif /* CONFIG_PM */
 
-/* Intel HSW/BDW display HDA controller is in GPU. Both its power and link BCLK
- * depends on GPU. Two Extended Mode registers EM4 (M value) and EM5 (N Value)
- * are used to convert CDClk (Core Display Clock) to 24MHz BCLK:
- * BCLK = CDCLK * M / N
- * The values will be lost when the display power well is disabled and need to
- * be restored to avoid abnormal playback speed.
- */
-static void haswell_set_bclk(struct hda_intel *hda)
-{
-	struct azx *chip = &hda->chip;
-	int cdclk_freq;
-	unsigned int bclk_m, bclk_n;
-
-	if (!hda->need_i915_power)
-		return;
-
-	cdclk_freq = snd_hdac_get_display_clk(azx_bus(chip));
-	switch (cdclk_freq) {
-	case 337500:
-		bclk_m = 16;
-		bclk_n = 225;
-		break;
-
-	case 450000:
-	default: /* default CDCLK 450MHz */
-		bclk_m = 4;
-		bclk_n = 75;
-		break;
-
-	case 540000:
-		bclk_m = 4;
-		bclk_n = 90;
-		break;
-
-	case 675000:
-		bclk_m = 8;
-		bclk_n = 225;
-		break;
-	}
-
-	azx_writew(chip, HSW_EM4, bclk_m);
-	azx_writew(chip, HSW_EM5, bclk_n);
-}
-
 #if defined(CONFIG_PM_SLEEP) || defined(SUPPORT_VGA_SWITCHEROO)
 /*
  * power management
@@ -958,7 +914,7 @@ static int azx_resume(struct device *dev)
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
 		&& hda->need_i915_power) {
 		snd_hdac_display_power(azx_bus(chip), true);
-		haswell_set_bclk(hda);
+		snd_hdac_i915_set_bclk(azx_bus(chip));
 	}
 	if (chip->msi)
 		if (pci_enable_msi(pci) < 0)
@@ -1058,7 +1014,7 @@ static int azx_runtime_resume(struct device *dev)
 		bus = azx_bus(chip);
 		if (hda->need_i915_power) {
 			snd_hdac_display_power(bus, true);
-			haswell_set_bclk(hda);
+			snd_hdac_i915_set_bclk(bus);
 		} else {
 			/* toggle codec wakeup bit for STATESTS read */
 			snd_hdac_set_codec_wakeup(bus, true);
@@ -1796,12 +1752,8 @@ static int azx_first_init(struct azx *chip)
 	/* initialize chip */
 	azx_init_pci(chip);
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
-		struct hda_intel *hda;
-
-		hda = container_of(chip, struct hda_intel, chip);
-		haswell_set_bclk(hda);
-	}
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+		snd_hdac_i915_set_bclk(bus);
 
 	hda_intel_init_chip(chip, (probe_only[dev] & 2) == 0);
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 40933aa33afe..1483f85999ec 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2232,6 +2232,7 @@ static void intel_pin_eld_notify(void *audio_ptr, int port)
 	if (atomic_read(&(codec)->core.in_pm))
 		return;
 
+	snd_hdac_i915_set_bclk(&codec->bus->core);
 	check_presence_and_report(codec, pin_nid);
 }
 
-- 
2.8.1
