From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA-Codec: Add suppoprt for Asus M2N-SLI motherboard.
Date: Sun, 11 Mar 2007 13:56:02 -0700
Message-ID: <1173646562.4531.331.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-a0wC3N1xfKfI8z99amQd"
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


--=-a0wC3N1xfKfI8z99amQd
Content-Type: multipart/alternative; boundary="=-xeBZmuEf4ctcXnpBHvRi"


--=-xeBZmuEf4ctcXnpBHvRi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds a cfg_tbl to the ad1988 code with the Asus M2N-SLI as
it's first member.
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-xeBZmuEf4ctcXnpBHvRi
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
This patch adds a cfg_tbl to the ad1988 code with the Asus M2N-SLI as it's first member.<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-xeBZmuEf4ctcXnpBHvRi--

--=-a0wC3N1xfKfI8z99amQd
Content-Disposition: attachment; filename=Asus-M2N.patch
Content-Type: text/x-patch; name=Asus-M2N.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 6888d4cd251d pci/hda/patch_analog.c
--- a/pci/hda/patch_analog.c	Thu Mar 08 12:53:55 2007 +0100
+++ b/pci/hda/patch_analog.c	Sun Mar 11 13:22:23 2007 -0700
@@ -2607,6 +2636,11 @@ static const char *ad1988_models[AD1988_
 	[AD1988_AUTO]		= "auto",
 };
 
+static struct snd_pci_quirk ad1988_cfg_tbl[] = {
+	SND_PCI_QUIRK(0x1043, 0x81f6, "Asus M2N-SLI", AD1988_6STACK_DIG),
+	{}
+};
+
 static int patch_ad1988(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec;
@@ -2623,7 +2657,7 @@ static int patch_ad1988(struct hda_codec
 		snd_printk(KERN_INFO "patch_analog: AD1988A rev.2 is detected, enable workarounds\n");
 
 	board_config = snd_hda_check_board_config(codec, AD1988_MODEL_LAST,
-						  ad1988_models, NULL);
+						  ad1988_models, ad1988_cfg_tbl);
 	if (board_config < 0) {
 		printk(KERN_INFO "hda_codec: Unknown model for AD1988, trying auto-probe from BIOS...\n");
 		board_config = AD1988_AUTO;

--=-a0wC3N1xfKfI8z99amQd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-a0wC3N1xfKfI8z99amQd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-a0wC3N1xfKfI8z99amQd--
