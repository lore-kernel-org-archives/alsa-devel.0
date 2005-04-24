From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] snd-ac97-codec: fix ac97_enum mixer elements
Date: Sun, 24 Apr 2005 15:21:47 +0400
Message-ID: <20050424112147.GA14587@procyon.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ac97_enum mixer elements (e.g., "Capture Source") did not work because
of wrong bitmask calculation in snd_ac97_get_enum_double() and
snd_ac97_put_enum_double().

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1072

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

--- alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c.fix-enum	2005-04-09 16:57=
:02 +0400
+++ alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c	2005-04-24 15:01:44 +0400
@@ -465,7 +465,7 @@ int snd_ac97_get_enum_double(snd_kcontro
 	struct ac97_enum *e =3D (struct ac97_enum *)kcontrol->private_value;
 	unsigned short val, bitmask;
 =09
-	for (bitmask =3D 1; bitmask > e->mask; bitmask <<=3D 1)
+	for (bitmask =3D 1; bitmask < e->mask; bitmask <<=3D 1)
 		;
 	val =3D snd_ac97_read_cache(ac97, e->reg);
 	ucontrol->value.enumerated.item[0] =3D (val >> e->shift_l) & (bitmask - 1=
);
@@ -482,7 +482,7 @@ int snd_ac97_put_enum_double(snd_kcontro
 	unsigned short val;
 	unsigned short mask, bitmask;
 =09
-	for (bitmask =3D 1; bitmask > e->mask; bitmask <<=3D 1)
+	for (bitmask =3D 1; bitmask < e->mask; bitmask <<=3D 1)
 		;
 	if (ucontrol->value.enumerated.item[0] > e->mask - 1)
 		return -EINVAL;

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCa4FLW82GfkQfsqIRArDkAJ9l7TqDcI11Z2sDFYAKiLqKOMipTACgjigY
CbuXDZ4MVkDSg/jxy1ES584=
=irgi
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
