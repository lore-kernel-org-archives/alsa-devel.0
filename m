From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix OPL4 detection
Date: Fri, 02 May 2003 11:06:37 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305021058090.15874-100000@studcom.urz.uni-halle.de>
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


The ymfpci chips are not compatible with the OPL4 but have the OPL4_ENABLE
bit, so this bit cannot be used to detect an OPL4. However, in the OPL3
driver, OPL4 detection isn't needed anyway because the OPL4 driver already
does it.


Index: alsa-kernel/drivers/opl3/opl3_lib.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/opl3/opl3_lib.c,v
retrieving revision 1.15
diff -u -r1.15 opl3_lib.c
--- alsa-kernel/drivers/opl3/opl3_lib.c	24 Mar 2003 10:34:37 -0000	1.15
+++ alsa-kernel/drivers/opl3/opl3_lib.c	2 May 2003 08:53:28 -0000
@@ -160,17 +160,11 @@
 		opl3->hardware = OPL3_HW_OPL2;
 	} else {
 		/*
-		 * Detect availability of OPL4. Unfortunately, the OPL4
-		 * port of the chip may not be connected to the PC bus.
+		 * If we had an OPL4 chip, opl3->hardware would have been set
+		 * by the OPL4 driver; so we can assume OPL3 here.
 		 */
 		snd_assert(opl3->r_port != 0, return -ENODEV);
-		opl3->command(opl3, OPL3_RIGHT | OPL3_REG_MODE, OPL3_OPL3_ENABLE | OPL3_OPL4_ENABLE);
-		/* All OPL4 registers are readable. */
-		if (inb(opl3->r_port + 1) == (OPL3_OPL3_ENABLE | OPL3_OPL4_ENABLE)) {
-			opl3->hardware = OPL3_HW_OPL4;
-		} else {
-			opl3->hardware = OPL3_HW_OPL3;
-		}
+		opl3->hardware = OPL3_HW_OPL3;
 	}
 	return 0;
 }




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
