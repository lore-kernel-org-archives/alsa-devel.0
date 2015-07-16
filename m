From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2] ALSA: hda - Fix Skylake codec timeout
Date: Thu, 16 Jul 2015 10:39:24 +0200
Message-ID: <1437035964-5658-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 206302661B0
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 10:39:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, hui.wang@canonical.com, alsa-devel@alsa-project.org, libin.yang@intel.com, mengdong.lin@intel.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

When the controller is powered up but the HDMI codec is powered down
on Skylake, the power well is turned off. When the codec is then
powered up again, we need to poke the codec a little extra to make
sure it wakes up. Otherwise we'll get sad "no response from codec"
messages and broken audio.

This also changes azx_runtime_resume to actually call
snd_hdac_set_codec_wakeup for Skylake (before STATETS read).
(Otherwise it would only have been called for Haswell and Broadwell,
which both do not need it, so this probably was not the author's
intention.)

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/hda/hdac_i915.c     |  5 ++++-
 sound/pci/hda/hda_intel.c | 18 ++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 442500e..5676b84 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -56,8 +56,11 @@ int snd_hdac_display_power(struct hdac_bus *bus, bool enable)
 		enable ? "enable" : "disable");
 
 	if (enable) {
-		if (!bus->i915_power_refcount++)
+		if (!bus->i915_power_refcount++) {
 			acomp->ops->get_power(acomp->dev);
+			snd_hdac_set_codec_wakeup(bus, true);
+			snd_hdac_set_codec_wakeup(bus, false);
+		}
 	} else {
 		WARN_ON(!bus->i915_power_refcount);
 		if (!--bus->i915_power_refcount)
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ca151b4..9962237 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -979,14 +979,16 @@ static int azx_runtime_resume(struct device *dev)
 	if (!azx_has_pm_runtime(chip))
 		return 0;
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
-		&& hda->need_i915_power) {
-		bus =  azx_bus(chip);
-		snd_hdac_display_power(bus, true);
-		haswell_set_bclk(hda);
-		/* toggle codec wakeup bit for STATESTS read */
-		snd_hdac_set_codec_wakeup(bus, true);
-		snd_hdac_set_codec_wakeup(bus, false);
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+		bus = azx_bus(chip);
+		if (hda->need_i915_power) {
+			snd_hdac_display_power(bus, true);
+			haswell_set_bclk(hda);
+		} else {
+			/* toggle codec wakeup bit for STATESTS read */
+			snd_hdac_set_codec_wakeup(bus, true);
+			snd_hdac_set_codec_wakeup(bus, false);
+		}
 	}
 
 	/* Read STATESTS before controller reset */
-- 
1.9.1
