From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH] WM9712 fixes for ac97_patch.c
Date: Mon, 25 Sep 2006 16:15:06 +0100
Message-ID: <1159197306.27504.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-iufrYHQneMpmsMnZgN+r"
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
Cc: Luke Zhang <lzhang@intrinsyc.com>
List-Id: alsa-devel@alsa-project.org


--=-iufrYHQneMpmsMnZgN+r
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch by Luke Zhang fixes a couple of issues with the WM9712
support in ac97_patch.c

Changes:-

 o Fix Out3 ZC switch invert.
 o Extend capture volume control to 6 bits.
 o Change Mic 1 volume mask to 5 bits (31).
 o Add Mic 2 volume.

Signed-off-by: Luke Zhang <lzhang@intrinsyc.com>
Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

--=-iufrYHQneMpmsMnZgN+r
Content-Disposition: attachment; filename=wm9712.patch
Content-Type: text/x-patch; name=wm9712.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r bfec5c1bf1cc pci/ac97/ac97_patch.c
--- a/pci/ac97/ac97_patch.c	Sun Sep 17 22:05:54 2006 +0200
+++ b/pci/ac97/ac97_patch.c	Mon Sep 25 15:52:13 2006 +0100
@@ -530,7 +530,7 @@ AC97_SINGLE("ALC Headphone Volume", AC97
 AC97_SINGLE("ALC Headphone Volume", AC97_VIDEO, 7, 7, 1),
 
 AC97_SINGLE("Out3 Switch", AC97_AUX, 15, 1, 1),
-AC97_SINGLE("Out3 ZC Switch", AC97_AUX, 7, 1, 1),
+AC97_SINGLE("Out3 ZC Switch", AC97_AUX, 7, 1, 0),
 AC97_ENUM("Out3 Mux", wm9711_enum[2]),
 AC97_ENUM("Out3 LR Mux", wm9711_enum[3]),
 AC97_SINGLE("Out3 Volume", AC97_AUX, 0, 31, 1),
@@ -575,13 +575,14 @@ AC97_SINGLE("Playback Attenuate (-6dB) S
 
 AC97_SINGLE("ADC Switch", AC97_REC_GAIN, 15, 1, 1),
 AC97_ENUM("Capture Volume Steps", wm9711_enum[6]),
-AC97_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 15, 1),
+AC97_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 63, 1),
 AC97_SINGLE("Capture ZC Switch", AC97_REC_GAIN, 7, 1, 0),
 
 AC97_SINGLE("Mic 1 to Phone Switch", AC97_MIC, 14, 1, 1),
 AC97_SINGLE("Mic 2 to Phone Switch", AC97_MIC, 13, 1, 1),
 AC97_ENUM("Mic Select Source", wm9711_enum[7]),
-AC97_SINGLE("Mic 1 Volume", AC97_MIC, 8, 32, 1),
+AC97_SINGLE("Mic 1 Volume", AC97_MIC, 8, 31, 1),
+AC97_SINGLE("Mic 2 Volume", AC97_MIC, 0, 31, 1),
 AC97_SINGLE("Mic 20dB Boost Switch", AC97_MIC, 7, 1, 0),
 
 AC97_SINGLE("Master ZC Switch", AC97_MASTER, 7, 1, 0),

--=-iufrYHQneMpmsMnZgN+r
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-iufrYHQneMpmsMnZgN+r
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-iufrYHQneMpmsMnZgN+r--
