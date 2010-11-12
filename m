From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Remove unconnected PCM devices for
	Intel HDMI
Date: Fri, 12 Nov 2010 16:46:34 +0100
Message-ID: <4CDD615A.7000807@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060402030308080303040300"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id EF9F310395F
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 16:46:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: wfg@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060402030308080303040300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Since I'm a little new in HDMI land and the patch is non-trivial, I 
wouldn't mind some comments on this one. Also thanks to Jaroslav who 
cleared a few things out about the logical and physical devices which 
helped me figure out what I should do about it :-)

Anyway, here's the patch.

Some newer chips have more than one HDMI output, but usually not
all of them are exposed as physical jacks. Removing the unused
PCM devices (as indicated by BIOS in the pin config default) will
reduce user confusion as they currently have to choose between
several HDMI devices, some of them not working anyway.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------060402030308080303040300
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Remove-unconnected-PCM-devices-for-Intel-HD.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Remove-unconnected-PCM-devices-for-Intel-HD.pa";
 filename*1="tch"

>From db7911afdd02648b1faf6e2e7c8024da20d88257 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 11 Nov 2010 16:27:37 +0100
Subject: [PATCH] ALSA: HDA: Remove unconnected PCM devices for Intel HDMI

Some newer chips have more than one HDMI output, but usually not
all of them are exposed as physical jacks. Removing the unused
PCM devices (as indicated by BIOS in the pin config default) will
reduce user confusion as they currently have to choose between
several HDMI devices, some of them not working anyway.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda/patch_hdmi.c |   37 ++++++++++++++++++++++++++++---------
 1 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/hda/patch_hdmi.c b/hda/patch_hdmi.c
index d3e49aa..6d964f4 100644
--- a/hda/patch_hdmi.c
+++ b/hda/patch_hdmi.c
@@ -905,22 +905,22 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 	spec->pin[spec->num_pins] = pin_nid;
 	spec->num_pins++;
 
-	/*
-	 * It is assumed that converter nodes come first in the node list and
-	 * hence have been registered and usable now.
-	 */
 	return hdmi_read_pin_conn(codec, pin_nid);
 }
 
 static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t nid)
 {
+	int i;
 	struct hdmi_spec *spec = codec->spec;
 
-	if (spec->num_cvts >= MAX_HDMI_CVTS) {
-		snd_printk(KERN_WARNING
-			   "HDMI: no space for converter %d\n", nid);
+	for (i = 0; spec->pin_cvt[i] != nid; i++) 
+		if (!spec->pin[i]) {
+			snd_printd("HDMI: Skipping node %d (no connection)\n", nid);
+			return -EINVAL;
+		}
+
+	if (snd_BUG_ON(spec->num_cvts >= MAX_HDMI_CVTS))
 		return -E2BIG;
-	}
 
 	spec->cvt[spec->num_cvts] = nid;
 	spec->num_cvts++;
@@ -932,6 +932,8 @@ static int hdmi_parse_codec(struct hda_codec *codec)
 {
 	hda_nid_t nid;
 	int i, nodes;
+	int num_tmp_cvts = 0;
+	hda_nid_t tmp_cvt[MAX_HDMI_CVTS];
 
 	nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid);
 	if (!nid || nodes < 0) {
@@ -942,6 +944,7 @@ static int hdmi_parse_codec(struct hda_codec *codec)
 	for (i = 0; i < nodes; i++, nid++) {
 		unsigned int caps;
 		unsigned int type;
+		unsigned int config;
 
 		caps = snd_hda_param_read(codec, nid, AC_PAR_AUDIO_WIDGET_CAP);
 		type = get_wcaps_type(caps);
@@ -951,17 +954,33 @@ static int hdmi_parse_codec(struct hda_codec *codec)
 
 		switch (type) {
 		case AC_WID_AUD_OUT:
-			hdmi_add_cvt(codec, nid);
+			if (num_tmp_cvts >= MAX_HDMI_CVTS) {
+				snd_printk(KERN_WARNING
+					   "HDMI: no space for converter %d\n", nid);
+				continue;
+			}
+			tmp_cvt[num_tmp_cvts] = nid;
+			num_tmp_cvts++;
 			break;
 		case AC_WID_PIN:
 			caps = snd_hda_param_read(codec, nid, AC_PAR_PIN_CAP);
 			if (!(caps & (AC_PINCAP_HDMI | AC_PINCAP_DP)))
 				continue;
+
+			config = snd_hda_codec_read(codec, nid, 0, 
+					     AC_VERB_GET_CONFIG_DEFAULT, 0);
+			if (((config & AC_DEFCFG_PORT_CONN) >> 
+			    AC_DEFCFG_PORT_CONN_SHIFT) == AC_JACK_PORT_NONE)
+				continue;
+
 			hdmi_add_pin(codec, nid);
 			break;
 		}
 	}
 
+	for (i = 0; i < num_tmp_cvts; i++) 
+		hdmi_add_cvt(codec, tmp_cvt[i]);
+
 	/*
 	 * G45/IbexPeak don't support EPSS: the unsolicited pin hot plug event
 	 * can be lost and presence sense verb will become inaccurate if the
-- 
1.7.1


--------------060402030308080303040300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060402030308080303040300--
