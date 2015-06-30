From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFT] ASoC: ak4642: Fix up max_register
	setting
Date: Tue, 30 Jun 2015 11:46:08 +0100
Message-ID: <20150630104608.GP11162@sirena.org.uk>
References: <1435459611.15772.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9091831357120793767=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A730B2602AD
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 12:46:19 +0200 (CEST)
In-Reply-To: <1435459611.15772.2.camel@ingics.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============9091831357120793767==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NDuspjMMC1Ui5ypn"
Content-Disposition: inline


--NDuspjMMC1Ui5ypn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 28, 2015 at 10:46:51AM +0800, Axel Lin wrote:

>  static const struct regmap_config ak4642_regmap = {
>  	.reg_bits		= 8,
>  	.val_bits		= 8,
> -	.max_register		= ARRAY_SIZE(ak4642_reg) + 1,
> +	.max_register		= FIL1_3,
>  	.reg_defaults		= ak4642_reg,
> -	.num_reg_defaults	= ARRAY_SIZE(ak4642_reg),
> +	.num_reg_defaults	= FIL1_3 + 1,

This change is incorrect, the number of register defaults must match the
size of the array of register defaults being passed in.  Why are you
changing this?

--NDuspjMMC1Ui5ypn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVknNwAAoJECTWi3JdVIfQwz4H+gPmlXBPpHDbIsB0QLRFCsWH
yOgs/2H00qU0FverPtk/3KUx2X0ZTUpY3u48iFl3uN+JRT7bpPNq4pu9wLC1uZpd
5pTq1jDmxyyVsc0vyowdZ7xnxZnDtdEZjW8LyBb6KxX0blWArRaCgD4Mu2/mAvfT
lJ0b3+/7n0dAgKfZtpK46eY5X1Tay2m+NsV7WLtN+ogHGd7IQfE5DiZnII+5i9hq
DiYcZSYufJ2pyfeMhb/C46ml+dNxzJI7ybtXGgWB2eFR2osNp/mdpEYXSRVmECuM
edDwveGFn18qO/UQR5wFXeGB8DTGPoOkPcOoMxAkGI0wHP9UwDwy2jNXK6G03qM=
=SMNi
-----END PGP SIGNATURE-----

--NDuspjMMC1Ui5ypn--

--===============9091831357120793767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9091831357120793767==--
