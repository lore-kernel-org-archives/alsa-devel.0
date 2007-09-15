From: Tobin Davis <tdavis@dsl-only.net>
Subject: hda-codec:  Add 4 channel support for Realtek ALC883
Date: Sat, 15 Sep 2007 10:30:48 -0700
Message-ID: <1189877448.17677.10.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-OOQc063yOSh8Fk2LGHLw"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BA5324686
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Sep 2007 19:30:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-OOQc063yOSh8Fk2LGHLw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I had a request for a 4 channel mode.  This should implement front and
surround outputs, leaving the 3rd plug for mic input.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-OOQc063yOSh8Fk2LGHLw
Content-Disposition: attachment; filename=Realtek-4ch.patch
Content-Type: text/x-patch; name=Realtek-4ch.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 9fe2d7b6498b pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Wed Sep 12 13:31:47 2007 +0200
+++ b/pci/hda/patch_realtek.c	Thu Sep 13 22:18:43 2007 -0700
@@ -6087,6 +6087,18 @@ static struct hda_verb alc883_3ST_ch2_in
 };
 
 /*
+ * 4ch mode
+ */
+static struct hda_verb alc883_3ST_ch4_init[] = {
+	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 },
+	{ 0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
+	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+	{ 0x1a, AC_VERB_SET_CONNECT_SEL, 0x01 },
+	{ } /* end */
+};
+
+/*
  * 6ch mode
  */
 static struct hda_verb alc883_3ST_ch6_init[] = {
@@ -6099,8 +6111,9 @@ static struct hda_verb alc883_3ST_ch6_in
 	{ } /* end */
 };
 
-static struct hda_channel_mode alc883_3ST_6ch_modes[2] = {
+static struct hda_channel_mode alc883_3ST_6ch_modes[3] = {
 	{ 2, alc883_3ST_ch2_init },
+	{ 4, alc883_3ST_ch4_init },
 	{ 6, alc883_3ST_ch6_init },
 };
 

--=-OOQc063yOSh8Fk2LGHLw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-OOQc063yOSh8Fk2LGHLw--
