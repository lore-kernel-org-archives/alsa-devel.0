From: Kevin Mack <kevmack@accesscomm.ca>
Subject: [PATCH] Gateway M675 tweak
Date: Wed, 26 May 2004 00:57:31 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040526065731.GA25324@athlonpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Nobody complained, but this will direct mixer output
to speaker, headphone and line-out instead of just
the front(DAC-A) signal.


--- ../alsa-driver-1.0.5rc1/alsa-kernel/pci/ac97/ac97_patch.c	2004-05-24 07:24:42.000000000 -0600
+++ alsa-kernel/pci/ac97/ac97_patch.c	2004-05-26 00:12:39.000000000 -0600
@@ -648,7 +648,7 @@
 		/* VARIOUS */ 0x0040
 	};
 	static unsigned short m675_regs[4] = {
-		/* OUTSEL */ 0x9040, /* CL:FR, SR:FR, LO:DS, LI:FR, MI:DS */
+		/* OUTSEL */ 0xfc70, /* CL:MX, SR:MX, LO:DS, LI:MX, MI:DS */
 		/* IOMISC */ 0x2102, /* HP amp on */
 		/* INSEL */ 0x0203, /* LI:LI, MI:FR */
 		/* VARIOUS */ 0x0041 /* stereo mic */


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
