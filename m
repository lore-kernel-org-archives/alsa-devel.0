From: libin.yang@linux.intel.com
Subject: [PATCH] ALSA: hda - hdmi begin to support dynamic PCM
	assignment
Date: Sat, 14 Nov 2015 10:15:02 +0800
Message-ID: <1447467302-29326-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CF7282612D1
 for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2015 03:16:46 +0100 (CET)
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
 sound/pci/hda/patch_hdmi.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f503a88..92e05fb 100644
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
@@ -140,7 +141,7 @@ struct hdmi_spec {
 	struct hdmi_ops ops;
 
 	bool dyn_pin_out;
-
+	bool dyn_pcm_assign;
 	/*
 	 * Non-generic VIA/NVIDIA specific
 	 */
@@ -378,13 +379,17 @@ static int hinfo_to_pin_index(struct hda_codec *codec,
 			      struct hda_pcm_stream *hinfo)
 {
 	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_spec_per_pin *per_pin;
 	int pin_idx;
 
-	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++)
-		if (get_pcm_rec(spec, pin_idx)->stream == hinfo)
+	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
+		per_pin = get_pin(spec, pin_idx);
+		if (per_pin->pcm && per_pin->pcm->stream == hinfo) {
 			return pin_idx;
+		}
+	}
 
-	codec_warn(codec, "HDMI: hinfo %p not registered\n", hinfo);
+	codec_dbg(codec, "HDMI: hinfo %p not registered\n", hinfo);
 	return -EINVAL;
 }
 
@@ -2068,6 +2073,7 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 static int generic_hdmi_build_pcms(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_spec_per_pin *per_pin;
 	int pin_idx;
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
@@ -2077,6 +2083,10 @@ static int generic_hdmi_build_pcms(struct hda_codec *codec)
 		info = snd_hda_codec_pcm_new(codec, "HDMI %d", pin_idx);
 		if (!info)
 			return -ENOMEM;
+		if (!spec->dyn_pcm_assign) {
+			per_pin = get_pin(spec, pin_idx);
+			per_pin->pcm = info;
+		}
 		spec->pcm_rec[pin_idx] = info;
 		info->pcm_type = HDA_PCM_TYPE_HDMI;
 		info->own_chmap = true;
-- 
1.9.1
