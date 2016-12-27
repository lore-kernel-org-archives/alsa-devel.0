From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] alsactl: Remove standard output definition in
	systemd unit
Date: Tue, 27 Dec 2016 23:47:32 +0100
Message-ID: <1482878852.3735.21.camel@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3038754216491345693=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
 by alsa0.perex.cz (Postfix) with ESMTP id B91A3266B22
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2016 23:47:41 +0100 (CET)
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
Cc: Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org


--===============3038754216491345693==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-r7SXZtAN3IdIZdsdAy5/"


--=-r7SXZtAN3IdIZdsdAy5/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Date: Tue, 8 Jul 2014 07:23:06 +0000

`/lib/systemd/system/alsa-restore.service` specifies
`StandardOutput=3Dsyslog`. This overrides the `DefaultStandardOutput`
setting from `/etc/systemd/system.conf`, which the system administrator
can use to specify how output gets logged. In particular, the sysadmin
may want output to go to the journal, or to syslog, or nowhere at all [1].

This patch removes the definition entirely, so the units can use the
system default.

Upstream the patch from the Debian package [2].

[1] https://bugs.debian.org/741123
=C2=A0   "systemd services should not use StandardOutput=3Dsyslog; should r=
ely
     on DefaultStandardOutput"
[2] https://sources.debian.net/src/alsa-utils/1.1.2-1/debian/patches/system=
d_standardoutput.patch/

Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
CC: Jordi Mallach <jordi@debian.org>
---
 alsactl/alsa-restore.service.in | 1 -
 1 file changed, 1 deletion(-)

diff --git a/alsactl/alsa-restore.service.in b/alsactl/alsa-restore.service=
.in
index f3cd86b..c092c2f 100644
--- a/alsactl/alsa-restore.service.in
+++ b/alsactl/alsa-restore.service.in
@@ -15,4 +15,3 @@ Type=3Doneshot
 RemainAfterExit=3Dtrue
 ExecStart=3D-@sbindir@/alsactl restore
 ExecStop=3D-@sbindir@/alsactl store
-StandardOutput=3Dsyslog
--=20
2.11.0
--=-r7SXZtAN3IdIZdsdAy5/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQ8+w9d414FAVARIpk9fVorbA4dWAUCWGLvhQAKCRA9fVorbA4d
WK9XAJ9lBPeuRAgOHvuqPveDBhQoDnTdcwCfbWC5GlTP1ORee5jXXD722w9+i6M=
=P/jh
-----END PGP SIGNATURE-----

--=-r7SXZtAN3IdIZdsdAy5/--


--===============3038754216491345693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3038754216491345693==--
