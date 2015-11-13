From: libin.yang@linux.intel.com
Subject: [RFC PATCH] ALSA: hda - hdmi begin to support dynamic
	PCM assignment
Date: Fri, 13 Nov 2015 16:56:30 +0800
Message-ID: <1447404990-145928-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 19ADB2612D0
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2015 09:58:11 +0100 (CET)
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

Begin to support dynamic PCM assignment to pin in
hdmi audio driver.

This means PCM will not be statically bound with pin.
When there is a monitor connected, the corresponding pin
will try to find a proper PCM to bind. When the monitor
is disconnected, the corresponding pin will unbind
the PCM. This helps to reduce the PCM number when there
are many pins (device entries in DP MST mode) and only
a few of them work at the same time.

This patch adds the pcm member in struct hdmi_spec_per_pin.
When PCM is dynamically bound to the pin, the member pcm
will pointer to the corresponding pcm_rec[] in hdmi_spec,
which means the hda_pcm is bound to the pin.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f503a88..f3363b8 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -82,6 +82,7 @@ struct hdmi_spec_per_pin {
 	struct mutex lock;
 	struct delayed_work work;
 	struct snd_kcontrol *eld_ctl;
+	struct hda_pcm *pcm; /* pointer to spec->pcm_rec[n] dynamically*/
 	int repoll_count;
 	bool setup; /* the stream has been set up by prepare callback */
 	int channels; /* current number of channels */
@@ -140,7 +141,8 @@ struct hdmi_spec {
 	struct hdmi_ops ops;
 
 	bool dyn_pin_out;
-
+	bool dyn_pcm_assign;
+	struct mutex pcm_lock;
 	/*
 	 * Non-generic VIA/NVIDIA specific
 	 */
@@ -378,13 +380,26 @@ static int hinfo_to_pin_index(struct hda_codec *codec,
 			      struct hda_pcm_stream *hinfo)
 {
 	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_spec_per_pin *per_pin;
 	int pin_idx;
 
-	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++)
-		if (get_pcm_rec(spec, pin_idx)->stream == hinfo)
-			return pin_idx;
+	if (!spec->dyn_pcm_assign) {
+		for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++)
+			if (get_pcm_rec(spec, pin_idx)->stream == hinfo)
+				return pin_idx;
+	} else {
+		mutex_lock(&spec->pcm_lock);
+		for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
+			per_pin = get_pin(spec, pin_idx);
+			if (per_pin->pcm && per_pin->pcm->stream == hinfo) {
+				mutex_unlock(&spec->pcm_lock);
+				return pin_idx;
+			}
+		}
+		mutex_unlock(&spec->pcm_lock);
+	}
 
-	codec_warn(codec, "HDMI: hinfo %p not registered\n", hinfo);
+	codec_dbg(codec, "HDMI: hinfo %p not registered\n", hinfo);
 	return -EINVAL;
 }
 
@@ -2360,6 +2375,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		return -ENOMEM;
 
 	spec->ops = generic_standard_hdmi_ops;
+	mutex_init(&spec->pcm_lock);
 	codec->spec = spec;
 	hdmi_array_init(spec, 4);
 
-- 
1.9.1
