From: Stig Mogensen <smogensen@dkik.dk>
Subject: As requested in error output.
Date: Wed, 22 Sep 2004 18:52:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409221852.50338.smogensen@dkik.dk>
Reply-To: smogensen@dkik.dk
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from relay.webpartner.dk (relay.webpartner.dk [195.184.96.12])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4C09E354
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2004 18:52:58 +0200 (MEST)
Received: from [10.0.0.137] (unknown [213.173.232.178])
	by relay.webpartner.dk (Postfix) with ESMTP id 024C5151C93
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2004 18:52:50 +0200 (CEST)
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>> emerge (8 of 9) media-sound/alsa-driver-1.0.6a to /
>>> md5 src_uri ;-) alsa-driver-1.0.6a.tar.bz2
>>> Unpacking source...
>>> Unpacking alsa-driver-1.0.6a.tar.bz2=20
to /var/tmp/portage/alsa-driver-1.0.6a/work
 * Applying alsa-driver-1.0.5-devfix.patch...                              =
          =20
[ ok ]
 * Applying alsa-driver-1.0.5a-cs46xx-passthrough.patch...                 =
          =20
[ ok ]
 * Applying alsa-driver-1.0.6a-kbuild.patch...                             =
          =20
[ ok ]
 * /usr/src/linux is a symbolic link
 * Determining the real directory of the Linux kernel source code
 * Building for Linux 2.6.8.1 found in /usr/src/linux
 * /usr/src/linux is a symbolic link
 * Determining the real directory of the Linux kernel source code
 * Building for Linux 2.6.8.1 found in /usr/src/linux
>>> Source unpacked.
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for i686-pc-linux-gnu-gcc... gcc
checking for C compiler default output... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none needed
checking for i686-pc-linux-gnu-ranlib... no
checking for ranlib... ranlib
checking for a BSD-compatible install... /bin/install -c
checking how to run the C preprocessor... gcc -E
checking for egrep... grep -E
checking for ANSI C header files... yes
checking for an ANSI C-conforming const... yes
checking for inline... inline
checking whether time.h and sys/time.h may both be included... yes
checking whether gcc needs -traditional... no
checking for current=20
directory... /var/tmp/portage/alsa-driver-1.0.6a/work/alsa-driver-1.0.6a
checking cross compile...
checking for directory with kernel source... /usr/src/linux
checking for kernel version... 2.6.8.1
checking for GCC version... Kernel compiler: GCC 3.3.4 20040623 (Gentoo Lin=
ux=20
3.3.4-r1, ssp-3.3.2-2, pie-8.7.6) Used compiler: gcc (GCC) 3.3.4 20040623=20
(Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)
=46atal error: Compiler type does not match
Decoded kernel compiler: type=3D version=3D3.3.4
Decoded used compiler: type=3Dgcc version=3D3.3.4
Please, send ./configure output to <alsa-devel@alsa-project.org>

!!! ERROR: media-sound/alsa-driver-1.0.6a failed.
!!! Function econf, Line 362, Exitcode 1
!!! econf failed

bash-2.05b#      =20
=2D-=20
* Registered Linux user #291266, with =A0http://counter.li.org.*


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
