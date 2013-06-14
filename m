From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 1/4] ALSA: hda - Haswell converter power state
	D0 verify
Date: Fri, 14 Jun 2013 23:20:26 +0800
Message-ID: <1371223229-8236-2-git-send-email-xingchao.wang@linux.intel.com>
References: <1371223229-8236-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1371223229-8236-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: tiwai@suse.de, daniel.vetter@ffwll.ch
Cc: alsa-devel@alsa-project.org, Wang Xingchao <xingchao.wang@linux.intel.com>, intel-gfx@lists.freedesktop.org, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Haswell converters maybe in wrong power state before usage.
i.e. only converter 0 is in D0, converter 1/2 are in D3.
When pin choose converter 1/2, there's no audio output.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index e12f7a0..8db5eb6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1053,6 +1053,23 @@ static void haswell_verify_pin_D0(struct hda_codec *codec, hda_nid_t nid)
 	}
 }
 
+static void hsw_verify_cvt_D0(struct hdmi_spec *spec,
+			 struct hda_codec *codec)
+{
+	struct hdmi_spec_per_cvt *per_cvt;
+	int pwr, cvt_idx;
+
+	for (cvt_idx = 0; cvt_idx < spec->num_cvts; cvt_idx++) {
+		per_cvt = get_cvt(spec, cvt_idx);
+		pwr = snd_hda_codec_read(codec, per_cvt->cvt_nid, 0,
+				AC_VERB_GET_POWER_STATE, 0);
+		pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
+		if (pwr != AC_PWRST_D0)
+			snd_hda_codec_write(codec, per_cvt->cvt_nid, 0, AC_VERB_SET_POWER_STATE,
+					    AC_PWRST_D0);
+	}
+}
+
 /*
  * Callbacks
  */
@@ -1122,6 +1139,9 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	per_pin = get_pin(spec, pin_idx);
 	eld = &per_pin->sink_eld;
 
+	if (codec->vendor_id == 0x80862807)
+		hsw_verify_cvt_D0(spec, codec);
+
 	/* Dynamically assign converter to stream */
 	for (cvt_idx = 0; cvt_idx < spec->num_cvts; cvt_idx++) {
 		per_cvt = get_cvt(spec, cvt_idx);
-- 
1.8.1.2
