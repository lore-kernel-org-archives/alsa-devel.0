From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: add eapd support to additional idt codecs
Date: Tue, 19 Jun 2007 10:27:25 -0400
Message-ID: <4677E7CD.40209@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040804050509030106090004"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by alsa0.perex.cz (Postfix) with SMTP id C6F90243A1
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 16:27:19 +0200 (CEST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040804050509030106090004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added support for EAPD on the 927x, and 9227-8 IDT HDA codecs.
Enabling EAPD powers the internal speaker amp otherwise there is no 
sound on systems with an internal amp.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------040804050509030106090004
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="alsa_patch_sigmatel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_patch_sigmatel.patch"

diff -r 96495fe7cc13 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Jun 14 12:58:23 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Mon Jun 18 17:10:38 2007 -0400
@@ -832,6 +832,18 @@ static void stac92xx_set_config_regs(str
 	}
 }
 
+static void stac92xx_enable_eapd(struct hda_codec *codec)
+{
+	/* Configure GPIO0 as output */
+	snd_hda_codec_write(codec, codec->afg, 0, AC_VERB_SET_GPIO_DIRECTION, 0x00000001);
+	/* Configure GPIO0 as CMOS */
+	snd_hda_codec_write(codec, codec->afg, 0, 0x7e7, 0x00000000);
+	/* Assert GPIO0 high */
+	snd_hda_codec_write(codec, codec->afg, 0, AC_VERB_SET_GPIO_DATA, 0x00000001);
+	/* Enable GPIO0 */
+	snd_hda_codec_write(codec, codec->afg, 0, AC_VERB_SET_GPIO_MASK, 0x00000001);
+}
+
 /*
  * Analog playback callbacks
  */
@@ -2193,7 +2205,8 @@ static int patch_stac927x(struct hda_cod
 	}
 
 	spec->multiout.dac_nids = spec->dac_nids;
-
+	stac92xx_enable_eapd(codec);
+	
 	err = stac92xx_parse_auto_config(codec, 0x1e, 0x20);
 	if (!err) {
 		if (spec->board_config < 0) {
@@ -2254,18 +2267,7 @@ static int patch_stac9205(struct hda_cod
 	spec->mixer = stac9205_mixer;
 
 	spec->multiout.dac_nids = spec->dac_nids;
-
-	/* Configure GPIO0 as EAPD output */
-	snd_hda_codec_write(codec, codec->afg, 0,
-			    AC_VERB_SET_GPIO_DIRECTION, 0x00000001);
-	/* Configure GPIO0 as CMOS */
-	snd_hda_codec_write(codec, codec->afg, 0, 0x7e7, 0x00000000);
-	/* Assert GPIO0 high */
-	snd_hda_codec_write(codec, codec->afg, 0,
-			    AC_VERB_SET_GPIO_DATA, 0x00000001);
-	/* Enable GPIO0 */
-	snd_hda_codec_write(codec, codec->afg, 0,
-			    AC_VERB_SET_GPIO_MASK, 0x00000001);
+	stac92xx_enable_eapd(codec);
 
 	err = stac92xx_parse_auto_config(codec, 0x1f, 0x20);
 	if (!err) {

--------------040804050509030106090004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040804050509030106090004--
