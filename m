From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/7] ALSA: hda - Override HDMI setup_stream ops
	for Intel HSW+
Date: Tue, 22 Mar 2016 12:29:29 +0100
Message-ID: <1458646173-14520-4-git-send-email-tiwai@suse.de>
References: <1458646173-14520-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 259E6261A03
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 12:29:36 +0100 (CET)
In-Reply-To: <1458646173-14520-1-git-send-email-tiwai@suse.de>
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
Cc: libin.yang@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Instead of checking at each time with is_haswell_plus() macro,
override the setup_stream ops itself for HSW+ chips.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index fcd207d3ce7d..985518891b99 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -864,9 +864,6 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 	struct hdmi_spec *spec = codec->spec;
 	int err;
 
-	if (is_haswell_plus(codec))
-		haswell_verify_D0(codec, cvt_nid, pin_nid);
-
 	err = spec->ops.pin_hbr_setup(codec, pin_nid, is_hbr_format(format));
 
 	if (err) {
@@ -2307,6 +2304,14 @@ static void register_i915_notifier(struct hda_codec *codec)
 	snd_hdac_i915_register_notifier(&spec->i915_audio_ops);
 }
 
+/* setup_stream ops override for HSW+ */
+static int i915_hsw_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
+				 hda_nid_t pin_nid, u32 stream_tag, int format)
+{
+	haswell_verify_D0(codec, cvt_nid, pin_nid);
+	return hdmi_setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
+}
+
 /* Intel Haswell and onwards; audio component with eld notifier */
 static int patch_i915_hsw_hdmi(struct hda_codec *codec)
 {
@@ -2338,6 +2343,8 @@ static int patch_i915_hsw_hdmi(struct hda_codec *codec)
 	codec->depop_delay = 0;
 	codec->auto_runtime_pm = 1;
 
+	spec->ops.setup_stream = i915_hsw_setup_stream;
+
 	err = hdmi_parse_codec(codec);
 	if (err < 0) {
 		generic_spec_free(codec);
-- 
2.7.4
