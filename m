From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] intel8x0.c: fix typo
Date: Mon, 11 Aug 2003 13:21:33 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0308111319430.2094-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


fix mixed up vendor/device ID's for Asus P4P800


Index: alsa-kernel/pci/intel8x0.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0.c,v
retrieving revision 1.87
diff -u -r1.87 intel8x0.c
--- alsa-kernel/pci/intel8x0.c	30 Jul 2003 14:39:38 -0000	1.87
+++ alsa-kernel/pci/intel8x0.c	11 Aug 2003 11:16:08 -0000
@@ -1569,6 +1569,12 @@
 		.type = AC97_TUNE_SWAP_SURROUND
 	},
 	{
+		.vendor = 0x1043,
+		.device = 0x80f3,
+		.name = "ASUS ICH5/AD1985",
+		.type = AC97_TUNE_AD_SHARING
+	},
+	{
 		.vendor = 0x10f1,
 		.device = 0x2665,
 		.name = "Fujitsu-Siemens Celcius",
@@ -1641,12 +1647,6 @@
 		.mask = 0xfff0,
 		.name = "Intel ICH5/AD1985 (discrete)",
 		.type = AC97_TUNE_HP_ONLY
-	},
-	{
-		.vendor = 0x80f3,
-		.device = 0x1043,
-		.name = "ASUS ICH5/AD1985",
-		.type = AC97_TUNE_AD_SHARING
 	},
 	{ } /* terminator */
 };




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
