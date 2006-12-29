From: Tobin Davis <tdavis@dsl-only.net>
Subject: Add support for Toshiba M105 to Realtek patch.
Date: Thu, 28 Dec 2006 23:26:10 -0800
Message-ID: <1167377170.9563.170.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-W9r8fbVgXrbTny8aPp3R"
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


--=-W9r8fbVgXrbTny8aPp3R
Content-Type: multipart/alternative; boundary="=-QEDpHmAvvXdS2baNQ1Sa"


--=-QEDpHmAvvXdS2baNQ1Sa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for the Toshiba M105-S3041 laptop (ALC861).


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-QEDpHmAvvXdS2baNQ1Sa
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
This patch adds support for the Toshiba M105-S3041 laptop (ALC861).<BR>
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

--=-QEDpHmAvvXdS2baNQ1Sa--

--=-W9r8fbVgXrbTny8aPp3R
Content-Disposition: attachment; filename=toshiba-M105.patch
Content-Type: text/x-patch; name=toshiba-M105.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 9998aa91f5da pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Fri Dec 22 12:44:25 2006 +0100
+++ b/pci/hda/patch_realtek.c	Thu Dec 28 22:54:28 2006 -0800
@@ -7591,6 +7592,7 @@ static struct snd_pci_quirk alc861_cfg_t
 	SND_PCI_QUIRK(0x1043, 0x1338, "ASUS F2/3", ALC861_ASUS_LAPTOP),
 	SND_PCI_QUIRK(0x1043, 0x1393, "ASUS", ALC861_ASUS),
 	SND_PCI_QUIRK(0x1043, 0x81e7, "ASUS", ALC660_3ST),
+	SND_PCI_QUIRK(0x1179, 0xff00, "Toshiba", ALC861_TOSHIBA),
 	SND_PCI_QUIRK(0x1179, 0xff10, "Toshiba", ALC861_TOSHIBA),
 	SND_PCI_QUIRK(0x1584, 0x9072, "Uniwill m31", ALC861_UNIWILL_M31),
 	SND_PCI_QUIRK(0x8086, 0xd600, "Intel", ALC861_3ST),

--=-W9r8fbVgXrbTny8aPp3R
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-W9r8fbVgXrbTny8aPp3R
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-W9r8fbVgXrbTny8aPp3R--
