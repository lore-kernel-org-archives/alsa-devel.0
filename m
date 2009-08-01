From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda: auto switch active pin on HDMI hotplug
	events
Date: Sat, 1 Aug 2009 20:28:19 +0800
Message-ID: <20090801122819.GA17358@localhost>
References: <20090801122700.GA17330@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 43C4524348
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 14:28:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090801122700.GA17330@localhost>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The active pin number (the one connected with a live HDMI monitor/sink)
could be identified on hotplug events.

This scheme still does not support two connected monitors.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   48 +++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 11 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -35,8 +35,7 @@
 
 static hda_nid_t cvt_nid;	/* audio converter */
 static hda_nid_t pin_nid;	/* HDMI output pin */
-
-#define INTEL_HDMI_EVENT_TAG		0x08
+static hda_nid_t *hdmi_pins;	/* available output pins */
 
 struct intel_hdmi_spec {
 	struct hda_multi_out multiout;
@@ -217,14 +216,14 @@ static void hdmi_write_dip_byte(struct h
 	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_HDMI_DIP_DATA, val);
 }
 
-static void hdmi_enable_output(struct hda_codec *codec)
+static void hdmi_enable_output(struct hda_codec *codec, hda_nid_t nid)
 {
 	/* Unmute */
-	if (get_wcaps(codec, pin_nid) & AC_WCAP_OUT_AMP)
-		snd_hda_codec_write(codec, pin_nid, 0,
+	if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
+		snd_hda_codec_write(codec, nid, 0,
 				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 	/* Enable pin out */
-	snd_hda_codec_write(codec, pin_nid, 0,
+	snd_hda_codec_write(codec, nid, 0,
 			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
 }
 
@@ -485,6 +484,7 @@ static void hdmi_setup_audio_infoframe(s
 
 static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
 {
+	int tag = res >> AC_UNSOL_RES_TAG_SHIFT;
 	int pind = !!(res & AC_UNSOL_RES_PD);
 	int eldv = !!(res & AC_UNSOL_RES_ELDV);
 
@@ -493,6 +493,16 @@ static void hdmi_intrinsic_event(struct 
 		pind, eldv);
 
 	if (pind && eldv) {
+		/*
+		 * We default to the first HDMI PIN initially, and
+		 * switch active pin on hotplug events.
+		 */
+		if (pin_nid != tag) {
+			printk(KERN_INFO
+			       "HDMI: switch active pin %#x to %#x\n",
+			       pin_nid, tag);
+			pin_nid = tag;
+		}
 		hdmi_parse_eld(codec);
 		/* TODO: do real things about ELD */
 	}
@@ -520,10 +530,15 @@ static void hdmi_non_intrinsic_event(str
 
 static void intel_hdmi_unsol_event(struct hda_codec *codec, unsigned int res)
 {
+	int i;
 	int tag = res >> AC_UNSOL_RES_TAG_SHIFT;
 	int subtag = (res & AC_UNSOL_RES_SUBTAG) >> AC_UNSOL_RES_SUBTAG_SHIFT;
 
-	if (tag != INTEL_HDMI_EVENT_TAG) {
+	for (i = 0; hdmi_pins[i]; i++)
+		if (tag == hdmi_pins[i])
+			break;
+
+	if (!hdmi_pins[i]) {
 		snd_printd(KERN_INFO "Unexpected HDMI event tag 0x%x\n", tag);
 		return;
 	}
@@ -619,11 +634,14 @@ static int intel_hdmi_build_controls(str
 
 static int intel_hdmi_init(struct hda_codec *codec)
 {
-	hdmi_enable_output(codec);
+	int i;
 
-	snd_hda_codec_write(codec, pin_nid, 0,
-			    AC_VERB_SET_UNSOLICITED_ENABLE,
-			    AC_USRSP_EN | INTEL_HDMI_EVENT_TAG);
+	for (i = 0; hdmi_pins[i]; i++) {
+		hdmi_enable_output(codec, hdmi_pins[i]);
+		snd_hda_codec_write(codec, hdmi_pins[i], 0,
+				    AC_VERB_SET_UNSOLICITED_ENABLE,
+				    AC_USRSP_EN | hdmi_pins[i]);
+	}
 	return 0;
 }
 
@@ -667,15 +685,23 @@ static int do_patch_intel_hdmi(struct hd
 
 static int patch_intel_hdmi(struct hda_codec *codec)
 {
+	static hda_nid_t g45_pins[] = { 0x03, 0 }; /* 0: terminator */
+
 	cvt_nid = 0x02;
 	pin_nid = 0x03;
+	hdmi_pins = g45_pins;
+
 	return do_patch_intel_hdmi(codec);
 }
 
 static int patch_intel_hdmi_ibexpeak(struct hda_codec *codec)
 {
+	static hda_nid_t p55_pins[] = { 0x04, 0x05, 0x06, 0 };
+
 	cvt_nid = 0x02;
 	pin_nid = 0x04;
+	hdmi_pins = p55_pins;
+
 	return do_patch_intel_hdmi(codec);
 }
