From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs-ac97: Remove rate constraints
Date: Tue, 12 May 2015 19:01:04 +0100
Message-ID: <20150512180104.GM3066@sirena.org.uk>
References: <554E85B5.30107@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1hVIwB4NpNcOOTEe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <554E85B5.30107@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--1hVIwB4NpNcOOTEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2015 at 12:09:57AM +0200, Maciej S. Szmigiero wrote:
> Remove rate constraints from generic ASoC AC'97 CODEC.
>    =20
> Supported rates should be detected and constrained anyway by
> AC'97 generic code - was tested with VT1613 CODEC and iMX6 SSI
> controller.

Applied, thanks.

--1hVIwB4NpNcOOTEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUj/fAAoJECTWi3JdVIfQ1fYH+QFswWijafq0DTfIh0jdWtht
V7ppujp/ZBPiY1KCvdm8CLbFrBFnrE3ag7P/fJnpNYB6wlDbRC2cHYh0NIY4TokC
mO+jT1k9jGq41RYRMXl1bz4FQfFVDXkbI9CgUh0AKMim5JIkEYodZaJUsg77dYs8
l4VV76FMz7WwtuqUpJsBOSHULZl8BOo7mJd91lOfD6hvYEeaRs8wQW2UrVShlSYf
kFiP23+bvJsDGM0aWYNCIKrYHRxLdKbPq4RIMNQltOF4TvLhDbvpfZHW6j9HyEDW
SBkTJYCIaetTTng5vnf0nZzFt8d+/GkKqpnXzSE1RDcEeEfYrq2pAPJz+OfIZM4=
=g6xf
-----END PGP SIGNATURE-----

--1hVIwB4NpNcOOTEe--
