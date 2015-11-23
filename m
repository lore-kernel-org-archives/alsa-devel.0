From: libin.yang@linux.intel.com
Subject: [RFC V2 PATCH 3/5] ALSA: hda - hdmi dynamically bind
	PCM to pin when monitor hotplug
Date: Mon, 23 Nov 2015 22:09:32 +0800
Message-ID: <1448287774-146673-5-git-send-email-libin.yang@linux.intel.com>
References: <1448287774-146673-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F50D26545D
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 15:12:27 +0100 (CET)
In-Reply-To: <1448287774-146673-1-git-send-email-libin.yang@linux.intel.com>
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
Cc: libin.yang@intel.com, Libin Yang <libin.yang@linux.intel.com>, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

Dynamically bind/unbind the PCM to pin when HDMI/DP monitor hotplug.

When monitor is connected, find a proper PCM for the monitor.
When monitor is disconnected, unbind the PCM from the pin.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index de22ac2..bcc2a90 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -72,6 +72,8 @@ struct hdmi_spec_per_cvt {
 
 struct hdmi_spec_per_pin {
 	hda_nid_t pin_nid;
+	/* pin idx, different device entries on the same pin use the same idx */
+	int pin_nid_idx;
 	int num_mux_nids;
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
 	int mux_idx;
@@ -83,6 +85,7 @@ struct hdmi_spec_per_pin {
 	struct delayed_work work;
 	struct snd_kcontrol *eld_ctl;
 	struct hda_pcm *pcm; /* pointer to spec->pcm_rec[n] dynamically*/
+	int pcm_idx; /* which pcm is attached. -1 means no pcm is attached */
 	int repoll_count;
 	bool setup; /* the stream has been set up by prepare callback */
 	int channels; /* current number of channels */
@@ -136,6 +139,7 @@ struct hdmi_spec {
 	struct snd_array pins; /* struct hdmi_spec_per_pin */
 	struct hda_pcm *pcm_rec[16];
 	struct mutex pcm_lock;
+	unsigned long pcm_bitmap;
 	int pcm_used;	/* counter of pcm_rec[] */
 	unsigned int channels_max; /* max over all cvts */
 
@@ -1663,6 +1667,70 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
 	return 0;
 }
 
+static int get_preferred_pcm_slot(struct hdmi_spec *spec,
+				struct hdmi_spec_per_pin *per_pin)
+{
+	if ((spec->pcm_bitmap & (1 << per_pin->pin_nid_idx)) == 0)
+		return per_pin->pin_nid_idx;
+	return -1;
+}
+
+static int hdmi_find_pcm_slot(struct hdmi_spec *spec,
+				struct hdmi_spec_per_pin *per_pin)
+{
+	int slot;
+	int i;
+
+	/* try the prefer PCM */
+	slot = get_preferred_pcm_slot(spec, per_pin);
+	if (slot != -1)
+		return slot;
+
+	/* have a second try */
+	for (i = spec->num_pins; i < spec->pcm_used; i++) {
+		if ((spec->pcm_bitmap & (1 << i)) == 0)
+			return i;
+	}
+
+	/* the last try */
+	for (i = 0; i < spec->pcm_used; i++) {
+		if ((spec->pcm_bitmap & (1 << i)) == 0)
+			return i;
+	}
+	return -ENODEV;
+}
+
+static void hdmi_attach_hda_pcm(struct hdmi_spec *spec,
+				struct hdmi_spec_per_pin *per_pin)
+{
+	int idx;
+
+	/* pcm already be attached to the pin */
+	if (per_pin->pcm)
+		return;
+	idx = hdmi_find_pcm_slot(spec, per_pin);
+	if (idx == -ENODEV)
+		return;
+	per_pin->pcm_idx = idx;
+	per_pin->pcm = spec->pcm_rec[idx];
+	set_bit(idx, &spec->pcm_bitmap);
+}
+
+static void hdmi_detach_hda_pcm(struct hdmi_spec *spec,
+				struct hdmi_spec_per_pin *per_pin)
+{
+	int idx;
+
+	/* pcm already be detached from the pin */
+	if (!per_pin->pcm)
+		return;
+	idx = per_pin->pcm_idx;
+	per_pin->pcm_idx = -1;
+	per_pin->pcm = NULL;
+	if (idx >= 0 && idx < spec->pcm_used)
+		clear_bit(idx, &spec->pcm_bitmap);
+}
+
 static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 {
 	struct hda_jack_tbl *jack;
@@ -1687,6 +1755,7 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 	snd_hda_power_up_pm(codec);
 	present = snd_hda_pin_sense(codec, pin_nid);
 
+	mutex_lock(&spec->pcm_lock);
 	mutex_lock(&per_pin->lock);
 	pin_eld->monitor_present = !!(present & AC_PINSENSE_PRESENCE);
 	if (pin_eld->monitor_present)
@@ -1720,6 +1789,13 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		}
 	}
 
+	if (spec->dyn_pcm_assign) {
+		if (eld->eld_valid)
+			hdmi_attach_hda_pcm(spec, per_pin);
+		else
+			hdmi_detach_hda_pcm(spec, per_pin);
+	}
+
 	if (pin_eld->eld_valid != eld->eld_valid)
 		eld_changed = true;
 
@@ -1770,6 +1846,7 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		jack->block_report = !ret;
 
 	mutex_unlock(&per_pin->lock);
+	mutex_unlock(&spec->pcm_lock);
 	snd_hda_power_down_pm(codec);
 	return ret;
 }
@@ -1815,6 +1892,11 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 
 	per_pin->pin_nid = pin_nid;
 	per_pin->non_pcm = false;
+	if (spec->dyn_pcm_assign)
+		per_pin->pcm_idx = -1;
+	else
+		per_pin->pcm_idx = pin_idx;
+	per_pin->pin_nid_idx = pin_idx;
 
 	err = hdmi_read_pin_conn(codec, pin_idx);
 	if (err < 0)
-- 
1.9.1
