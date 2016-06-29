From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/39 v2] ASoC: simple-card-utils: add
 asoc_simple_card_parse_dailink_name()
Date: Wed, 29 Jun 2016 19:14:41 +0100
Message-ID: <20160629181441.GI6247@sirena.org.uk>
References: <87fusysjam.wl%kuninori.morimoto.gx@renesas.com>
 <877feasj3i.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+PbGPm1eXpwOoWkI"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <877feasj3i.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--+PbGPm1eXpwOoWkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2016 at 09:01:09AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current simple-card is creating dai_link->name / dai_link->stream_name.
> These are based on CPU + Codec name.
> It can be "fe.CPU" or "be.Codec" if it was DPCM.
> This patch adds simple card common function for it.

This looks like it's about putting DPCM into the DT.  Given that DPCM is
very much an implementation detail we're trying to get rid of this seems
like it's going in the wrong direction.  What's the intended use?

--+PbGPm1eXpwOoWkI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdBAQAAoJECTWi3JdVIfQEEEH/22e1dgC5bgePMbHjyxKMOfD
JAV1yZ9phYyfdTxkaW90grxqLPF0UqoN3nvj2zLXHqhyL8vKDq8UakTcEHExoxvw
ip80SjBzTl95YrIZCRrFC+efsvsFVAZ7eJidGSJVX9qT5Q8qiSSHI9M8GS+2ari1
HzfAJdeYFwj9GeySX8ribG9HYUOpZs3y4NjNlzH15QBi0KzS7V3B3o71MErh56LU
qDMMBH11MMP8xOGjM06ERxu0G+vESBhScoY++oXwwVUr3KvNlVYem22SL0MOvj5Z
+WMTnX6Pp+hXSJ2pELv2ZfBEjE8N+N2AkgW0QUDhd2zXwf9CZFRq/+OottapItA=
=7wMO
-----END PGP SIGNATURE-----

--+PbGPm1eXpwOoWkI--
