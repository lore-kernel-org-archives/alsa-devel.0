From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Reorganized DAC outputs.
Date: Sat, 08 Mar 2008 20:41:58 -0500
Message-ID: <47D34066.6020809@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp105.biz.mail.mud.yahoo.com (smtp105.biz.mail.mud.yahoo.com
	[68.142.200.253]) by alsa0.perex.cz (Postfix) with SMTP id F242E24474
	for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2008 02:42:16 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>
List-Id: alsa-devel@alsa-project.org

Changed so that internal speakers point to the Front mixer instead of Surround.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 3f01993fbc3d pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Sat Mar 08 11:08:32 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Sat Mar 08 20:37:27 2008 -0500
@@ -538,8 +538,8 @@ static struct hda_verb dell_m6_core_init
 	/* set master volume and direct control */
 	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	/* setup audio connections */
-	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x00},
-	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
 	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x02},
 	/* setup adcs to point to mixer */
 	{ 0x20, AC_VERB_SET_CONNECT_SEL, 0x0b},
