From: Tobin Davis <tdavis@dsl-only.net>
Subject: hda-codec:  Add Sony VGC-LA1 to patch_sigmatel.c
Date: Sat, 10 Mar 2007 13:22:40 -0800
Message-ID: <1173561760.4531.300.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-lXCEU4zkgn5e/pOvFvyQ"
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


--=-lXCEU4zkgn5e/pOvFvyQ
Content-Type: multipart/alternative; boundary="=-jGK+zu57gugGA+WT7vSe"


--=-jGK+zu57gugGA+WT7vSe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds the Sony Vaio VGC-LA1 to the stac9872_cfg_tbl.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-jGK+zu57gugGA+WT7vSe
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
This patch adds the Sony Vaio VGC-LA1 to the stac9872_cfg_tbl.<BR>
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

--=-jGK+zu57gugGA+WT7vSe--

--=-lXCEU4zkgn5e/pOvFvyQ
Content-Disposition: attachment; filename=Sony-Vaio.patch
Content-Type: text/x-patch; name=Sony-Vaio.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 6888d4cd251d pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Mar 08 12:53:55 2007 +0100
+++ b/pci/hda/patch_sigmatel.c	Sat Mar 10 12:57:25 2007 -0800
@@ -2276,6 +2294,7 @@ static struct snd_pci_quirk stac9872_cfg
 	SND_PCI_QUIRK(0x104d, 0x81e6, "Sony VAIO F/S", CXD9872RD_VAIO),
 	SND_PCI_QUIRK(0x104d, 0x81ef, "Sony VAIO F/S", CXD9872RD_VAIO),
 	SND_PCI_QUIRK(0x104d, 0x81fd, "Sony VAIO AR", CXD9872AKD_VAIO),
+	SND_PCI_QUIRK(0x104d, 0x8205, "Sony VAIO AR", CXD9872AKD_VAIO),
 	{}
 };
 

--=-lXCEU4zkgn5e/pOvFvyQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-lXCEU4zkgn5e/pOvFvyQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-lXCEU4zkgn5e/pOvFvyQ--
