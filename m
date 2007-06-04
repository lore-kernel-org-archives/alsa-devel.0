From: Michael Gerdau <mgd@technosis.de>
Subject: Re: v1.0.14 - test packages #2
Date: Mon, 4 Jun 2007 11:50:58 +0200
Message-ID: <200706041151.10173.mgd@technosis.de>
References: <Pine.LNX.4.61.0706040930220.7767@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2676609098226055700=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server021.webpack.hosteurope.de
	(server021.webpack.hosteurope.de [80.237.130.29])
	by alsa0.perex.cz (Postfix) with ESMTP id DCD2724543
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2007 11:51:11 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0706040930220.7767@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============2676609098226055700==
Content-Type: multipart/signed;
  boundary="nextPart2184986.V9QkxFcdyt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2184986.V9QkxFcdyt
Content-Type: multipart/mixed;
  boundary="Boundary-01=_CC+YGuy9wHU989h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_CC+YGuy9wHU989h
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jaroslav,

> 	I recreated driver and tools packages in /pub/testing to fix
> reported problems. Please, test...

configure still fails for me in subdir qlo10k1 of alsa-tools-1.0.14.

I'm on openSUSE 10.2, x86_64. The problem most likely has to do with
correctly finding the 64bit Qt libs.

=46ind the output of './configure --prefix=3D/usr' attached.

Best,
Michael

=2D-=20
 Technosis GmbH, Gesch=E4ftsf=FChrer: Michael Gerdau, Tobias Dittmar
 Sitz Hamburg; HRB 89145 Amtsgericht Hamburg
 Vote against SPAM - see http://www.politik-digital.de/spam/
 Michael Gerdau       email: mgd@technosis.de
 GPG-keys available on request or at public keyserver

--Boundary-01=_CC+YGuy9wHU989h
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="alsa-tools-err2.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="alsa-tools-err2.log"

Current dir is /home/mgd/ftp/audio/alsa/1.0.14-testing/alsa-tools-1.0.14/ql=
o10k1
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for g++... g++
checking for C++ compiler default output file name... a.out
checking whether the C++ compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...=20
checking for suffix of object files... o
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking for style of include used by make... GNU
checking dependency style of g++... gcc3
checking for a sed that does not truncate output... /usr/bin/sed
checking for gcc... gcc
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking dependency style of gcc... gcc3
checking build system type... x86_64-suse-linux-gnu
checking host system type... x86_64-suse-linux-gnu
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for ld used by gcc... /usr/x86_64-suse-linux/bin/ld
checking if the linker (/usr/x86_64-suse-linux/bin/ld) is GNU ld... yes
checking for a BSD-compatible install... /usr/bin/install -c
checking for /usr/x86_64-suse-linux/bin/ld option to reload object files...=
 -r
checking for BSD-compatible nm... /usr/bin/nm -B
checking whether ln -s works... yes
checking how to recognise dependent libraries... pass_all
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking dlfcn.h usability... yes
checking dlfcn.h presence... yes
checking for dlfcn.h... yes
checking how to run the C++ preprocessor... g++ -E
checking for g77... no
checking for f77... no
checking for xlf... no
checking for frt... no
checking for pgf77... no
checking for cf77... no
checking for fort77... no
checking for fl32... no
checking for af77... no
checking for f90... no
checking for xlf90... no
checking for pgf90... no
checking for pghpf... no
checking for epcf90... no
checking for gfortran... gfortran
checking whether we are using the GNU Fortran 77 compiler... yes
checking whether gfortran accepts -g... yes
checking the maximum length of command line arguments... 32768
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for objdir... .libs
checking for ar... ar
checking for ranlib... ranlib
checking for strip... strip
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC
checking if gcc PIC flag -fPIC works... yes
checking if gcc static flag -static works... yes
checking if gcc supports -c -o file.o... yes
checking whether the gcc linker (/usr/x86_64-suse-linux/bin/ld -m elf_x86_6=
4) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... cat: /etc/ld.so.conf.d/*.conf: N=
o such file or directory
GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
configure: creating libtool
appending configuration tag "CXX" to libtool
checking for ld used by g++... /usr/x86_64-suse-linux/bin/ld -m elf_x86_64
checking if the linker (/usr/x86_64-suse-linux/bin/ld -m elf_x86_64) is GNU=
 ld... yes
checking whether the g++ linker (/usr/x86_64-suse-linux/bin/ld -m elf_x86_6=
4) supports shared libraries... yes
checking for g++ option to produce PIC... -fPIC
checking if g++ PIC flag -fPIC works... yes
checking if g++ static flag -static works... yes
checking if g++ supports -c -o file.o... yes
checking whether the g++ linker (/usr/x86_64-suse-linux/bin/ld -m elf_x86_6=
4) supports shared libraries... yes
checking dynamic linker characteristics... cat: /etc/ld.so.conf.d/*.conf: N=
o such file or directory
GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
appending configuration tag "F77" to libtool
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for gfortran option to produce PIC... -fPIC
checking if gfortran PIC flag -fPIC works... yes
checking if gfortran static flag -static works... yes
checking if gfortran supports -c -o file.o... yes
checking whether the gfortran linker (/usr/x86_64-suse-linux/bin/ld -m elf_=
x86_64) supports shared libraries... yes
checking dynamic linker characteristics... cat: /etc/ld.so.conf.d/*.conf: N=
o such file or directory
GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether byte ordering is bigendian... no
checking for X... libraries /usr/lib64, headers=20
checking QTDIR... /usr/lib/qt3
checking Qt version... 338 (3)
checking for moc... /usr/lib/qt3/bin/moc
checking for uic... /usr/lib/qt3/bin/uic
checking for qembed... /usr/lib/qt3/bin/qembed
configure: error: *** Couldn't find any Qt libraries
make: *** Keine Targets angegeben und keine =C2=BBmake=C2=AB-Steuerdatei ge=
funden.  Schluss.

--Boundary-01=_CC+YGuy9wHU989h--

--nextPart2184986.V9QkxFcdyt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGY+COUYYhyuxDQc4RAo+7AJ4+v6N651L7sy1//3U+OEGRGYxXHgCfSBNL
nnlPoJFct/yia+G7jHkygrU=
=LGDr
-----END PGP SIGNATURE-----

--nextPart2184986.V9QkxFcdyt--

--===============2676609098226055700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2676609098226055700==--
