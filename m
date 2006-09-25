From: Tobin Davis <tdavis@dsl-only.net>
Subject: Patch to add new Acer device ids.
Date: Mon, 25 Sep 2006 08:27:55 -0700
Message-ID: <1159198076.7201.218.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-h6ZH9VLOlXaTtrpvnjef"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-h6ZH9VLOlXaTtrpvnjef
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Summary:  Add new subdevice ids for hda-intel.

This patch adds a couple of device ids for Acer laptops.  In both cases,
the owners got the driver working by adding "model=acer" to their
modprobe.conf files.

Signed off by:
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-h6ZH9VLOlXaTtrpvnjef
Content-Disposition: attachment; filename=acer.patch
Content-Type: text/x-patch; name=acer.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- patch_realtek.c.orig	2006-09-25 08:20:33.000000000 -0700
+++ patch_realtek.c	2006-09-25 08:22:29.000000000 -0700
@@ -5076,6 +5076,10 @@
 	{ .modelname = "acer", .config = ALC883_ACER },
 	{ .pci_subvendor = 0x1025, .pci_subdevice = 0x006c,
 	  .config = ALC883_ACER },
+	{ .pci_subvendor = 0x1025, .pci_subdevice = 0x0102,
+	  .config = ALC883_ACER },
+	{ .pci_subvendor = 0x1025, .pci_subdevice = 0x009f,
+	  .config = ALC883_ACER },
 	{ .modelname = "auto", .config = ALC883_AUTO },
 	{}
 };

--=-h6ZH9VLOlXaTtrpvnjef
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-h6ZH9VLOlXaTtrpvnjef
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-h6ZH9VLOlXaTtrpvnjef--
