From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: How to build alsa-utils from git?
Date: Mon, 09 Jan 2017 00:14:44 +0100
Message-ID: <1483917284.2743.14.camel@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9208448712509237965=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E98C2664FB
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 00:14:52 +0100 (CET)
Received: from ipservice-092-214-167-048.092.214.pools.vodafone-ip.de
 ([92.214.167.48] helo=mattotaupa)
 by mail.gw90.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.84_2) (envelope-from <paulepanter@users.sourceforge.net>)
 id 1cQMfr-0006yg-HJ
 for alsa-devel@alsa-project.org; Sun, 08 Jan 2017 23:14:51 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============9208448712509237965==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-tzfL8Fd1j9D7OmU71vBg"


--=-tzfL8Fd1j9D7OmU71vBg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear ALSA folks,


Could you please help me building alsa-utils from git.

```
$ git describe --tag origin/master
v1.1.3-2-ge9a6d42
$ aclocal --version
aclocal (GNU automake) 1.15
Copyright (C) 2014 Free Software Foundation, Inc.
License GPLv2+: GNU GPL version 2 or later <http://gnu.org/licenses/gpl-2.0=
.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Tom Tromey <tromey@redhat.com>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0and Alexandre Duret-Lutz <adl@gnu=
.org>.
$ aclocal
$ gettextize=20
Copying file ABOUT-NLS
Copying file config.rpath
Not copying intl/ directory.
Copying file po/Makefile.in.in
Copying file po/boldquot.sed
Copying file po/en@boldquot.header
Copying file po/en@quot.header
Copying file po/insert-header.sin
Copying file po/Makevars.template
Copying file po/quot.sed
Copying file po/remove-potcdate.sin
Copying file po/Rules-quot
Creating po/ChangeLog
Copying file m4/gettext.m4
Copying file m4/iconv.m4
Copying file m4/lib-ld.m4
Copying file m4/lib-link.m4
Copying file m4/lib-prefix.m4
Copying file m4/nls.m4
Copying file m4/po.m4
Copying file m4/progtest.m4
Updating EXTRA_DIST in m4/Makefile.am (backup is in m4/Makefile.am~)
Updating Makefile.am (backup is in Makefile.am~)
Updating configure.ac (backup is in configure.ac~)
Adding an entry to ChangeLog (backup is in ChangeLog~)

Please run 'aclocal -I m4' to regenerate the aclocal.m4 file.
You need aclocal from GNU automake 1.9 (or newer) to do this.
Then run 'autoconf' to regenerate the configure file.

You will also need config.guess and config.sub, which you can get from the =
CVS
of the 'config' project at http://savannah.gnu.org/. The commands to fetch =
them
are
$ wget 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/co=
nfig.guess'
$ wget 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/co=
nfig.sub'

You might also want to copy the convenience header file gettext.h
from the /usr/share/gettext directory into your package.
It is a wrapper around <libintl.h> that implements the configure --disable-=
nls
option.

Press Return to acknowledge the previous three paragraphs.
$ gettextize --version
/usr/bin/gettextize (GNU gettext-tools) 0.19.8.1
Copyright (C) 1995-1998, 2000-2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Written by Ulrich Drepper
$ autoheader=20
configure.ac:418: error: `po/Makefile.in' is already registered with AC_CON=
FIG_FILES.
../../lib/autoconf/status.m4:288: AC_CONFIG_FILES is expanded from...
configure.ac:418: the top level
autom4te: /usr/bin/m4 failed with exit status: 1
autoheader: '/usr/bin/autom4te' failed with exit status: 1
```

Could you please share the correct commands?


Thanks,

Paul
--=-tzfL8Fd1j9D7OmU71vBg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQ8+w9d414FAVARIpk9fVorbA4dWAUCWHLH5AAKCRA9fVorbA4d
WJRdAJ0RQ0WaVHKFVWP1Eru7bmp3G717nACfY4nFBeST9gs2EGBQKlGHaYJkg5o=
=hsOa
-----END PGP SIGNATURE-----

--=-tzfL8Fd1j9D7OmU71vBg--


--===============9208448712509237965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9208448712509237965==--
