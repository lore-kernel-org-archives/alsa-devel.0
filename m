From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] alsa-driver/Makefile fix
Date: Fri, 16 May 2003 08:33:19 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305160827420.4782-100000@studcom.urz.uni-halle.de>
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


my shell doesn't like unterminated commands before fi


Index: alsa-driver/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/Makefile,v
retrieving revision 1.93
diff -u -r1.93 Makefile
--- alsa-driver/Makefile	13 May 2003 11:08:07 -0000	1.93
+++ alsa-driver/Makefile	16 May 2003 06:23:49 -0000
@@ -111,7 +111,7 @@
 	@if [ -L /dev/snd ]; then \
 		echo "The ALSA devices were removed from /proc/asound/dev directory." ; \
 		echo "Creating static device entries in /dev/snd." ; \
-		$TOPDIR/snddevices \
+		$(TOPDIR)/snddevices; \
 	fi
 	cat WARNING





-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
