From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: enable speaker protection
	features
Date: Fri, 23 Jun 2017 12:33:24 +0100
Message-ID: <20170623113324.cdtfp57gaatrpojc@sirena.org.uk>
References: <1498184697-2156-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5014896960894676089=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ADEFA266AE9
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 13:33:35 +0200 (CEST)
In-Reply-To: <1498184697-2156-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com, alexlee@realtek.com, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5014896960894676089==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vo3i7wnx7jzvjib2"
Content-Disposition: inline


--vo3i7wnx7jzvjib2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 23, 2017 at 10:24:57AM +0800, Bard Liao wrote:

> This patch is uploaded for enabling the speaker protection features
> of the audio codec.

No control of these?

> @@ -171,7 +172,7 @@ static const struct reg_default rt5645_reg[] = {
>  	{ 0x9c, 0x0aea },
>  	{ 0x9d, 0x000c },
>  	{ 0x9e, 0x0400 },
> -	{ 0xa0, 0xa0a8 },
> +	{ 0xa0, 0xa0e8 },
>  	{ 0xa1, 0x0059 },
>  	{ 0xa2, 0x0001 },
>  	{ 0xae, 0x6000 },

You shouldn't be changing the register defaults away from the physical
defaults, just do it with a normal register write.  Changing the
defaults will break cache resyncing.

--vo3i7wnx7jzvjib2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllM/IQACgkQJNaLcl1U
h9CUdQgAhwSTtAiPalSbtiKrmMfDcjoMBSznVjLWWskwhZcVgCcrcsl0sRsNt17V
/VWcYhwOS6yw4jgbTRYOJScpnLWPIc9dOnL/oG5cxRZ4wxBVMX0NekQmklnJSWtt
QW7hlo0sjMLMrjaoYf0hJO0KLzew3BmfZuYB9D3FIOoIjc+iGifADDJaFrmciqpR
oT/eIuH3uTPM7Fv3UudBbUOfZ6OpZTfwy+xYIvJ/yIFfbd52Gv9MmpBtoLFROJhV
H5vACcUFKjVeHN7E+EYFI5DKH2kzxh0Hpr2K6PL03KogbIAzy9X9rGNUqeXFCFnk
7nZgz0sPTj1r0ix/SK7Uvxca2SwCNA==
=2SXJ
-----END PGP SIGNATURE-----

--vo3i7wnx7jzvjib2--

--===============5014896960894676089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5014896960894676089==--
