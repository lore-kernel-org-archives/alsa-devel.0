From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
Date: Tue, 20 Aug 2013 12:44:21 +0100
Message-ID: <20130820114421.GN30073@sirena.org.uk>
References: <20130805203202.GX23006@n2100.arm.linux.org.uk>
 <20130805220639.GB26637@sirena.org.uk>
 <20130805233015.GY23006@n2100.arm.linux.org.uk>
 <20130806133206.GA6427@sirena.org.uk>
 <20130810161123.GW23006@n2100.arm.linux.org.uk>
 <20130810211342.GX23006@n2100.arm.linux.org.uk>
 <1376293215.2385.32.camel@loki>
 <20130812082837.GB23006@n2100.arm.linux.org.uk>
 <1376405952.2617.101.camel@loki>
 <20130820102555.GZ23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6849562197427752905=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ABE4261A9C
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2013 13:44:32 +0200 (CEST)
In-Reply-To: <20130820102555.GZ23006@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6849562197427752905==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rUQ1rXFx4trAG42S"
Content-Disposition: inline


--rUQ1rXFx4trAG42S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2013 at 11:25:55AM +0100, Russell King - ARM Linux wrote:

> Mark is adamant that the Kirkwood-i2s with SPDIF support _will_ use DPCM
> and refuses to take patches which don't.

No, that's for simultaneous use of I2S and S/PDIF.  Using one or the
other shouldn't be a problem, that's just a single DAI and a single PCM
which has always been supported.

> So, until DPCM gets fixed, I can't proceed with getting SPDIF for kirkwood
> into mainline.

I would suggest getting the either/or support merged first.

--rUQ1rXFx4trAG42S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSE1aSAAoJELSic+t+oim9PJUQAI8oDk3JyawFHqjhQKvCsVcQ
jk7xDYg8Z0duPDv5steQtEy5MUUKYvMapPjn3xg6Y3iJS+MV2V3dKYp9A4YnLp5z
ujMEJWnJLjJ9Vs8roAMte+dsPf1UH1BsiILaBnYV/M6zZqHubxBTsv+ub2Osdsrb
10bGaioP726esoCdlUnr7IBXZ7DVYhQcJslx/yhv81Pw2rg3n2IVtZH4wQLE//+L
4CGNgUE10GTcJOnbPknq3gceFzaYabfOoMFMWHdFbCb/puyvKPguTf7Osfx3LoER
T7kcG0bxtTCc8bco/mcTXSgHCxEhuvLUBScZ47XHXx6Okm/+GFpd9Lsz7JtYpIVL
zNYVJzBrc/puLImYvVDCey4cvz7XsCTtawjMkMOUGkCPWJxVBPRrGuzGd6/e2cP8
vnCkZ/1NISaCKSY2WR0lQx69VyDeL2Rf6zVr4F9L7sgOC98Lje5d30LRhLyT8jMx
F+Vc64xPWFMfRRaXyROOCUVmEZm4Bk+UjtPb0sxYPmbtZGN0Kj5mTTcjnt6CFeEK
ZJ09aatbMaz+FHUe5TQ2upcdDNQJ6u/Xgn7Bsvazm+EnFpYJkL2rzBkG/TvNIqm/
Pf7ATZC7NzNv8UxN8yeb53EbG8qL1BJyjdFyufZLA3ceFu+KqGb0cGOyNIalV81A
21WBbapBcJn7MLgCfGbJ
=1y39
-----END PGP SIGNATURE-----

--rUQ1rXFx4trAG42S--

--===============6849562197427752905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6849562197427752905==--
