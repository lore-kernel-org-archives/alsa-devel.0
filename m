From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix typo in opl3-synth dependency
Date: Wed, 13 Nov 2002 10:24:15 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211131021450.10735-100000@studcom.urz.uni-halle.de>
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


Index: alsa-kernel/drivers/opl3/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/opl3/Makefile,v
retrieving revision 1.13
diff -u -r1.13 Makefile
--- alsa-kernel/drivers/opl3/Makefile	4 Nov 2002 10:05:19 -0000	1.13
+++ alsa-kernel/drivers/opl3/Makefile	13 Nov 2002 09:20:08 -0000
@@ -15,7 +15,7 @@

 OPL3_OBJS = snd-opl3-lib.o
 ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
-OBJ3_OBJS += snd-opl3-synth.o
+OPL3_OBJS += snd-opl3-synth.o
 endif

 # Toplevel Module Dependency



-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
