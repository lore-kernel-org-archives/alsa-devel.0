From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: kirkwood: add S/PDIF support
Date: Thu, 24 Oct 2013 12:08:33 +0100
Message-ID: <20131024110833.GC18506@sirena.org.uk>
References: <20131021122422.4cde72c0@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7009832637610343323=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C76F260863
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 13:08:45 +0200 (CEST)
In-Reply-To: <20131021122422.4cde72c0@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7009832637610343323==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2013 at 12:24:22PM +0200, Jean-Francois Moine wrote:

> +static struct snd_soc_dai_driver kirkwood_i2s_dai[3] =3D {
> +	DAI_DEF("i2s", 0,
> +		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
> +					SNDRV_PCM_RATE_96000),
> +	DAI_DEF("spdif", 1,
> +		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
> +					SNDRV_PCM_RATE_96000),
> +	DAI_DEF("i2s/spdif", 2,
> +		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
> +					SNDRV_PCM_RATE_96000),

I didn't take this version because this third DAI reintroduces the
problem with having both S/PDIF and I2S in the single DAI.  The problem
there is that you end up with one traditional DAI linked to two
different CODECs which the framework doesn't understand - it's
introducing a DAI which does what v1 does. =20

This is what DPCM addresses for this platform, it allows the single DMA
controller to be used in conjunction with the two external DAIs by
splitting the DMA from the DAI in the model the subsystem has.
Hopefully someone will have the time and enthusiasm to update to use
this and support systems that want to use I2S and S/PDIF simultaneously.

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaP+uAAoJELSic+t+oim9Eq0P/0peOc1faY2Mz75bBkyxEfcJ
0ouq0Xu8N3gQ0p+8lTKdMZeMSeodx4MckEccGHXSpqdfmvdySTeZwb8mJ/cFfqxV
7RhpDpeT29Hs/tF1rGypbCIMY0smlkiYxUF3rO59Ryekdzoxz02TV6VWJAa1u370
ZEGq76iSMPcBd2if4FT7gfFjExk3UJrBEIbWkmvKhzouYi2guD1CgbYv9UXimLvb
5yPQ0BLsLWcWyo0YgEVk8N6WfKWKAT55pd/m9SUL5X1R51qP2Jo8M0Bntfv4sMFK
WedsDN86llP6zNy+zRLs3nk49ylzP1PZRkJtQoVeYdnDSrWQc4U+lO6gRJdUpBp6
8yKRq9U4JFzbK/zLh6JDzPbVFN04opnPWn0vc3Fmq5anP8MoFthGF3MzCodhb7di
Qn/1qW5p1Rzx91wavCKRAtvUAVQy65Rehnt5I4u8eygk7j7zNdjHbsVDZry+bifn
k0WkKHMEmDtK2OtO/xwvGcOjrcKCnBoq9gqUvqpEA4P1wi9PmXTYoM9k9Jmd/F9I
KIVYf9ue5wecBBNEjaLUjlEeZ4d3bLf8G79q4j+e28naYX3G/DUesMT7GNEvSAoG
caxCnBuaV7RJxPHCwkvzdDEeOfT+g2dAJesLDeLTyFMJ7h/43o2G5p88bT1IUJRX
92ZCwow4GxnPuOcmfAXN
=93dN
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--

--===============7009832637610343323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7009832637610343323==--
