From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFT] ASoC: ak4642: Fix up max_register
	setting
Date: Tue, 30 Jun 2015 16:18:18 +0100
Message-ID: <20150630151818.GQ11162@sirena.org.uk>
References: <1435459611.15772.2.camel@ingics.com>
 <20150630104608.GP11162@sirena.org.uk>
 <CAFRkauCPAq9xmpJSpbhTZy2_s=2ipSW5Mwixj3ptJTpB+Vqv1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1424701625812172471=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 19272260476
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 17:18:32 +0200 (CEST)
In-Reply-To: <CAFRkauCPAq9xmpJSpbhTZy2_s=2ipSW5Mwixj3ptJTpB+Vqv1w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============1424701625812172471==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oN4OvwWIcd1E23D1"
Content-Disposition: inline


--oN4OvwWIcd1E23D1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2015 at 07:25:57PM +0800, Axel Lin wrote:
> 2015-06-30 18:46 GMT+08:00 Mark Brown <broonie@kernel.org>:

> >>  static const struct regmap_config ak4642_regmap = {
> >>       .reg_bits               = 8,
> >>       .val_bits               = 8,
> >> -     .max_register           = ARRAY_SIZE(ak4642_reg) + 1,
> >> +     .max_register           = FIL1_3,
> >>       .reg_defaults           = ak4642_reg,
> >> -     .num_reg_defaults       = ARRAY_SIZE(ak4642_reg),
> >> +     .num_reg_defaults       = FIL1_3 + 1,

> > This change is incorrect, the number of register defaults must match the
> > size of the array of register defaults being passed in.  Why are you
> > changing this?

> Because I reuse the same reg_default for ak4642 and ak4643.
> According to the datasheet:
> For ak4642, the valid registers are 0x0 ~ 0x1f (FIL1_3)
> For ak4643, the valid registers are 0x0 ~ 0x24 (SPK_MS)
> The default registers for 0x0 ~ 0x1f are the same for ak4642 and ak4643.

Ah, I see.  That definitely deserves a comment since it's very unusual -
possibly also with a BUILD_BUG_ON() for the define being less than
ARRAY_SIZE().

> Or do you prefer having separate reg_default for ak4642 and ak4643?
> (Then it can use ARRAY_SIZE() here.)

No, what you're doing is OK but really ought to have comments so it's
clearer.

--oN4OvwWIcd1E23D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVkrM6AAoJECTWi3JdVIfQ2i8H/2pzGmj8K1ZLrybCNqoATjmQ
32rmW98EA2VAx15IH/mtxKJPhdO0jaECL4J6tFsk3G/WWk4UvpmBmrwWvNtiQQQi
oBqEIQld/yB96ej99nOKDui6kRubfVuZEynv6Cgl9V41QBbIfw7czIEvhpsegHGH
MMxNQHhTBEKvahlajfHz1NWM74/DP6SKzQBvjnbYrU7PhiCcpXPR9lFH0+Xj1YZm
idlKNm1Dxc/m1xLd5itK9KphTTpvkceVyZZ5TfCEBcPujONi3InXq9AIvoWG/wsb
GtBSnqkwVBwEx0jRNMGgztZd4rFOf0nRr8f+aYEmgFdI5clfwhegvsw0MUcJI+o=
=BS7O
-----END PGP SIGNATURE-----

--oN4OvwWIcd1E23D1--

--===============1424701625812172471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1424701625812172471==--
