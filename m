From: libin.yang@linux.intel.com
Subject: [RFC PATCH v2 2/3] ALSA - hda: add devid support in
	acom
Date: Mon, 21 Mar 2016 16:37:55 +0800
Message-ID: <1458549476-77040-3-git-send-email-libin.yang@linux.intel.com>
References: <1458549476-77040-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A1752614FD
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 09:39:06 +0100 (CET)
In-Reply-To: <1458549476-77040-1-git-send-email-libin.yang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

This is a tmp API patch for gfx. Detail is still in discussion
---
 drivers/gpu/drm/i915/intel_audio.c | 2 +-
 include/drm/i915_component.h       | 2 +-
 include/sound/hda_i915.h           | 6 +++---
 sound/hda/hdac_i915.c              | 7 ++++---
 sound/pci/hda/patch_hdmi.c         | 5 +++--
 5 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
index 31f6d21..3fdb6d9 100644
--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -710,7 +710,7 @@ static int i915_audio_component_sync_audio_rate(struct device *dev,
 }
 
 static int i915_audio_component_get_eld(struct device *dev, int port,
-					bool *enabled,
+					int dev_id, bool *enabled,
 					unsigned char *buf, int max_bytes)
 {
 	struct drm_i915_private *dev_priv = dev_to_i915(dev);
diff --git a/include/drm/i915_component.h b/include/drm/i915_component.h
index b46fa0e..3c4475a 100644
--- a/include/drm/i915_component.h
+++ b/include/drm/i915_component.h
@@ -77,7 +77,7 @@ struct i915_audio_component_ops {
 	 * Note that the returned size may be over @max_bytes.  Then it
 	 * implies that only a part of ELD has been copied to the buffer.
 	 */
-	int (*get_eld)(struct device *, int port, bool *enabled,
+	int (*get_eld)(struct device *, int port, int dev_id, bool *enabled,
 		       unsigned char *buf, int max_bytes);
 };
 
diff --git a/include/sound/hda_i915.h b/include/sound/hda_i915.h
index fa341fc..07403f7 100644
--- a/include/sound/hda_i915.h
+++ b/include/sound/hda_i915.h
@@ -11,7 +11,7 @@ int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable);
 int snd_hdac_display_power(struct hdac_bus *bus, bool enable);
 int snd_hdac_get_display_clk(struct hdac_bus *bus);
 int snd_hdac_sync_audio_rate(struct hdac_bus *bus, hda_nid_t nid, int rate);
-int snd_hdac_acomp_get_eld(struct hdac_bus *bus, hda_nid_t nid,
+int snd_hdac_acomp_get_eld(struct hdac_bus *bus, hda_nid_t nid, int dev_id,
 			   bool *audio_enabled, char *buffer, int max_bytes);
 int snd_hdac_i915_init(struct hdac_bus *bus);
 int snd_hdac_i915_exit(struct hdac_bus *bus);
@@ -35,8 +35,8 @@ static inline int snd_hdac_sync_audio_rate(struct hdac_bus *bus, hda_nid_t nid,
 	return 0;
 }
 static inline int snd_hdac_acomp_get_eld(struct hdac_bus *bus, hda_nid_t nid,
-					 bool *audio_enabled, char *buffer,
-					 int max_bytes)
+					 int dev_id, bool *audio_enabled,
+					 char *buffer, int max_bytes)
 {
 	return -ENODEV;
 }
diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index f6854db..18173c7 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -155,6 +155,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_sync_audio_rate);
  * snd_hdac_acomp_get_eld - Get the audio state and ELD via component
  * @bus: HDA core bus
  * @nid: the pin widget NID
+ * @dev_id: the device entry id
  * @audio_enabled: the pointer to store the current audio state
  * @buffer: the buffer pointer to store ELD bytes
  * @max_bytes: the max bytes to be stored on @buffer
@@ -171,7 +172,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_sync_audio_rate);
  * thus it may be over @max_bytes.  If it's over @max_bytes, it implies
  * that only a part of ELD bytes have been fetched.
  */
-int snd_hdac_acomp_get_eld(struct hdac_bus *bus, hda_nid_t nid,
+int snd_hdac_acomp_get_eld(struct hdac_bus *bus, hda_nid_t nid, int dev_id,
 			   bool *audio_enabled, char *buffer, int max_bytes)
 {
 	struct i915_audio_component *acomp = bus->audio_component;
@@ -179,8 +180,8 @@ int snd_hdac_acomp_get_eld(struct hdac_bus *bus, hda_nid_t nid,
 	if (!acomp || !acomp->ops || !acomp->ops->get_eld)
 		return -ENODEV;
 
-	return acomp->ops->get_eld(acomp->dev, pin2port(nid), audio_enabled,
-				   buffer, max_bytes);
+	return acomp->ops->get_eld(acomp->dev, pin2port(nid), dev_id,
+				   audio_enabled, buffer, max_bytes);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_acomp_get_eld);
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 7e03200..5987a31 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -75,6 +75,7 @@ struct hdmi_spec_per_cvt {
 
 struct hdmi_spec_per_pin {
 	hda_nid_t pin_nid;
+	int dev_id;
 	/* pin idx, different device entries on the same pin use the same idx */
 	int pin_nid_idx;
 	int num_mux_nids;
@@ -2013,8 +2014,8 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 
 	mutex_lock(&per_pin->lock);
 	size = snd_hdac_acomp_get_eld(&codec->bus->core, per_pin->pin_nid,
-				      &eld->monitor_present, eld->eld_buffer,
-				      ELD_MAX_SIZE);
+				      per_pin->dev_id, &eld->monitor_present,
+				      eld->eld_buffer, ELD_MAX_SIZE);
 	if (size < 0)
 		goto unlock;
 	if (size > 0) {
-- 
1.9.1
