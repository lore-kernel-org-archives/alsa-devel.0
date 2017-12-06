From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/9] ASoC: sun8i-codec: Add support for A64
	SoC
Date: Wed, 6 Dec 2017 19:13:11 +0000
Message-ID: <20171206191311.7wlvqiolpho4zvxh@sirena.org.uk>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-5-anarsoul@gmail.com>
 <20171205080444.zo2rlusqpjyraqcw@flea.lan>
 <CA+E=qVdZME2fiMw09NUP4DNCYhk58dqSapCdfBjLrdMq5HFwyg@mail.gmail.com>
 <20171206153205.k3l5sofdco3t75mi@flea.lan>
 <20171206154810.eb2czpb4kusxv5kj@sirena.org.uk>
 <20171206185308.ijt76lodwgkz2pm3@flea.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4795521844822157810=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B67CC267048
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 20:13:13 +0100 (CET)
In-Reply-To: <20171206185308.ijt76lodwgkz2pm3@flea.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, arm-linux <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============4795521844822157810==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="he6j2mbdve2xu6gt"
Content-Disposition: inline


--he6j2mbdve2xu6gt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 07:53:08PM +0100, Maxime Ripard wrote:
> On Wed, Dec 06, 2017 at 03:48:10PM +0000, Mark Brown wrote:

> > BCLK can be higher than the minimum there in most formats, though some
> > hardware is more restrictive so we tend to go for the minimum clock rate.

> How does that work in such a case? Is LRCK faster as well, and we're
> keeping the same ratio, or will the codec buffer the current sample
> until the next word?

No, the extra clock cycles just get ignored - most of the formats define
the location of the data in terms of LRCLK edges, any extra BCLK edges
shouldn't do anything.

> Is it usually a property of the codec or the DAI?

Things that require extra cycles for some reason tend to be CODECs, but
this can also be done just because whatever the clock master is doesn't
have very flexible dividers.

--he6j2mbdve2xu6gt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlooQUYACgkQJNaLcl1U
h9Bbcgf/eqlSpFBu9TcdcX2g08L6iERguwurgGVPJfkT2iI+FhcbwHZqXx/EXitp
/sm36esx1OzWTZcrUI+nNZP4ARr+nVhyOVLxrnbN4KeN8SAWnH4+z6OVfeVLU9K5
UVxuUs+dkAu9Ss4sYm0M7D37M8fqEFH2tbbkrJTacCXwdFJw3z4ky3CAJjZVOszv
PMzEaznU9zaX/IKNE5GtntI1NrkIZRWw7xy6gGRAhGVhW1/DWg/SLwRvXMilqU3r
jyHQCqHeJymmjaomXSh4c07XzP+ZVDv2tv3AKLq08kwRGF5rya286hWJxZQTvt32
Hjkx2kHTnVrutFOTClBaqlTX58NGFw==
=QQDZ
-----END PGP SIGNATURE-----

--he6j2mbdve2xu6gt--

--===============4795521844822157810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4795521844822157810==--
