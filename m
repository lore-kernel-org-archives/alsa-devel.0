From: Tobin Davis <tdavis@dsl-only.net>
Subject: Fix logic error in headphone mute for Conexant codecs
Date: Fri, 23 Feb 2007 13:22:31 -0800
Message-ID: <1172265751.1575.11.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-dw5YGOhntLidMn3L5Pxi"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-dw5YGOhntLidMn3L5Pxi
Content-Type: multipart/alternative; boundary="=-rLQO74FrH0kyPMUdklNn"


--=-rLQO74FrH0kyPMUdklNn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a logic error introduced in the previous patch.
Without it, speaker automute mutes the speakers when headphones are
removed and unmutes when headphones are plugged in.

This was reported by Gregorio Guidi after getting the earlier patch off
this mailing list.

Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-rLQO74FrH0kyPMUdklNn
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
This patch fixes a logic error introduced in the previous patch.&nbsp; Without it, speaker automute mutes the speakers when headphones are removed and unmutes when headphones are plugged in.<BR>
<BR>
This was reported by <TT>Gregorio Guidi</TT> after getting the earlier patch off this mailing list.<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<BR>
Signed off by Tobin Davis &lt;tdavis@dsl-only.net&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-rLQO74FrH0kyPMUdklNn--

--=-dw5YGOhntLidMn3L5Pxi
Content-Disposition: attachment; filename=conexant-automute-fix.patch
Content-Type: text/x-patch; name=conexant-automute-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- patch_conexant.c.orig	2007-02-19 18:59:00.000000000 -0800
+++ patch_conexant.c	2007-02-23 10:57:32.000000000 -0800
@@ -629,10 +629,12 @@
 static void cxt5045_hp_automute(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
-	unsigned int bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0;
+	unsigned int bits;
 
 	spec->hp_present = snd_hda_codec_read(codec, 0x11, 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+
+	bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0;
 	snd_hda_codec_amp_update(codec, 0x10, 0, HDA_OUTPUT, 0, 0x80, bits);
 	snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0, 0x80, bits);
 }
@@ -979,10 +981,12 @@
 static void cxt5047_hp_automute(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
-	unsigned int bits = spec->hp_present || !spec->cur_eapd ? 0x80 : 0;
+	unsigned int bits;
 
 	spec->hp_present = snd_hda_codec_read(codec, 0x13, 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+
+	bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0;
 	snd_hda_codec_amp_update(codec, 0x1d, 0, HDA_OUTPUT, 0, 0x80, bits);
 	snd_hda_codec_amp_update(codec, 0x1d, 1, HDA_OUTPUT, 0, 0x80, bits);
 	/* Mute/Unmute PCM 2 for good measure - some systems need this */

--=-dw5YGOhntLidMn3L5Pxi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-dw5YGOhntLidMn3L5Pxi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-dw5YGOhntLidMn3L5Pxi--
