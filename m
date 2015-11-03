From: libin.yang@linux.intel.com
Subject: [RFC PATCH 2/2] ALSA: hda - HDMI codec driver
	dynamically attach PCM
Date: Tue,  3 Nov 2015 16:22:53 +0800
Message-ID: <1446538973-109373-3-git-send-email-libin.yang@linux.intel.com>
References: <1446538973-109373-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BD0A26057D
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 09:24:16 +0100 (CET)
In-Reply-To: <1446538973-109373-1-git-send-email-libin.yang@linux.intel.com>
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
Cc: Libin Yang <libin.yang@intel.com>, Libin Yang <libin.yang@linux.intel.com>, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Allocate the PCM based on the number of pin and device entry.
The number of PCM is pin num plus device entry number per pin.
For example, on Intel platform, it will be 5 PCMs.

Do not attach the PCM to pin in initialization.
Dynamically attach PCM to pin when monitor is connected
in HDMI audio codec driver.

When monitor is disconnected, detach the PCM from the pin.
And if the audio is playing, stop the playback.

The below is the example of device entry and PCM binding:
For a monitor is plugged in, we need to dynamically assign
this monitor to 5 PCM devices (on Intel platform):
For a monitor at pin nid 0x05, dev index 0, it will prefer PCM 3
For a monitor at pin nid 0x06, dev index 0, it will prefer PCM 7
For a monitor at pin nid 0x07, dev index 0, it will prefer PCM 8
For a monitor at dev index 1 (any pin), it will prefer PCM 9
For a monitor at dev index 2 (any pin), it will prefer PCM 10

If the preferred PCM is not available, try PCM in this order:
9, 10, 3, 7 ,8.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/hda_codec.c  |   5 +-
 sound/pci/hda/hda_codec.h  |   1 +
 sound/pci/hda/patch_hdmi.c | 170 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 162 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 8374188..e1d4648 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -313,7 +313,7 @@ EXPORT_SYMBOL_GPL(snd_hda_get_conn_index);
 
 
 /* return DEVLIST_LEN parameter of the given widget */
-static unsigned int get_num_devices(struct hda_codec *codec, hda_nid_t nid)
+unsigned int snd_hda_get_num_devices(struct hda_codec *codec, hda_nid_t nid)
 {
 	unsigned int wcaps = get_wcaps(codec, nid);
 	unsigned int parm;
@@ -327,6 +327,7 @@ static unsigned int get_num_devices(struct hda_codec *codec, hda_nid_t nid)
 		parm = 0;
 	return parm & AC_DEV_LIST_LEN_MASK;
 }
+EXPORT_SYMBOL_GPL(snd_hda_get_num_devices);
 
 /**
  * snd_hda_get_devices - copy device list without cache
@@ -344,7 +345,7 @@ int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
 	unsigned int parm;
 	int i, dev_len, devices;
 
-	parm = get_num_devices(codec, nid);
+	parm = snd_hda_get_num_devices(codec, nid);
 	if (!parm)	/* not multi-stream capable */
 		return 0;
 
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 373fcad..ad4da41 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -347,6 +347,7 @@ int snd_hda_override_conn_list(struct hda_codec *codec, hda_nid_t nid, int nums,
 			  const hda_nid_t *list);
 int snd_hda_get_conn_index(struct hda_codec *codec, hda_nid_t mux,
 			   hda_nid_t nid, int recursive);
