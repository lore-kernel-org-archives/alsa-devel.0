From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix for INSTALL docs
Date: Tue, 02 Sep 2003 17:32:52 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309021731330.5961-100000@studcom.urz.uni-halle.de>
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


The installation docs don't yet mention that 'make' is to be run
before 'make install'.


Index: alsa-driver/INSTALL
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/INSTALL,v
retrieving revision 1.144
diff -u -r1.144 INSTALL
--- alsa-driver/INSTALL	22 Jul 2003 13:39:10 -0000	1.144
+++ alsa-driver/INSTALL	2 Sep 2003 15:29:54 -0000
@@ -39,11 +39,12 @@
    If you have kernel source code in another directory than /usr/src/linux,
    use --with-kernel=<kernel_directory>.
    Example: ./configure --with-isapnp=yes --with-debug=full
-4) Run 'make install'.
-5) Run the './snddevices' script to create new sound devices in /dev directory.
+4) Run 'make'.
+5) Run 'make install'.
+6) Run the './snddevices' script to create new sound devices in /dev directory.
    Skip this step, if you have a kernel with the DEVFS support.
-6) Edit your /etc/modules.conf (see the kmod support section below).
-7) Run 'modprobe snd-xxxx' where xxxx is the name of your card.
+7) Edit your /etc/modules.conf (see the kmod support section below).
+8) Run 'modprobe snd-xxxx' where xxxx is the name of your card.
    Note: If you have a ISA PnP soundcard you need to first run the isapnp
          program from isapnptools package to initialize your
          soundcard. You can also use the native ISA PnP support by




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
