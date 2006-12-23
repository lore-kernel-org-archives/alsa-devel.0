From: Tobin Davis <tdavis@dsl-only.net>
Subject: Add Asus P5W DH to alc882_cfg_tbl
Date: Fri, 22 Dec 2006 22:45:18 -0800
Message-ID: <1166856318.12749.24.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Ze01ZwRxl1gT5nPmkfXm"
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


--=-Ze01ZwRxl1gT5nPmkfXm
Content-Type: multipart/alternative; boundary="=-H+2mBAq3tTFBGKe6Hw0n"


--=-H+2mBAq3tTFBGKe6Hw0n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds the Asus P5W DH to the ALC882 config table as a
6stack-dig system.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-H+2mBAq3tTFBGKe6Hw0n
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
This patch adds the Asus P5W DH to the ALC882 config table as a 6stack-dig system.<BR>
<BR>
<BR>
Signed off by Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</BODY>
</HTML>

--=-H+2mBAq3tTFBGKe6Hw0n--

--=-Ze01ZwRxl1gT5nPmkfXm
Content-Disposition: attachment; filename=Asus-P5W.patch
Content-Type: text/x-patch; name=Asus-P5W.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 9998aa91f5da pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Fri Dec 22 12:44:25 2006 +0100
+++ b/pci/hda/patch_realtek.c	Fri Dec 22 22:44:46 2006 -0800
@@ -4738,6 +4738,7 @@ static struct snd_pci_quirk alc882_cfg_t
 	SND_PCI_QUIRK(0x105b, 0x6668, "Foxconn", ALC882_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x6668, "MSI", ALC882_6ST_DIG),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Arima W820", ALC882_ARIMA),
+	SND_PCI_QUIRK(0x1043, 0x81d8, "Asus P5WD", ALC882_6ST_DIG),
 	{}
 };
 

--=-Ze01ZwRxl1gT5nPmkfXm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-Ze01ZwRxl1gT5nPmkfXm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-Ze01ZwRxl1gT5nPmkfXm--
