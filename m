From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Fri, 13 Dec 2013 13:04:43 +0000
Message-ID: <20131213130443.GY11044@sirena.org.uk>
References: <1386939499-5163-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3809539855096081398=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DAC1D261589
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 14:04:46 +0100 (CET)
In-Reply-To: <1386939499-5163-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3809539855096081398==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qn4G1eBrv+t66M9q"
Content-Disposition: inline


--Qn4G1eBrv+t66M9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2013 at 02:58:19PM +0200, Peter Ujfalusi wrote:

> -	case SNDRV_PCM_FORMAT_S24_LE:
> +	case SNDRV_PCM_FORMAT_S24_3LE:
>  		data |= (0x02 << 4);
>  		break;

This should be adding the case for the new format rather than replacing
the old one shouldn't it?  They ought to turn out the same on the AIF so
the CODECs shouldn't care about the difference, ideally the core would
hide the difference from them.

--Qn4G1eBrv+t66M9q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqwXoAAoJELSic+t+oim9SxMP/3RJzQqFpN9/MYMOkyTBmzDU
TP68D1I/wSefjFBepFuIc1v1tqVliYiMskiGnpUOKPQAktrFjHKxPspLIw42oWXl
4+DOp/cIPVGXuTJHIg0Q8sBYSFwZxELH/mVDrk6oECg+jwHs2djgbBG8iQrELfk8
ooB54e+BxoENw1imsva1NksBTj/F+lPgQU4+e+dRl8O7qBpCxwTJRLumDcjteq9a
KeJJCo2QozF2yyaUDlTiG/IEzddVSW9apCT/HZG84pxFwgDMBPQgCcFXh2whscNI
Vd75K/ZX7/5VCVV0PiceJIcBDohDQiWoMoURuvoK0DEy2/bbrd18gxmQ0vlDOj6x
9M3Hx4ukGUCHU/F6uQ1KkuZSpcyWn67DyCCi87JMdwgkGZ0SZKPUUAJMaOJzwCFA
VjcBtlwII6StXz70fl3qK4GmOM4Aqo88kU1BD7+0B8nRdMZosviCnZ/sh29lNIzk
U1YRuVATLEA0XxIgyWYBcU2NQYlo4XlpU5HaDm0E/gv9NeR836txRtm802K0uYb/
rs+Lcdi8fXeO1Njly6FGlwTMMrjNAA2Rpl8yVqIQLPQQ+Nd9/YmBQ5r7xf7UYT6x
a3LuzBYEOGfpDVUw0Wm/81ILMbtpPBsIOXQ16KNkUd9O/P6YDtwAzFZDPuYaHACR
dtO2BqlK9JsMuyA+A+3P
=z37l
-----END PGP SIGNATURE-----

--Qn4G1eBrv+t66M9q--

--===============3809539855096081398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3809539855096081398==--
