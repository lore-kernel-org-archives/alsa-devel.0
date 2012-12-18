From: mengdong.lin@intel.com
Subject: [PATCH v3 1/1] ALSA: hda - bug fix for invalid
	connection list of Haswell HDMI codec pins
Date: Tue, 18 Dec 2012 16:59:15 -0500
Message-ID: <1355867955-2391-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 42F0226168B
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2012 10:57:07 +0100 (CET)
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
will cause failure to play audio via HDMI or Display Port.

So this patch adds fixup for Haswell to workaround this hardware issue:
enable DP1.2 mode and override the pins' connection list entries with proper
value.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Xingchao Wang <xingchao.wang@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 71555cc..59abe73 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1687,6 +1687,30 @@ static const struct hda_codec_ops generic_hdmi_patch_ops = {
 	.unsol_event		= hdmi_unsol_event,
 };
 
+static void intel_haswell_fixup_connect_list(struct hda_codec *codec)
+{
+	unsigned int vendor_param;
+	hda_nid_t list[3] = {0x2, 0x3, 0x4};
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
+	/* override 3 pins connection list */
+	snd_hda_override_conn_list(codec, 0x05, 3, list);
+	snd_hda_override_conn_list(codec, 0x06, 3, list);
+	snd_hda_override_conn_list(codec, 0x07, 3, list);
+}
+
+
 static int patch_generic_hdmi(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec;
@@ -1696,6 +1720,10 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		return -ENOMEM;
 
 	codec->spec = spec;
+
+	if (codec->vendor_id == 0x80862807)
+		intel_haswell_fixup_connect_list(codec);
+
 	if (hdmi_parse_codec(codec) < 0) {
 		codec->spec = NULL;
 		kfree(spec);
-- 
1.7.9.5
