From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] wishlist: add details for the audigy player box version
Date: Fri, 27 May 2005 13:22:31 +0200
Message-ID: <85mzqgx6a0.fsf@Orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

--=-=-=

Hi,

In the cvs, only the audigy player with subsystem 0x1102,0x0053 is
known. This patch add details for the card with subsystem 0x1102,0x0051
which is in fact the same card. The 0x0053 is the OEM version and the
0x0051 is the box version. 

Regards,
Arnaud Patard
 
--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=add_audigy_player_box.patch

Add details for the audigy player box version.

Signed-Off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---

Index: emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.55
diff -u -r1.55 emu10k1_main.c
--- emu10k1_main.c	10 Apr 2005 14:43:35 -0000	1.55
+++ emu10k1_main.c	25 Apr 2005 09:56:34 -0000
@@ -700,6 +700,12 @@
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x00511102,
+	 .driver = "Audigy", .name = "Audigy 1 [SB0090]", 
+	 .id = "Audigy",
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004,
 	 .driver = "Audigy", .name = "Audigy 1 [Unknown]", 
 	 .id = "Audigy",

--=-=-=--



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