+unsigned int snd_hda_get_num_devices(struct hda_codec *codec, hda_nid_t nid);
 int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
 			u8 *dev_list, int max_devices);
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f503a88..8d31366 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -72,6 +72,9 @@ struct hdmi_spec_per_cvt {
 
 struct hdmi_spec_per_pin {
 	hda_nid_t pin_nid;
+	hda_dev_t dev_id;
+	/* real pin idx. device entries on same pin share same pin_nid_idx */
+	int pin_nid_idx;
 	int num_mux_nids;
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
 	int mux_idx;
@@ -82,6 +85,9 @@ struct hdmi_spec_per_pin {
 	struct mutex lock;
 	struct delayed_work work;
 	struct snd_kcontrol *eld_ctl;
+	struct hda_pcm *pcm; /* pointer to spec->pcm_rec[n] */
+	int pcm_idx; /* which pcm is attached. -1 means no pcm is attached */
+	bool pcm_detaching;
 	int repoll_count;
 	bool setup; /* the stream has been set up by prepare callback */
 	int channels; /* current number of channels */
@@ -134,6 +140,10 @@ struct hdmi_spec {
 	int num_pins;
 	struct snd_array pins; /* struct hdmi_spec_per_pin */
 	struct hda_pcm *pcm_rec[16];
+	unsigned long pcm_bitmap;
+	struct mutex pcm_lock;
+	int pcm_used;	/* counter of pcm_rec[] */
+	int dev_num;
 	unsigned int channels_max; /* max over all cvts */
 
 	struct hdmi_eld temp_eld;
@@ -378,12 +388,18 @@ static int hinfo_to_pin_index(struct hda_codec *codec,
 			      struct hda_pcm_stream *hinfo)
 {
 	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_spec_per_pin *per_pin;
 	int pin_idx;
 
-	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++)
-		if (get_pcm_rec(spec, pin_idx)->stream == hinfo)
+	mutex_lock(&spec->pcm_lock);
+	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
+		per_pin = get_pin(spec, pin_idx);
+		if (per_pin->pcm && per_pin->pcm->stream == hinfo) {
+			mutex_unlock(&spec->pcm_lock);
 			return pin_idx;
-
+		}
+	}
+	mutex_unlock(&spec->pcm_lock);
 	codec_warn(codec, "HDMI: hinfo %p not registered\n", hinfo);
 	return -EINVAL;
 }
@@ -1451,7 +1467,8 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 
 	/* Validate hinfo */
 	pin_idx = hinfo_to_pin_index(codec, hinfo);
-	if (snd_BUG_ON(pin_idx < 0))
+	/* if no pin is attached, return fail */
+	if (pin_idx < 0)
 		return -EINVAL;
 	per_pin = get_pin(spec, pin_idx);
 	eld = &per_pin->sink_eld;
@@ -1529,6 +1546,102 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
 	return 0;
 }
 
+static int get_preferred_pcm_slot(struct hdmi_spec *spec,
+				struct hdmi_spec_per_pin *per_pin)
+{
+	if (per_pin->dev_id == 0) {
+		if ((spec->pcm_bitmap & (1 << per_pin->pin_nid_idx)) == 0)
+			return per_pin->pin_nid_idx;
+	}
+	return -1;
+}
+
+static int hdmi_find_pcm_slot(struct hdmi_spec *spec,
+				struct hdmi_spec_per_pin *per_pin)
+{
+	int slot;
+	int slot_offset;
+	int i;
+
+	/* try the prefer PCM */
+	slot = get_preferred_pcm_slot(spec, per_pin);
+	if (slot != -1)
+		return slot;
+
+	/* have a second try, try backup PCMs from specified offset */
+	if (per_pin->dev_id == 0)
+		slot_offset = 0;
+	else
+		slot_offset = per_pin->dev_id - 1;
+	for (i = spec->num_pins + slot_offset; i < spec->pcm_used; i++) {
+		if ((spec->pcm_bitmap & (1 << i)) == 0)
+			return i;
+	}
+
+	/* have a third try, try all backup PCMs */
+	for (i = spec->num_pins; i < spec->pcm_used; i++) {
+		if ((spec->pcm_bitmap & (1 << i)) == 0)
+			return i;
+	}
+
+	/* the last try, try all PCMs */
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
+	mutex_lock(&spec->pcm_lock);
+	idx = hdmi_find_pcm_slot(spec, per_pin);
+	if (idx == -ENODEV) {
+		mutex_unlock(&spec->pcm_lock);
+		return;
+	}
+	per_pin->pcm_idx = idx;
+	per_pin->pcm = spec->pcm_rec[idx];
+	set_bit(idx, &spec->pcm_bitmap);
+	mutex_unlock(&spec->pcm_lock);
+}
+
+static void hdmi_detach_hda_pcm(struct hdmi_spec *spec,
+				struct hdmi_spec_per_pin *per_pin)
+{
+	int idx;
+	struct snd_pcm_substream *substream;
+	/* pcm already be detached from the pin */
+	if (!per_pin->pcm)
+		return;
+	mutex_lock(&spec->pcm_lock);
+	idx = per_pin->pcm_idx;
+	per_pin->pcm_idx = -1;
+	/* only for playback */
+	substream = per_pin->pcm->pcm->streams[0].substream;
+	clear_bit(idx, &spec->pcm_bitmap);
+
+	if (substream && substream->runtime &&
+		snd_pcm_running(substream))	{
+		codec_warn(per_pin->codec,
+			"HDMI: monitor disconnected, try to stop playback\n");
+		per_pin->pcm_detaching = true;
+		mutex_unlock(&spec->pcm_lock);
+		snd_pcm_stream_lock_irq(substream);
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_DISCONNECTED);
+		snd_pcm_stream_unlock_irq(substream);
+	} else {
+		per_pin->pcm = NULL;
+		mutex_unlock(&spec->pcm_lock);
+	}
+}
+
 static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 {
 	struct hda_jack_tbl *jack;
@@ -1586,6 +1699,12 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		}
 	}
 
