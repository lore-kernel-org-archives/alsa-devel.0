From: mengdong.lin@intel.com
Subject: [PATCH v2 1/1] ALSA: hda - bug fix for invalid
	connection list of Haswell HDMI codec pin
Date: Fri, 14 Dec 2012 16:53:50 -0500
Message-ID: <1355522030-9819-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D9363261712
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2012 10:52:00 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@intel.com>, Xingchao Wang <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Haswell HDMI codec pins may report invalid connection list entries, which
will cause failure to play audio via HDMI.

So this patch
- allow generic hdmi patch to pick up and apply fixups for different codecs.
- add fixup for Haswell to workaround this hardware issue: enable DP1.2 mode
  and override the connection list entries with proper value.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Xingchao Wang <xingchao.wang@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 71555cc..42fdf14 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -38,6 +38,7 @@
 #include <sound/tlv.h>
 #include "hda_codec.h"
 #include "hda_local.h"
+#include "hda_auto_parser.h"
 #include "hda_jack.h"
 
 static bool static_hdmi_pcm;
@@ -79,6 +80,7 @@ struct hdmi_spec_per_pin {
 };
 
 struct hdmi_spec {
+	struct hda_gen_spec gen;
 	int num_cvts;
 	struct hdmi_spec_per_cvt cvts[MAX_HDMI_CVTS];
 
@@ -1687,6 +1689,54 @@ static const struct hda_codec_ops generic_hdmi_patch_ops = {
 	.unsol_event		= hdmi_unsol_event,
 };
 
+static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
+			       const struct hda_fixup *fix, int action)
+{
+	unsigned int vendor_param;
+	hda_nid_t list[3] = {0x2, 0x3, 0x4};
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	vendor_param = snd_hda_codec_read(codec, 0x08, 0, 0xf81, 0);
+	if (vendor_param == -1 || vendor_param & 0x02)
+		return;
+
+	/* enable DP1.2 mode */
+	vendor_param |= 0x02;
+	snd_hda_codec_read(codec, 0x08, 0, 0x781, vendor_param);
+
+	vendor_param = snd_hda_codec_read(codec, 0x08, 0, 0xf81, 0);
+	if (vendor_param == -1 || !(vendor_param & 0x02))
+		return;
+
+	snd_hda_override_conn_list(codec, 0x06, 3, list);
+	hdmi_read_pin_conn(codec, 1);
+}
+
+
+/* available models for fixup */
+enum {
+	INTEL_HASWELL,
+};
+
+static const struct hda_model_fixup hdmi_models[] = {
+	{.id = INTEL_HASWELL, .name = "Haswell"},
+	{}
+};
+
+static const struct snd_pci_quirk hdmi_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x8086, 0x2010, "Haswell", INTEL_HASWELL),
+	{} /* terminator */
+};
+
+static const struct hda_fixup hdmi_fixups[] = {
+	[INTEL_HASWELL] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = intel_haswell_fixup_connect_list,
+	},
+};
+
 static int patch_generic_hdmi(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec;
@@ -1696,6 +1746,11 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		return -ENOMEM;
 
 	codec->spec = spec;
+	snd_hda_gen_init(&spec->gen);
+
+	snd_hda_pick_fixup(codec, hdmi_models, hdmi_fixup_tbl, hdmi_fixups);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
+
 	if (hdmi_parse_codec(codec) < 0) {
 		codec->spec = NULL;
 		kfree(spec);
-- 
1.7.9.5
