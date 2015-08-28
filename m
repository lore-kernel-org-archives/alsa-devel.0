From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ics43432: Fix build errors
Date: Fri, 28 Aug 2015 17:21:56 +0100
Message-ID: <20150828162156.GP12027@sirena.org.uk>
References: <alpine.DEB.2.02.1508281200060.16666@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6016983713634823107=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AC192605C1
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 18:22:23 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508281200060.16666@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6016983713634823107==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vjTL8WsyNLGAy3AI"
Content-Disposition: inline


--vjTL8WsyNLGAy3AI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2015 at 12:11:48PM +0200, Ricard Wanderlof wrote:
>=20
> Fix build errors

I'll apply this since it fixes a build issue but please as I said in
reply to your earlier off list query send one patch per issue (as
covered in SubmittingPatches) and try to provide useful changelogs
describing the issue being fixed.

> Not sure how the incorrect name or the misspelled license string got=20
> through my local build, perhaps because I've been developing this for an=
=20
> ARM system? Have now set up a tree to build for x86 as well, where the=20
> errors manifest themselves, to avoid this type of stuff happening in the=
=20
> future.

You can't be using a modern ARM system there, modern ARM systems are DT
based :(

--vjTL8WsyNLGAy3AI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV4IqgAAoJECTWi3JdVIfQRVwH/jFu5FoAwWUhbfEG7jzLClcP
R+9FaZXZrVJOiDWNMI8k2NtIjb199z8bUJsH38QrwnD0ipDhyFicyu9kkC/xuGbx
nmgfoQkaU5C3UGjbVuQ642frJFH25lULmDIpSvEf9qJQgWmgJXuOpFEjKEu3RGrj
s63tZRu7Qhc53QSlBlXUf2ZyvXhx/Uj0Rd+2LhO7BfA8YBJ8qMHGmxOprmx9FttI
znHI/3w932BbNsi7QfeuQ2CmDjR7wSkujXpVGPDpCJLcNSnUH2uwAhp6GjWv5qyJ
MZi+nWVmdnr/L1l7+/khBjJOZrxmh272uNxvKkqZKEGFAVINnCJ6MFHZwrnQ3uU=
=UsNu
-----END PGP SIGNATURE-----

--vjTL8WsyNLGAy3AI--

--===============6016983713634823107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6016983713634823107==--
