From: libin.yang@linux.intel.com
Subject: [PATCH] ALSA - hda: hdmi flag to stop playback when
	monitor is disconnected
Date: Wed, 11 Nov 2015 16:39:09 +0800
Message-ID: <1447231149-88326-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EEB82605B1
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 09:40:49 +0100 (CET)
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

Add a flag that user can decide to stop HDMI/DP playback when
the corresponding monitor is disconnected and refuse to open PCM
if there is no monitor connected.

Background:
When a monitor is disconnected and a new monitor is connected,
the parameters of the 2 monitors may be different. Audio driver
need handle this situation.

Besides, stopping playback when monitor is disconnected will
help to save the power.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f503a88..4f5023a 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -47,6 +47,11 @@ static bool static_hdmi_pcm;
 module_param(static_hdmi_pcm, bool, 0644);
 MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
 
+static bool hdmi_pcm_stop_on_disconnect;
+module_param(hdmi_pcm_stop_on_disconnect, bool, 0644);
+MODULE_PARM_DESC(hdmi_pcm_stop_on_disconnect,
+				 "Stop PCM when monitor is disconnected");
+
 #define is_haswell(codec)  ((codec)->core.vendor_id == 0x80862807)
 #define is_broadwell(codec)    ((codec)->core.vendor_id == 0x80862808)
 #define is_skylake(codec) ((codec)->core.vendor_id == 0x80862809)
@@ -72,6 +77,7 @@ struct hdmi_spec_per_cvt {
 
 struct hdmi_spec_per_pin {
 	hda_nid_t pin_nid;
+	int pin_idx;
 	int num_mux_nids;
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
 	int mux_idx;
@@ -1456,6 +1462,9 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	per_pin = get_pin(spec, pin_idx);
 	eld = &per_pin->sink_eld;
 
+	if (hdmi_pcm_stop_on_disconnect && !eld->eld_valid)
+		return -ENODEV;
+
 	err = hdmi_choose_cvt(codec, pin_idx, &cvt_idx, &mux_idx);
 	if (err < 0)
 		return err;
@@ -1529,6 +1538,28 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
 	return 0;
 }
 
+static void hdmi_pcm_stop(struct hdmi_spec *spec,
+					struct hdmi_spec_per_pin *per_pin)
+{
+	struct hda_codec *codec = per_pin->codec;
+	struct snd_pcm_substream *substream;
+	int pin_idx = per_pin->pin_idx;
+
+	if (!hdmi_pcm_stop_on_disconnect)
+		return;
+
+	substream = get_pcm_rec(spec, pin_idx)->pcm->streams[0].substream;
+
+	snd_pcm_stream_lock_irq(substream);
+	if (substream && substream->runtime &&
+		snd_pcm_running(substream)) {
+		codec_info(codec,
+			"HDMI: monitor disconnected, try to stop playback\n");
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_DISCONNECTED);
+	}
+	snd_pcm_stream_unlock_irq(substream);
+}
+
 static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 {
 	struct hda_jack_tbl *jack;
@@ -1586,6 +1617,8 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		}
 	}
 
+	if (!eld->eld_valid)
+		hdmi_pcm_stop(spec, per_pin);
 	if (pin_eld->eld_valid != eld->eld_valid)
 		eld_changed = true;
 
@@ -1680,6 +1713,7 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 		return -ENOMEM;
 
 	per_pin->pin_nid = pin_nid;
+	per_pin->pin_idx = pin_idx;
 	per_pin->non_pcm = false;
 
 	err = hdmi_read_pin_conn(codec, pin_idx);
-- 
1.9.1
