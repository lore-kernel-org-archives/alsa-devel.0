From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] alsactl: Check existence of `alsactl` in udev
	rule
Date: Wed, 28 Dec 2016 23:31:15 +0100
Message-ID: <1482964275.11185.34.camel@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4573355570416263805=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F8B1266DDD
 for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2016 23:31:23 +0100 (CET)
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


--===============4573355570416263805==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-i3E9qEXpamHO7wQcWR3w"


--=-i3E9qEXpamHO7wQcWR3w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Jordi Mallach <jordi@debian.org>
Date: Thu, 10 Jan 2013 00:17:58 +0000

Include the line `TEST=3D=3D"/usr/sbin/alsactl"` in the udev rule, to
properly fix the state restoring for users with split `/usr`
filesystems
[1].

Upstream the patch from the Debian package [2].

[1] https://bugs.debian.org/670490
=C2=A0=C2=A0=C2=A0=C2=A0"Debian Bug report logs - #670490 alsa-utils: Resto=
re sound volume
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0in udev"
[2] https://sources.debian.net/src/alsa-utils/1.1.2-1/debian/patches/udev_t=
est_alsactl.patch/

Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
CC: Jordi Mallach <jordi@debian.org>
---
Please apply with `git am saved-messages.mbox`.

=C2=A0alsactl/90-alsa-restore.rules.in | 4 ++--
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/alsactl/90-alsa-restore.rules.in b/alsactl/90-alsa-restore.rul=
es.in
index c0c1b23..f190b85 100644
--- a/alsactl/90-alsa-restore.rules.in
+++ b/alsactl/90-alsa-restore.rules.in
@@ -2,7 +2,7 @@ ACTION=3D=3D"add", SUBSYSTEM=3D=3D"sound", KERNEL=3D=3D"con=
trolC*", KERNELS!=3D"card*", TEST=3D=3D
=C2=A0GOTO=3D"alsa_restore_end"
=C2=A0
=C2=A0LABEL=3D"alsa_restore_go"
-TEST!=3D"@daemonswitch@", RUN+=3D"@sbindir@/alsactl restore $attr{device/n=
umber}"
-TEST=3D=3D"@daemonswitch@", RUN+=3D"@sbindir@/alsactl nrestore $attr{devic=
e/number}"
+TEST!=3D"@daemonswitch@", TEST=3D=3D"@sbindir@/alsactl", RUN+=3D"@sbindir@=
/alsactl restore $attr{device/number}"
+TEST=3D=3D"@daemonswitch@", TEST=3D=3D"@sbindir@/alsactl", RUN+=3D"@sbindi=
r@/alsactl nrestore $attr{device/number}"
=C2=A0
=C2=A0LABEL=3D"alsa_restore_end"
--=C2=A0
2.11.0
--=-i3E9qEXpamHO7wQcWR3w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQ8+w9d414FAVARIpk9fVorbA4dWAUCWGQ9MwAKCRA9fVorbA4d
WJchAJwIrKRybIGV8u+A+2jnndJIo5Y7YQCePx6zPR+sc+rI7s42+MIzew5LSSY=
=xp6x
-----END PGP SIGNATURE-----

--=-i3E9qEXpamHO7wQcWR3w--


--===============4573355570416263805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4573355570416263805==--
