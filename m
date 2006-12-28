From: Tobin Davis <tdavis@dsl-only.net>
Subject: Change default config for Asus P5GD1
Date: Thu, 28 Dec 2006 08:07:44 -0800
Message-ID: <1167322064.9563.75.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-z3MCLV7aJD6s8pQ+OQ8T"
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


--=-z3MCLV7aJD6s8pQ+OQ8T
Content-Type: multipart/alternative; boundary="=-z2u7/Qxvc794ng2J/e4y"


--=-z2u7/Qxvc794ng2J/e4y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch changes the default configuration for the Asus P5GD1
motherboard from 5stack to asus, as reported by stelek on
linuxquestions.org
(http://www.linuxquestions.org/questions/showthread.php?p=2556497#post2556497).



Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-z2u7/Qxvc794ng2J/e4y
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
This patch changes the default configuration for the Asus P5GD1 motherboard from 5stack to asus, as reported by <A HREF="http://www.linuxquestions.org/questions/member.php?u=312965">stelek</A> on linuxquestions.org (<A HREF="http://www.linuxquestions.org/questions/showthread.php?p=2556497#post2556497).">http://www.linuxquestions.org/questions/showthread.php?p=2556497#post2556497).</A><BR>
<BR>
<BR>
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

--=-z2u7/Qxvc794ng2J/e4y--

--=-z3MCLV7aJD6s8pQ+OQ8T
Content-Disposition: attachment; filename=Asus-P5GD1.patch
Content-Type: text/x-patch; name=Asus-P5GD1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 9998aa91f5da pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Fri Dec 22 12:44:25 2006 +0100
+++ b/pci/hda/patch_realtek.c	Mon Dec 25 18:33:37 2006 -0800
@@ -2382,7 +2382,7 @@ static struct snd_pci_quirk alc880_cfg_t
 	/* SND_PCI_QUIRK(0x1043, 0x1964, "ASUS", ALC880_ASUS_DIG), */
 	SND_PCI_QUIRK(0x1043, 0x1973, "ASUS", ALC880_ASUS_DIG),
 	SND_PCI_QUIRK(0x1043, 0x19b3, "ASUS", ALC880_ASUS_DIG),
-	SND_PCI_QUIRK(0x1043, 0x814e, "ASUS", ALC880_5ST),
+	SND_PCI_QUIRK(0x1043, 0x814e, "ASUS", ALC880_ASUS),
 	SND_PCI_QUIRK(0x1043, 0x8181, "ASUS P4GPL", ALC880_ASUS_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8196, "ASUS P5GD1", ALC880_6ST),
 	SND_PCI_QUIRK(0x1043, 0x81b4, "ASUS", ALC880_6ST),
@@ -4738,6 +4738,7 @@ static struct snd_pci_quirk alc882_cfg_t
 	SND_PCI_QUIRK(0x105b, 0x6668, "Foxconn", ALC882_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x6668, "MSI", ALC882_6ST_DIG),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Arima W820", ALC882_ARIMA),
+	SND_PCI_QUIRK(0x1043, 0x81d8, "Asus P5WD", ALC882_6ST_DIG),
 	{}
 };
 

--=-z3MCLV7aJD6s8pQ+OQ8T
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-z3MCLV7aJD6s8pQ+OQ8T
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-z3MCLV7aJD6s8pQ+OQ8T--
