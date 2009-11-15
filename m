From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 05/11] intelhdmi - probe for monitor/eld
	presence at module init time
Date: Sun, 15 Nov 2009 19:32:24 +0800
Message-ID: <20091115114439.966345053@intel.com>
References: <20091115113219.606666087@intel.com>
Content-Type: multipart/mixed; boundary="===============3140119493809151290=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id ADE552415C
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 12:46:16 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, Shane W <shane-alsa@csy.ca>, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
List-Id: alsa-devel@alsa-project.org

--===============3140119493809151290==
Content-Disposition: inline; filename=hdmi-pin-sense.patch

This avoids lost of presence info on module reloading.
The presence info used to be only updated at the (rare) hotplug events.

Proposed by David, thanks!

CC: David Härdeman <david@hardeman.nu>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   33 ++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-11-02 15:44:26.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-11-02 15:47:43.000000000 +0800
@@ -259,6 +259,25 @@ static int intel_hdmi_read_pin_conn(stru
 	return 0;
 }
 
+static void hdmi_get_show_eld(struct hda_codec *codec, hda_nid_t pin_nid,
+			      struct hdmi_eld *eld)
+{
+	if (!snd_hdmi_get_eld(eld, codec, pin_nid))
+		snd_hdmi_show_eld(eld);
+}
+
+static void hdmi_present_sense(struct hda_codec *codec, hda_nid_t pin_nid,
+			       struct hdmi_eld *eld)
+{
+	int present = snd_hda_pin_sense(codec, pin_nid);
+
+	eld->monitor_present	= !!(present & AC_PINSENSE_PRESENCE);
+	eld->eld_valid		= !!(present & AC_PINSENSE_ELDV);
+
+	if (present & AC_PINSENSE_ELDV)
+		hdmi_get_show_eld(codec, pin_nid, eld);
+}
+
 static int intel_hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
@@ -269,6 +288,8 @@ static int intel_hdmi_add_pin(struct hda
 		return -EINVAL;
 	}
 
+	hdmi_present_sense(codec, pin_nid, &spec->sink_eld[spec->num_pins]);
+
 	spec->pin[spec->num_pins] = pin_nid;
 	spec->num_pins++;
 
@@ -436,15 +457,6 @@ static void hdmi_debug_channel_mapping(s
 #endif
 }
 
-static void hdmi_parse_eld(struct hda_codec *codec, int index)
-{
-	struct intel_hdmi_spec *spec = codec->spec;
-	struct hdmi_eld *eld = &spec->sink_eld[index];
-
-	if (!snd_hdmi_get_eld(eld, codec, spec->pin[index]))
-		snd_hdmi_show_eld(eld);
-}
-
 
 /*
  * Audio InfoFrame routines
@@ -677,7 +690,7 @@ static void hdmi_intrinsic_event(struct 
 	spec->sink_eld[index].eld_valid = eldv;
 
 	if (pind && eldv) {
-		hdmi_parse_eld(codec, index);
+		hdmi_get_show_eld(codec, spec->pin[index], &spec->sink_eld[index]);
 		/* TODO: do real things about ELD */
 	}
 }



--===============3140119493809151290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3140119493809151290==--
