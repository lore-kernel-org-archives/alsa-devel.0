From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Static versus shared builds of alsa-utils
Date: Sun, 31 Aug 2003 20:34:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308312034.57045.adrian@mcmen.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

I am trying to build alsa-utils using a cross compiler.

AFAICS I have successfully built alsalib (as static as I have no glibc on=
 the=20
target system - it runs a static busybox), and I thought I had successful=
ly=20
configured and built alsa-tools:

CC=3Dsh-linux-gcc ./configure --host=3Dsh-linux=20
--prefix=3D/home/Adrian/dc-down/initrd/usr=20
--with-alsa-prefix=3D/home/Adrian/dc-down/initrd/usr/lib=20
--with-alsa-inc-prefix=3D/home/Adrian/dc-down/initrd/usr/include=20
--disable-alsamixer --disable-shared

This certainly generates large (static?) binaries:

/usr/bin # ls a* -l
-rwxr-xr-x    1 0        0         2436157 Aug 31 19:26 aconnect
-rwxr-xr-x    1 0        0         2362584 Aug 31 11:58 alsalisp
-rwxr-xr-x    1 0        0         2458748 Aug 31 19:26 amixer
-rwxr-xr-x    1 0        0         2294664 Aug 31 19:26 aplay
lrwxrwxrwx    1 500      500            17 Apr  8 21:06 ar ->=20
=2E./../bin/busybox
lrwxrwxrwx    1 0        0               5 Aug 31 19:26 arecord -> aplay
-rwxr-xr-x    1 0        0         2470212 Aug 31 19:26 aseqnet
-rwxr-xr-x    1 0        0         2282674 Aug 31 11:58 aserver

But when I attempt to run any of them I get this problem:


/usr/bin # ./aplay test.txt
=2E/aplay: No such file or directory

What have I done wrong?

Adrian




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
