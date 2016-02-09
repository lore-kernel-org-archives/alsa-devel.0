From: Jerome Marchand <jmarchan@redhat.com>
Subject: Should snd_card_free() check for null pointer?
Date: Tue, 9 Feb 2016 15:30:16 +0100
Message-ID: <56B9F7F8.1000605@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2d1thox6ft8Nx4la13TaMOPFuoxE47BIJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2d1thox6ft8Nx4la13TaMOPFuoxE47BIJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Before commit f24640648186b (ALSA: Use standard device refcount for card
accounting), snd_card_free() would return -EINVAL on a null pointer. Now
it ends up in a null pointer dereference. There is at least one driver
that can call snd_card_free() with null argument: saa7134_alsa. It can
easily be triggered by just inserting and removing the module (no need
to have the hardware).
I don't think that is a rule, but it seems that the standard behavior of
*_free() functions is to check for null pointer. What do you think?

Thanks,
Jerome


--2d1thox6ft8Nx4la13TaMOPFuoxE47BIJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuff4AAoJEHTzHJCtsuoC3qoH/3gIVX9g7LpCYemrmxkXwrzZ
k/FnkB/ocxzh40pTqMqtGCVX3nXqh2RMpRbYRTI1K/Ss1OriOTAr1sZv9/Gqphxd
44r0LNPNAwx0fW6rT7lETxhdbNRoHadpm8tD0eW7vKCuoRc8tt2Khnu721pZTEW+
aJOHdnJWcoVeYvMUj7lOH1eJq4M8zmMEJxGp14t1YgzVds/OaNO9JrYZPD13hqzP
HxJ4VUrjlkBcJYlW3i1wNAYf+OxGbNfpf4HaXi3/scEQqG58w8YIlMwQKe9dJDuE
/zuiwEL1MZoUvkrcDchOHQV4tYDxkq+9GvX6qH3zY5ODCoFLSdPhxHGRWdPeRAU=
=TKr5
-----END PGP SIGNATURE-----

--2d1thox6ft8Nx4la13TaMOPFuoxE47BIJ--
