From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Fix kerneldoc errors
Date: Fri, 14 Nov 2014 12:57:04 +0000
Message-ID: <20141114125704.GA3815@sirena.org.uk>
References: <1415652427-827-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0551973116680402716=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CF77B2665FC
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 15:03:06 +0100 (CET)
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net
 ([94.175.94.161] helo=debutante)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1XpHSh-00024z-RS
 for alsa-devel@alsa-project.org; Fri, 14 Nov 2014 14:03:05 +0000
In-Reply-To: <1415652427-827-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0551973116680402716==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QuPiLYeIWPF/Ioti"
Content-Disposition: inline


--QuPiLYeIWPF/Ioti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2014 at 09:47:07PM +0100, Takashi Iwai wrote:
> Lots of typos and missing parameter descriptions.
>=20
> Some private struct fields are moved to the end of struct and put
> markers to make kerneldoc happy (and it make even easier for human
> readers).

This would've been better split up more.  I've applied it, a couple of
smaller things though:

>  /**
>   * snd_soc_set_ac97_ops_of_reset - Set ac97 ops with generic ac97 reset =
functions
> + * @ops: AC97 opts to set
> + * @pdev: platform to deal with

It's not a platform, it's a platform device.

>   * snd_soc_dai_set_bclk_ratio - configure BCLK to sample rate ratio.
>   * @dai: DAI
> - * @ratio Ratio of BCLK to Sample rate.
> + * @ratio: Ratio of BCLK to Sample rate.

While you're fixing fixing the capitalization of sample would've been
good.

--QuPiLYeIWPF/Ioti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZfwfAAoJECTWi3JdVIfQyHcH/25YpWQDFEmLRvOF4vJXgm1X
jiNofbv15kqR4MsSA1IbHF7XegoZjN95KHPlo/7LXO+MFzYSnWFXkmOhRfCzKAou
hcWQJ8k9ZsL2rC2HZ4HIWsDshhSGXsZQnt0EQAA0e4/5mujdQuKT9dxJnlO/NJUA
y4wjNG3sO+RLCzlOlVU+IQoOu/n25jJCbVgvOb/+MTLjpMYb5Vprf4Hg7i6ZHMzG
kgXrRC1cFOmqE53MFN//+ijpRG8zsCfRYvTeaUPwv4+BHfEIo+3pnoDpLlrq/pr7
Yq6sWCZK9Ct0QrUHY+Re9oofFfFi/5Amiw2ytY701l+kFsUx4zEj++YivyaSQUY=
=Lwic
-----END PGP SIGNATURE-----

--QuPiLYeIWPF/Ioti--

--===============0551973116680402716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0551973116680402716==--
