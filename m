From: "Martin Holzer" <mholzer@gentoo.org>
Subject: alsa-tools-1.0.0_rc1 has broken gcc 2.9x support
Date: Tue, 2 Dec 2003 17:04:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <004c01c3b8ed$e8e9c420$0801a8c0@svrmarty.gnome.at>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

configure: WARNING: If you wanted to set the --build type, don't use =
--host.
    If a cross compiler is detected then cross compile mode will be =
used.
checking for a BSD-compatible install... /bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for i686-pc-linux-gnu-strip... no
checking for strip... strip
checking for i686-pc-linux-gnu-g++... g++
checking for C++ compiler default output file name... a.out
checking whether the C++ compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking for style of include used by make... GNU
checking dependency style of g++... gcc
checking whether make sets $(MAKE)... (cached) yes
checking for i686-pc-linux-gnu-gcc... gcc
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none needed
checking dependency style of gcc... gcc
checking how to run the C preprocessor... gcc -E
checking for egrep... grep -E
checking for ANSI C header files... yes
checking for X... libraries /usr/X11R6/lib, headers /usr/X11R6/include
checking for ALSA CFLAGS...
checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
checking for libasound headers version >=3D 1.0.0... found.
checking for snd_ctl_open in -lasound... yes
checking for kernel header files... =
/lib/modules/2.6.0-test11/build/include
checking for directory with ALSA kernel headers...
-I/lib/modules/2.6.0-test11/build/include
checking for fltk-config... /usr/bin/fltk-config
configure: creating ./config.status
config.status: creating Makefile
config.status: creating src/Makefile
config.status: creating pixmaps/Makefile
config.status: executing depfiles commands
Making all in src
make[1]: Entering directory
`/var/tmp/portage/alsa-tools-1.0.0_rc1/work/alsa-tools-1.0.0rc1/hdspmixer=
/sr
c'
source=3D'hdspmixer.cxx' object=3D'hdspmixer.o' libtool=3Dno \
depfile=3D'.deps/hdspmixer.Po' tmpdepfile=3D'.deps/hdspmixer.TPo' \
depmode=3Dgcc /bin/sh ../depcomp \
g++ -DPACKAGE_NAME=3D\"\" -DPACKAGE_TARNAME=3D\"\" =
-DPACKAGE_VERSION=3D\"\"
-DPACKAGE_STRING=3D\"\" -DPACKAGE_BUGREPORT=3D\"\" =
-DPACKAGE=3D\"hdspmixer\"
-DVERSION=3D\"1.6\" -DSTDC_HEADERS=3D1 -DHAVE_LIBASOUND=3D1  -I. -I.
-I/usr/include/fltk-1.1  -march=3Di686 -O3 -pipe -ffast-math
-fomit-frame-pointer -I/lib/modules/2.6.0-test11/build/include
-I/lib/modules/2.6.0-test11/build/include -I/usr/include/fltk-1.1
-march=3Di686 -O3 -pipe -ffast-math -fomit-frame-pointer =
-I/usr/X11R6/include
-fno-exceptions -c -o hdspmixer.o `test -f 'hdspmixer.cxx' || echo
'./'`hdspmixer.cxx
In file included from hdspmixer.cxx:31:
HDSPMixerCard.h:57: syntax error before `;'
hdspmixer.cxx: In function `int main(int, char **)':
hdspmixer.cxx:68: `H9632' undeclared (first use this function)
hdspmixer.cxx:68: (Each undeclared identifier is reported only once
hdspmixer.cxx:68: for each function it appears in.)
make[1]: *** [hdspmixer.o] Error 1
make[1]: Leaving directory
`/var/tmp/portage/alsa-tools-1.0.0_rc1/work/alsa-tools-1.0.0rc1/hdspmixer=
/sr
c'
make: *** [all-recursive] Error 1


Martin Holzer
sVrmARTY-/irc.freenode.net

Bug-Wrangler, Gentoo Linux
=20



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
