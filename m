From: =?ISO-8859-1?Q?S=F8ren?= Wedel Nielsen <swn@herlevkollegiet.dk>
Subject: Re: envy24control and gtk2
Date: 30 Mar 2003 12:44:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049021088.1073.16.camel@v304.herlevkollegiet.dk>
References: <1048462242.1151.40.camel@v304.herlevkollegiet.dk>
	 <s5hbrzzpcpn.wl@alsa2.suse.de>
	 <1048621263.26669.34.camel@cmn37.Stanford.EDU>
	 <1048621867.3482.23.camel@v304.herlevkollegiet.dk>
	 <s5h65q6pk1h.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-btm9C91E7792JpsIImWf"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65q6pk1h.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-btm9C91E7792JpsIImWf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by valhalla.herlevkollegiet.dk id h2UAimr31786

ons, 2003-03-26 kl. 10:13 skrev Takashi Iwai:

> > For now the program will compile with gtk1 unless you apply the secon=
d
> > patch yourself. I will try to make it use gtk2 as default and fall ba=
ck
> > to gtk1 if gtk2 is not present.
>=20
> please note that, so far, we still don't define pkgconfig as default
> requirement for alsa-tools package...
> although i prefer pkgconfig, there are still old systems which don't
> have it.

On a computer with pkgconfig autoconf will generate a configure script
that will first try gtk2 and if that fails it will use gtk1.
On a computer without pkgconfig you will get a configure script that
will allways use gtk1.

The configure script is a little (too?) ugly, but I think it works
though I have not been able to test all combinations fully.
Maybee it is better to keep the patch???=20


S=C3=B8ren

--=-btm9C91E7792JpsIImWf
Content-Disposition: attachment; filename=configure.in
Content-Type: text/plain; name=configure.in; charset=UTF-8
Content-Transfer-Encoding: 7bit

AC_INIT(envy24control.c)
AM_INIT_AUTOMAKE(envy24control, 0.1.0)
AC_PROG_CC
AC_PROG_INSTALL
AC_HEADER_STDC

ALSA_REQUIRED=0.9.0

ifdef([PKG_CHECK_MODULES],
      [echo "GTK2"
       PKG_CHECK_MODULES(
         ENVY24CONTROL, 
         gtk+-2.0 alsa >= $ALSA_REQUIRED,[],
         [echo GTK1
          AM_PATH_GTK(1.0.1)
          AM_PATH_ALSA($ALSA_REQUIRED)
          CFLAGS="$CFLAGS $GTK_CFLAGS $ALSA_FLAGS"
          LDFLAGS="$LDFLAGS $GTK_LIBS $ALSA_LIBS"
          ENVY24CONTROL_CFLAGS="$CFLAGS"
          ENVY24CONTROL_LIBS="$GTK_LIBS"])],
      [echo GTK1
       AM_PATH_GTK(1.0.1)
       AM_PATH_ALSA($ALSA_REQUIRED)
       CFLAGS="$CFLAGS $GTK_CFLAGS $ALSA_FLAGS"
       LDFLAGS="$LDFLAGS $GTK_LIBS $ALSA_LIBS"
       ENVY24CONTROL_CFLAGS="$CFLAGS"
       ENVY24CONTROL_LIBS="$GTK_LIBS"]])


AC_SUBST(ENVY24CONTROL_CFLAGS)
AC_SUBST(ENVY24CONTROL_LIBS)

AC_OUTPUT(Makefile)

--=-btm9C91E7792JpsIImWf
Content-Disposition: attachment; filename=Makefile.am
Content-Type: text/x-makefile; name=Makefile.am; charset=UTF-8
Content-Transfer-Encoding: 7bit

INCLUDES=\
    @ENVY24CONTROL_CFLAGS@

bin_PROGRAMS = envy24control
man_MANS = envy24control.1
envy24control_SOURCES = envy24control.c envy24control.h levelmeters.c \
                        mixer.c patchbay.c hardware.c driverevents.c volume.c
envy24control_LDFLAGS = $(ENVY24CONTROL_LIBS)
EXTRA_DIST = cvscompile envy24control.1 depcomp

clean:
	rm -rf .deps *~

alsa-dist: distdir
	@rm -rf ../distdir/envy24control
	@mkdir -p ../distdir/envy24control
	@cp -RLpv $(distdir)/* ../distdir/envy24control
	@rm -rf $(distdir)

--=-btm9C91E7792JpsIImWf--



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
