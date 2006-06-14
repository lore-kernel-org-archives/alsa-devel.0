From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: Re:
	=?iso-8859-1?q?=5BPATCH=5D_Better_detection_of_defau?=
	=?iso-8859-1?q?lt_firmware=09installation_directory?=
Date: Thu, 15 Jun 2006 09:26:26 +1200
Message-ID: <200606150926.28116.linux@blennerhassett.gen.nz>
References: <200606141006.41323.linux@blennerhassett.gen.nz>
	<s5h3be89exq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_D8HkEoZfuhzVgTz"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h3be89exq.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_D8HkEoZfuhzVgTz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 14 Jun 2006 23:04, Takashi Iwai wrote:
> > 

> The patch seems broken but the change suggested looks OK.
> Could you also change README together?

Attached complete files this time.  The patch was the output of 'hg diff'
Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Also Hg Makefile.am seems to be still missing asihpi from SUBDIRS
SUBDIRS = hdsploader mixartloader pcxhrloader usx2yloader vxloader \
echoaudio asihpi

regards

Eliot

--Boundary-00=_D8HkEoZfuhzVgTz
Content-Type: text/plain;
  charset="iso-8859-1";
  name="configure.in"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="configure.in"

AC_PREREQ(2.53)
AC_INIT(hdsploader/tobin.c)
AM_INIT_AUTOMAKE(alsa-firmware, 1.0.11)
AC_PROG_CC
AC_PROG_INSTALL
AC_HEADER_STDC

echo $VERSION > $srcdir/version

AC_ARG_ENABLE(loader,
  [  --disable-loader        Disable the old ALSA fw loader support],
  [loader="$enableval"],[loader=yes])
AC_ARG_ENABLE(hotplug,
  [  --disable-hotplug       Disable the hotplug fw loader support],
  [hotplug="$enableval"],[hotplug=yes])
AC_ARG_ENABLE(buildfw,
  [  --enable-buildfw        Enable building fw from source files],
  [buildfw="$enableval"],[buildfw=no])

AC_PATH_PROGS(AS31, as31)
AS31_FLAGS="-Fhex"
AC_SUBST(AS31_FLAGS)

if test x"${AS31}" = x"";  then
  buildfw=false
fi

AM_CONDITIONAL(USE_LOADER, test "$loader" = "yes")
AM_CONDITIONAL(USE_HOTPLUG, test "$hotplug" = "yes")
AM_CONDITIONAL(BUILD_FW, test "$buildfw" = "yes")

AC_MSG_CHECKING(firmware installation directory)
# where to put the firmware. If none of these is right, can specify where
# --with-hotplug-dir
if test -d /lib/firmware ; then
	detected_fwdir="/lib/firmware/"
elif test -d /lib/hotplug/firmware ; then
	detected_fwdir="/lib/hotplug/firmware/"
elif test -d /usr/lib/hotplug/firmware ; then
	detected_fwdir="/usr/lib/hotplug/firmware/"
else
	detected_fwdir="/lib/firmware/"
fi

AC_ARG_WITH(hotplug-dir,
  [  --with-hotplug-dir      Specify the hotplug firmware directory],
  [hotplugfwdir="$withval"],
  [hotplugfwdir="$detected_fwdir"])
HOTPLUGFWDIR="$hotplugfwdir"
AC_SUBST(HOTPLUGFWDIR)
AC_MSG_RESULT($HOTPLUGFWDIR)

AC_OUTPUT(Makefile \
	  hdsploader/Makefile \
	  mixartloader/Makefile \
	  usx2yloader/Makefile \
	  vxloader/Makefile \
	  pcxhrloader/Makefile \
	  echoaudio/Makefile \
	  asihpi/Makefile) 

--Boundary-00=_D8HkEoZfuhzVgTz
Content-Type: text/plain;
  charset="iso-8859-1";
  name="README"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="README"

GENERAL
=======

This package contains the firmware binaries for each loader program
included in alsa-tools package.  The firmware data can be used by each
ALSA firmware loader program like vxloader, or passed through the
hotplug firmware-loading mechanism.


HOTPLUG FIRMWARE LOADER SUPPORT
===============================

The recent ALSA driver supports the hotplug firmware loader.
As default, the package will install firmware data to the places for
both the old ALSA fw loader and the hotplug fw loader.  To disable
the installation of old ALSA fw loader data (if both ALSA and hotplug
fw loaders are available), pass --disable-loader to configure.
Similarly, to disable the hotplug fw loader data, pass
--disable-hotplug option.

For the old ALSA fw loader, specify the same prefix option given to
the alsa-tools configure script, too, in order to keep the
installation directories consistent.

The default directory for hotplug firmware data files is /lib/firmware.
(or if existing /lib/hotplug/firmware or /usr/lib/hotplug/firmware are 
found they are used)
You can change to another path via --with-hotplug-dir option.


LICENSE AND COPYRIGHT
=====================

The files contained in this package is regarded as the example data
for each alsa-tools program.  Hence, their copyright and license
follow basically to the definition of alsa-tools programs.  The
detailed license and copyright is found in README of each
subdirectory.

--Boundary-00=_D8HkEoZfuhzVgTz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_D8HkEoZfuhzVgTz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_D8HkEoZfuhzVgTz--
