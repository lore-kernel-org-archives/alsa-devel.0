From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/7] Documentation: DT: add
 sam9x5ek-wm8731 machine driver
Date: Tue, 9 Jul 2013 16:01:14 +0100
Message-ID: <20130709150114.GB27646@sirena.org.uk>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-3-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4737540082513189457=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B1C69261AD3
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2013 17:01:19 +0200 (CEST)
In-Reply-To: <1373379933-32749-3-git-send-email-richard.genoud@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4737540082513189457==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QJuET63n7pc71H9h"
Content-Disposition: inline


--QJuET63n7pc71H9h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2013 at 04:25:28PM +0200, Richard Genoud wrote:
> This add the sound DT binding for sam9x5ek-wm8731 machine driver
>=20
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  .../bindings/sound/atmel-sam9x5-wm8731-audio.txt   |   30 ++++++++++++++=
++++++

Put new binding documents in the same patch that reads them, this makes
review easier.

> +  - atmel,audio-routing: A list of the connections between audio compone=
nts.

This needs to be more specific and list the available board specific
nodes for routing.  For the CODEC you can just refer to the CODEC
binding documentation.

> +  - atmel,format: DAI format. Must be "i2s"

So why not just omit this then?

> +  - atmel,bitclock-master:  DAI clock master
> +  - atmel,frame-master: DAI frame master

The driver isn't handling these and there's no information on how to set
them.

--QJuET63n7pc71H9h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR3CW3AAoJELSic+t+oim9bvYQAJKbx31zOCcsWkLj7B2zfUcr
wSLDT72PI9D56Owhv5o0CbVSBnuSClYBukzNlSmxPJE9Iet7aO8P4Ak/WHgHRCHz
TJNOinibdrnZwAZe1BAo734fCpxSoGjsVR3cELLcHl4PVDeV735bIFmImjwnrYJS
/l0q6x7PCxA75RXxQ0pOfLIYUaE2lNue3ZEDkEJ6OSdAYHqd6mgkpFzNRGPRYi1e
lNMxopRiPc3Na1J1SFDI8jWulHW8WYamxJ5b1UF8gxyezu7ju1TTRmYQigqrbJkr
OXiKlnxQLje7xt9ROLk8XjZbi734/rBULQxf+nVJn4vT/o36m427lzxS2cQJV79p
8gEMjCXg06YlPpC509Tyiyl075ut8sWLV4Ah0B+f3NKoNDs5oHt8fwn08+jeFV2u
yPH4WnXrNFWusTXLQV64DvHw8PvtHtpHeQc2v57ZbL4nROI8FAG7dEYaQl7vTYR4
8KoPqjStzbXLnXX0EgMwkoVl9AgXdmA4iTdKab75VBXYBctSiv4SwM3cBVWrsHK2
UurieZfgPe43Pgepf6KWjTFsWpWxDNjHGrzuPBjxfndiZiQzvvqYYVVBgl02a+jo
98t+Q7o9+D3VL176JgryqLk10zcrOxlRp0hpSbHy4pfw1D4vRD3K+KwEOxjigvv5
nKWmEuwVOMIqSg+ds5Ec
=pD+0
-----END PGP SIGNATURE-----

--QJuET63n7pc71H9h--

--===============4737540082513189457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4737540082513189457==--
