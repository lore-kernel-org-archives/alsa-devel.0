From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98090: Fix missing free_irq (part
	2)
Date: Thu, 18 Sep 2014 10:54:34 -0700
Message-ID: <20140918175434.GA7960@sirena.org.uk>
References: <1411037324-5996-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2433790605872605345=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BC9F26537D
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 19:54:49 +0200 (CEST)
In-Reply-To: <1411037324-5996-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2433790605872605345==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m65Gnd0q9NXNFThY"
Content-Disposition: inline


--m65Gnd0q9NXNFThY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2014 at 01:48:44PM +0300, Jarkko Nikula wrote:

> ---
> for-next, I don't think this is critical enough for stable.
> ---

> @@ -2413,6 +2413,7 @@ static int max98090_remove(struct snd_soc_codec *co=
dec)
>  {
>  	struct max98090_priv *max98090 =3D snd_soc_codec_get_drvdata(codec);
> =20
> +	devm_free_irq(codec->dev, max98090->irq, codec);

If this is a fix for -next shouldn't we be doing the proper fix and
moving the resource acquisition to the bus probe?

--m65Gnd0q9NXNFThY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGxxWAAoJECTWi3JdVIfQrL8H/jI6Hu2ffqM1G6j2PP57fYLw
jDgtpSeC9+ekWrkJ1m8MlrPyupjCDxN4id8v6cG9qXvm23b7uVTCfksFn2iLltJY
qB3Pvpj9t+a2aZwcKY7+ENW+6+P4SmRQDMFFzEIUrUwSRR72fUPjVfMbBV3DCkeL
ww1gwiJL0PE4L6z4JHcEgiEivNj/MS5kdYC3Ez4HnpUUA2ANLexYx9upq60zoV+k
V13huGVfdwL8/ecDugRPGUL8xG/6N+5JnjXDzuCNZF+AAF1c1swUhfBTgyN8cFzd
WD3SbNfIl2/2O1Lq41AlAbsl1mBzS5UScwbTf+PPXxvNMA0683qbVCDOebvNuWo=
=xGgH
-----END PGP SIGNATURE-----

--m65Gnd0q9NXNFThY--

--===============2433790605872605345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2433790605872605345==--