+	/* need be protected by spec->lock */
+	if (eld->eld_valid)
+		hdmi_attach_hda_pcm(spec, per_pin);
+	else
+		hdmi_detach_hda_pcm(spec, per_pin);
+
 	if (pin_eld->eld_valid != eld->eld_valid)
 		eld_changed = true;
 
@@ -1662,6 +1781,7 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 	int pin_idx;
 	struct hdmi_spec_per_pin *per_pin;
 	int err;
+	int dev_num;
 
 	caps = snd_hda_query_pin_caps(codec, pin_nid);
 	if (!(caps & (AC_PINCAP_HDMI | AC_PINCAP_DP)))
@@ -1671,8 +1791,14 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 	if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
 		return 0;
 
-	if (is_haswell_plus(codec))
+	if (is_haswell_plus(codec)) {
 		intel_haswell_fixup_connect_list(codec, pin_nid);
+		spec->dev_num = 3;
+	} else {
+		dev_num = snd_hda_get_num_devices(codec, pin_nid) + 1;
+		spec->dev_num = (spec->dev_num > dev_num) ?
+			spec->dev_num : dev_num;
+	}
 
 	pin_idx = spec->num_pins;
 	per_pin = snd_array_new(&spec->pins);
@@ -1680,6 +1806,9 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 		return -ENOMEM;
 
 	per_pin->pin_nid = pin_nid;
+	per_pin->pin_nid_idx = pin_idx; /* to be fixed for mst audio */
+	per_pin->dev_id = 0; /* Not support MST audio so far */
+	per_pin->pcm_idx = -1;
 	per_pin->non_pcm = false;
 
 	err = hdmi_read_pin_conn(codec, pin_idx);
@@ -1799,13 +1928,19 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	hda_nid_t cvt_nid = hinfo->nid;
 	struct hdmi_spec *spec = codec->spec;
 	int pin_idx = hinfo_to_pin_index(codec, hinfo);
-	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
-	hda_nid_t pin_nid = per_pin->pin_nid;
+	struct hdmi_spec_per_pin *per_pin;
+	hda_nid_t pin_nid;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct i915_audio_component *acomp = codec->bus->core.audio_component;
 	bool non_pcm;
 	int pinctl;
 
+	/* no pin is attached */
+	if (pin_idx < 0)
+		return -EINVAL;
+	per_pin = get_pin(spec, pin_idx);
+	pin_nid = per_pin->pin_nid;
+
 	if (is_haswell_plus(codec) || is_valleyview_plus(codec)) {
 		/* Verify pin:cvt selections to avoid silent audio after S3.
 		 * After S3, the audio driver restores pin:cvt selections
@@ -1877,6 +2012,12 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 		if (snd_BUG_ON(pin_idx < 0))
 			return -EINVAL;
 		per_pin = get_pin(spec, pin_idx);
+		if (per_pin->pcm_detaching) {
+			mutex_lock(&spec->pcm_lock);
+			per_pin->pcm = NULL;
+			per_pin->pcm_detaching = false;
+			mutex_unlock(&spec->pcm_lock);
+		}
 
 		if (spec->dyn_pin_out) {
 			pinctl = snd_hda_codec_read(codec, per_pin->pin_nid, 0,
@@ -1896,7 +2037,6 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 		per_pin->channels = 0;
 		mutex_unlock(&per_pin->lock);
 	}
-
 	return 0;
 }
 
@@ -2068,22 +2208,26 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 static int generic_hdmi_build_pcms(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
-	int pin_idx;
+	int idx;
 
-	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
+	for (idx = 0; idx < spec->num_pins + spec->dev_num - 1; idx++) {
 		struct hda_pcm *info;
 		struct hda_pcm_stream *pstr;
 
-		info = snd_hda_codec_pcm_new(codec, "HDMI %d", pin_idx);
+		info = snd_hda_codec_pcm_new(codec, "HDMI %d", idx);
 		if (!info)
 			return -ENOMEM;
-		spec->pcm_rec[pin_idx] = info;
+		spec->pcm_rec[idx] = info;
+		spec->pcm_used++;
 		info->pcm_type = HDA_PCM_TYPE_HDMI;
 		info->own_chmap = true;
 
 		pstr = &info->stream[SNDRV_PCM_STREAM_PLAYBACK];
 		pstr->substreams = 1;
 		pstr->ops = generic_ops;
+		/* pcm number is less than 16 */
+		if (spec->pcm_used >= 16)
+			break;
 		/* other pstr fields are set in open */
 	}
 
@@ -2360,6 +2504,8 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		return -ENOMEM;
 
 	spec->ops = generic_standard_hdmi_ops;
+	spec->dev_num = 1;	/* initialize to 1 */
+	mutex_init(&spec->pcm_lock);
 	codec->spec = spec;
 	hdmi_array_init(spec, 4);
 
-- 
1.9.1
