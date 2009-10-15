From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 10/11] hda - auto parse intelhdmi cvt/pin
	configurations
Date: Thu, 15 Oct 2009 15:03:58 +0800
Message-ID: <20091015070919.069338242@intel.com>
References: <20091015070348.390451250@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 302EE103939
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 09:10:14 +0200 (CEST)
Content-Disposition: inline; filename=hdmi-auto-parse.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |  120 +++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-10-15 12:38:57.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-10-15 12:41:02.000000000 +0800
@@ -213,6 +213,10 @@ static struct cea_channel_speaker_alloca
 };
 
 
+/*
+ * HDA/HDMI auto parsing
+ */
+
 static int hda_node_index(hda_nid_t *nids, hda_nid_t nid)
 {
 	int i;
@@ -225,6 +229,113 @@ static int hda_node_index(hda_nid_t *nid
 	return -EINVAL;
 }
 
+static int intel_hdmi_read_pin_conn(struct hda_codec *codec, hda_nid_t pin_nid)
+{
+	struct intel_hdmi_spec *spec = codec->spec;
+	hda_nid_t conn_list[HDA_MAX_CONNECTIONS];
+	int conn_len, curr;
+	int index;
+
+	if (!(get_wcaps(codec, pin_nid) & AC_WCAP_CONN_LIST)) {
+		snd_printk(KERN_WARNING
+			   "HDMI: pin %d wcaps %#x "
+			   "does not support connection list\n",
+			   pin_nid, get_wcaps(codec, pin_nid));
+		return -EINVAL;
+	}
+
+	conn_len = snd_hda_get_connections(codec, pin_nid, conn_list,
+					   HDA_MAX_CONNECTIONS);
+	if (conn_len > 1)
+		curr = snd_hda_codec_read(codec, pin_nid, 0,
+					  AC_VERB_GET_CONNECT_SEL, 0);
+	else
+		curr = 0;
+
+	index = hda_node_index(spec->pin, pin_nid);
+	if (index < 0)
+		return -EINVAL;
+
+	spec->pin_cvt[index] = conn_list[curr];
+
+	return 0;
+}
+
+static int intel_hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
+{
+	struct intel_hdmi_spec *spec = codec->spec;
+
+	if (spec->num_pins >= INTEL_HDMI_PINS) {
+		snd_printk(KERN_WARNING
+			   "HDMI: no space for pin %d \n", pin_nid);
+		return -EINVAL;
+	}
+
+	spec->pin[spec->num_pins] = pin_nid;
+	spec->num_pins++;
+
+	/*
+	 * It is assumed that converter nodes come first in the node list and
+	 * hence have been registered and usable now.
+	 */
+	return intel_hdmi_read_pin_conn(codec, pin_nid);
+}
+
+static int intel_hdmi_add_cvt(struct hda_codec *codec, hda_nid_t nid)
+{
+	struct intel_hdmi_spec *spec = codec->spec;
+
+	if (spec->num_cvts >= INTEL_HDMI_CVTS) {
+		snd_printk(KERN_WARNING
+			   "HDMI: no space for converter %d \n", nid);
+		return -EINVAL;
+	}
+
+	spec->cvt[spec->num_cvts] = nid;
+	spec->num_cvts++;
+
+	return 0;
+}
+
+static int intel_hdmi_parse_codec(struct hda_codec *codec)
+{
+	hda_nid_t nid;
+	int i, nodes;
+
+	nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid);
+	if (!nid || nodes < 0) {
+		snd_printk(KERN_WARNING "HDMI: failed to get afg sub nodes\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < nodes; i++, nid++) {
+		unsigned int caps;
+		unsigned int type;
+
+		caps = snd_hda_param_read(codec, nid, AC_PAR_AUDIO_WIDGET_CAP);
+		type = get_wcaps_type(caps);
+
+		if (!(caps & AC_WCAP_DIGITAL))
+			continue;
+
+		switch (type) {
+		case AC_WID_AUD_OUT:
+			if (intel_hdmi_add_cvt(codec, nid) < 0)
+				return -EINVAL;
+			break;
+		case AC_WID_PIN:
+			caps = snd_hda_param_read(codec, nid, AC_PAR_PIN_CAP);
+			if (!(caps & AC_PINCAP_HDMI))
+				continue;
+			if (intel_hdmi_add_pin(codec, nid) < 0)
+				return -EINVAL;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * HDMI routines
  */
@@ -756,8 +867,15 @@ static int do_patch_intel_hdmi(struct hd
 	if (spec == NULL)
 		return -ENOMEM;
 
-	*spec = static_specs[spec_id];
 	codec->spec = spec;
+	if (intel_hdmi_parse_codec(codec) < 0) {
+		codec->spec = NULL;
+		kfree(spec);
+		return -EINVAL;
+	}
+	if (memcmp(spec, static_specs + spec_id, sizeof(*spec)))
+		snd_printk(KERN_WARNING
+			   "HDMI: auto parse disagree with known config\n");
 	codec->patch_ops = intel_hdmi_patch_ops;
 
 	for (i = 0; i < spec->num_pins; i++)
