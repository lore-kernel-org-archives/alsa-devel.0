From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: 92HD
Date: Thu, 28 Feb 2008 21:30:24 -0500
Message-ID: <47C76E40.10003@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp109.biz.mail.mud.yahoo.com (smtp109.biz.mail.mud.yahoo.com
	[68.142.201.178])
	by alsa0.perex.cz (Postfix) with SMTP id AEE85103822
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 03:30:22 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>, Jose_De_La_Rosa@Dell.com, Mario_Limonciello@Dell.com
List-Id: alsa-devel@alsa-project.org

Added core_init[] for several 92hd73xxx laptops.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 54a51b975975 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Feb 28 12:46:32 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Thu Feb 28 21:14:39 2008 -0500
@@ -525,6 +525,24 @@ static struct hda_verb stac92hd73xx_6ch_
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
+static struct hda_verb dell_m6_core_init[] = {
+	/* set master volume and direct control */
+	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
+	/* setup audio connections */
+	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x02},
+	/* setup adcs to point to mixer */
+	{ 0x20, AC_VERB_SET_CONNECT_SEL, 0x0b},
+	{ 0x21, AC_VERB_SET_CONNECT_SEL, 0x0b},
 	/* setup import muxs */
 	{ 0x28, AC_VERB_SET_CONNECT_SEL, 0x01},
 	{ 0x29, AC_VERB_SET_CONNECT_SEL, 0x01},
@@ -3437,6 +3455,7 @@ again:
 
 	switch (spec->board_config) {
 	case STAC_DELL_M6:
+		spec->init = dell_m6_core_init;
 		switch (codec->subsystem_id) {
 		case 0x1028025e: /* Analog Mics */
 		case 0x1028025f:
