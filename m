From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] Kconfig entry for Bt87x
Date: Mon, 08 Dec 2003 15:53:05 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0312081549190.24764-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Index: alsa-driver/pci/Kconfig
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/Kconfig,v
retrieving revision 1.6
diff -u -r1.6 Kconfig
--- alsa-driver/pci/Kconfig	6 Oct 2003 14:01:01 -0000	1.6
+++ alsa-driver/pci/Kconfig	8 Dec 2003 13:14:18 -0000
@@ -28,4 +28,11 @@
         depends on SND
         help
           Say 'Y' or 'M' to include support for Aureal Vortex 2 soundcards.
-
+
+config SND_BT87X
+	tristate "Bt87x Audio Capture"
+	depends on SND
+	help
+	  Say 'Y' or 'M' to include support for recording audio from TV cards
+	  based on Brooktree Bt878/Bt879 chips.
+




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
