From: libin.yang@linux.intel.com
Subject: [PATCH v5 1/2] ALSA: hda - hdmi dynamically bind PCM
	to pin when monitor hotplug
Date: Wed, 16 Dec 2015 16:48:15 +0800
Message-ID: <1450255696-105171-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FBC42651FF
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 09:50:49 +0100 (CET)
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

Dynamically bind/unbind the PCM to pin when HDMI/DP monitor hotplug.

When monitor is connected, find a proper PCM for the monitor.
When monitor is disconnected, unbind the PCM from the pin.

The binding policy (use Intel platform as example) is:
1. Try to use the legacy pin-pcm mapping for the device entry 0
   of the pin.
2. If step 1 fails, try to bind pin to the backup PCMs. For example,
   on Intel platform, if DP MST is enabled, 5 PCMs will be created.
   PCM 3, PCM 7, PCM 8 are supposed to be used by device entry 0 of
   pin 5, pin 6 and pin 7. PCM 9 and PCM 10 are the backup PCMs.
3. If step 2 fails, try to find any PCM to bind to the pin.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 82 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 19bf782..56b7625 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -73,6 +73,8 @@ struct hdmi_spec_per_cvt {
 
 struct hdmi_spec_per_pin {
 	hda_nid_t pin_nid;
+	/* pin idx, different device entries on the same pin use the same idx */
+	int pin_nid_idx;
 	int num_mux_nids;
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
 	int mux_idx;
@@ -85,6 +87,7 @@ struct hdmi_spec_per_pin {
 	struct snd_kcontrol *eld_ctl;
 	struct snd_jack *acomp_jack; /* jack via audio component */
 	struct hda_pcm *pcm; /* pointer to spec->pcm_rec[n] dynamically*/
+	int pcm_idx; /* which pcm is attached. -1 means no pcm is attached */
 	int repoll_count;
 	bool setup; /* the stream has been set up by prepare callback */
 	int channels; /* current number of channels */
@@ -138,6 +141,8 @@ struct hdmi_spec {
 	struct snd_array pins; /* struct hdmi_spec_per_pin */
 	struct hda_pcm *pcm_rec[16];
 	struct mutex pcm_lock;
+	/* pcm_bitmap means which pcms have been assigned to pins*/
+	unsigned long pcm_bitmap;
 	int pcm_used;	/* counter of pcm_rec[] */
 	unsigned int channels_max; /* max over all cvts */
 
@@ -1671,6 +1676,60 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
 	return 0;
 }
 
+static int hdmi_find_pcm_slot(struct hdmi_spec *spec,
+				struct hdmi_spec_per_pin *per_pin)
+{
+	int i;
+
+	/* try the prefer PCM */
+	if (!test_bit(per_pin->pin_nid_idx, &spec->pcm_bitmap))
+		return per_pin->pin_nid_idx;
+
+	/* have a second try; check the "reserved area" over num_pins */
+	for (i = spec->num_pins; i < spec->pcm_used; i++) {
+		if (!test_bit(i, &spec->pcm_bitmap))
+			return i;
+	}
+
+	/* the last try; check the empty slots in pins */
+	for (i = 0; i < spec->num_pins; i++) {
+		if (!test_bit(i, &spec->pcm_bitmap))
+			return i;
+	}
+	return -EBUSY;
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
 /* update per_pin ELD from the given new ELD;
  * setup info frame and notification accordingly
  */
@@ -1679,9 +1738,17 @@ static void update_eld(struct hda_codec *codec,
 		       struct hdmi_eld *eld)
 {
 	struct hdmi_eld *pin_eld = &per_pin->sink_eld;
+	struct hdmi_spec *spec = codec->spec;
 	bool old_eld_valid = pin_eld->eld_valid;
 	bool eld_changed;
 
+	if (spec->dyn_pcm_assign) {
+		if (eld->eld_valid)
+			hdmi_attach_hda_pcm(spec, per_pin);
+		else
+			hdmi_detach_hda_pcm(spec, per_pin);
+	}
+
 	if (eld->eld_valid)
 		snd_hdmi_show_eld(codec, &eld->info);
 
@@ -1825,13 +1892,19 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 {
 	struct hda_codec *codec = per_pin->codec;
+	struct hdmi_spec *spec = codec->spec;
+	int ret;
 
+	mutex_lock(&spec->pcm_lock);
 	if (codec_has_acomp(codec)) {
 		sync_eld_via_acomp(codec, per_pin);
-		return false; /* don't call snd_hda_jack_report_sync() */
+		ret = false; /* don't call snd_hda_jack_report_sync() */
 	} else {
-		return hdmi_present_sense_via_verbs(per_pin, repoll);
+		ret = hdmi_present_sense_via_verbs(per_pin, repoll);
 	}
+	mutex_unlock(&spec->pcm_lock);
+
+	return ret;
 }
 
 static void hdmi_repoll_eld(struct work_struct *work)
@@ -1875,6 +1948,11 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 
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
