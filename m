From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/39 v2] ASoC: simple-card-utils: add
 asoc_simple_card_parse_endpoint()
Date: Wed, 29 Jun 2016 19:34:53 +0100
Message-ID: <20160629183453.GP6247@sirena.org.uk>
References: <87fusysjam.wl%kuninori.morimoto.gx@renesas.com>
 <871t4isj0b.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iq/fWD14IMVFWBCD"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871t4isj0b.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--iq/fWD14IMVFWBCD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2016 at 09:03:00AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> simple-card needs to get its dai name and endpoint node.
> This patch makes it simple style standard

I'm finding these descriptions very clear and hard to follow, and the
lack of any changes to the simple-card code is a bit unclear.  Can I
suggest that future versions of this should have patches that move code
out of simple-card to helper functions as a single patch rather than
adding the helper in one and (I presume) the use in another?

In this case I'm not entirely clear what an endpoint is.

--iq/fWD14IMVFWBCD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdBTMAAoJECTWi3JdVIfQ7TAIAIIUqmyFB4QxGCa11Q9tOtpJ
FYSbhiU5uRiWHzDIN9WoZQlCiHDB4hZvNFhs6Zh3Ym6/riatkN7I5ZCaTtmZu9Oz
yG3aLJZD61qR7Y9MDg0OUXvnejX51qwobFAy7eACZszDcPs/UUn8Ew/Ln+vbv2E+
TBRJp3J0OpSjSm5rZlZ+IvWB8T6Yjx+UMiie2jPRsOjD0geGQ2+D9OhoxIAtOZO6
ZaoUzyynCUrX/GHUsZxU2y87VIAR72FG80rFnkLBsHlducg320L6e/sHVBNQJe/E
hvqzIirtnldYJd8D4HNmFvJ5U8EY+/nxRH5KVJ7S7ttDOlDPsXUhPgxB3VqrWOM=
=nxV0
-----END PGP SIGNATURE-----

--iq/fWD14IMVFWBCD--
