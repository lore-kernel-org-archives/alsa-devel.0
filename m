From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: 92HD73xxx distortion fix
Date: Thu, 13 Mar 2008 22:36:40 -0400
Message-ID: <47D9E4B8.6080308@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp102.biz.mail.mud.yahoo.com (smtp102.biz.mail.mud.yahoo.com
	[68.142.200.237]) by alsa0.perex.cz (Postfix) with SMTP id 45B66243D9
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 03:36:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Fixed issue on some laptops that if the Master mixer and DAC mixers are turned all
the way up that will cause distortion. This is fixed by limiting the max volume
with the volume knob nid.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 547e051a88b5 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Mar 12 13:12:15 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Wed Mar 12 21:48:13 2008 -0400
@@ -526,6 +526,25 @@ static struct hda_verb stac92hd73xx_6ch_
 	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{ 0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{ 0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	/* setup import muxs */
+	{ 0x28, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{ 0x29, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{ 0x2a, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{ 0x2b, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{}
+};
+
+static struct hda_verb dell_eq_core_init[] = {
+	/* set master volume to max value without distortion
+ 	 * and direct control */
+	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xec},
+	/* setup audio connections */
+	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x02},
+	/* setup adcs to point to mixer */
+	{ 0x20, AC_VERB_SET_CONNECT_SEL, 0x0b},
+	{ 0x21, AC_VERB_SET_CONNECT_SEL, 0x0b},
 	/* setup import muxs */
 	{ 0x28, AC_VERB_SET_CONNECT_SEL, 0x01},
 	{ 0x29, AC_VERB_SET_CONNECT_SEL, 0x01},
@@ -3460,17 +3479,19 @@ again:
 
 	switch (spec->board_config) {
 	case STAC_DELL_M6:
-		spec->init = dell_m6_core_init;
+		spec->init = dell_eq_core_init;
 		switch (codec->subsystem_id) {
 		case 0x1028025e: /* Analog Mics */
 		case 0x1028025f:
 			stac92xx_set_config_reg(codec, 0x0b, 0x90A70170);
 			spec->num_dmics = 0;
 			break;
-		case 0x10280254: /* Digital Mics */
+		case 0x10280271: /* Digital Mics */
+		case 0x10280272:
+			spec->init = dell_m6_core_init;
+			/* fall-through */
+		case 0x10280254:
 		case 0x10280255:
-		case 0x10280271:
-		case 0x10280272:
 			stac92xx_set_config_reg(codec, 0x13, 0x90A60160);
 			spec->num_dmics = 1;
 			break;
