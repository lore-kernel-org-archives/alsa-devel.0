From: "Martin Holzer" <mholzer@gentoo.org>
Subject: Alsa-tools 1.0.0 rc1 error with 2.6.0-test11
Date: Wed, 3 Dec 2003 00:02:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000401c3b928$6e273700$0801a8c0@svrmarty.gnome.at>
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

make[1]: Entering directory=20
`/var/tmp/portage/alsa-tools-1.0.0_rc1/work/alsa-tools-1.0.0rc1/hdspmixer=
/sr
c'=20
if g++ -DPACKAGE_NAME=3D\"\" -DPACKAGE_TARNAME=3D\"\"=20
-DPACKAGE_VERSION=3D\"\" -DPACKAGE_STRING=3D\"\"=20
-DPACKAGE_BUGREPORT=3D\"\"=20
-DPACKAGE=3D\"hdspmixer\" -DVERSION=3D\"1.6\" -DSTDC_HEADERS=3D1=20
-DHAVE_LIBASOUND=3D1  -I. -I.   -I/usr/include/fltk-1.1  -march=20
=3Dathlon-xp -O3 -pipe -fomit-frame-pointer=20
-I/lib/modules/2.6.0-test11-gentoo-r1/build/include
-I/lib/modules/2.6.0-test=20
11-gentoo-r1/build/include -I/usr/include/fltk-1.1 =
-I/usr/include/freetype2=20
-march=3Dathlon-xp -mcpu=3Dathlon-xp -O3 -pipe -=20
I/usr/X11R6/include -fno-exceptions -MT hdspmixer.o -MD -MP -MF=20
".deps/hdspmixer.Tpo" \=20
  -c -o hdspmixer.o `test -f 'hdspmixer.cxx' || echo './'`hdspmixer.cxx; =
\=20
then mv -f ".deps/hdspmixer.Tpo" ".deps/hdspmixer.Po"; \=20
else rm -f ".deps/hdspmixer.Tpo"; exit 1; \=20
fi=20
In file included from hdspmixer.cxx:31:=20
HDSPMixerCard.h:57: error: 'hdsp_9632_aeb_t' is used as a type, but is =
not=20
   defined as a type.=20
hdspmixer.cxx: In function `int main(int, char**)':=20
hdspmixer.cxx:68: error: `H9632' undeclared (first use this function)=20
hdspmixer.cxx:68: error: (Each undeclared identifier is reported only =
once
for=20
   each function it appears in.)=20
make[1]: *** [hdspmixer.o] Error 1=20
make[1]: Leaving directory=20
`/var/tmp/portage/alsa-tools-1.0.0_rc1/work/alsa-tools-1.0.0rc1/hdspmixer=
/sr
c'=20
make: *** [all-recursive] Error 1=20


Martin Holzer
sVrmARTY-/irc.freenode.net

Bug-Wrangler, Gentoo Linux
=20



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
