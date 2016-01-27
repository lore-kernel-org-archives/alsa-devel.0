From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98926 codec driver
Date: Wed, 27 Jan 2016 20:24:15 +0000
Message-ID: <20160127202415.GD25316@sirena.org.uk>
References: <1452809013-8825-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1557045694893255335=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DB832604AF
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 21:24:22 +0100 (CET)
In-Reply-To: <1452809013-8825-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1557045694893255335==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 14, 2016 at 02:03:33PM -0800, anish kumar wrote:

> +static const struct snd_kcontrol_new max98926_dai_controls[] = {
> +	SOC_DAPM_SINGLE("Left", MAX98926_GAIN,
> +		MAX98926_DAC_IN_SEL_SHIFT, 0, 0),
> +	SOC_DAPM_SINGLE("Right", MAX98926_GAIN,
> +		MAX98926_DAC_IN_SEL_SHIFT, 1, 0),
> +	SOC_DAPM_SINGLE("LeftRight", MAX98926_GAIN,
> +		MAX98926_DAC_IN_SEL_SHIFT, 2, 0),

These are on/off switches too and so should end in Switch like all the
other on/off controls.  Other than this the driver looks good so I've
applied it, please send a followup patch correcting this.

> +	SOC_DAPM_SINGLE("(Left+Right)/2 Switch", MAX98926_GAIN,
> +		MAX98926_DAC_IN_SEL_SHIFT, 3, 0),
> +};

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqSdvAAoJECTWi3JdVIfQqoAH/0fb+3Z1iMW4uDZgae750oq1
ADePotRy2lYtK/pqbLOqITDY4RVsW2y2Q5HuV15lgPDZ3MBK2fBJTSWVFXcMRtgR
zB19DDhl/+Z5BCo3Gueezhnmsg0u0DGhFbkG3uFrCOI+QGJSqDA/g/xshoCN+L1b
dIynEhU9LSEwyg/t14F9iyi5BslmgVkFfYr0sd2aHpJg9QnLVuTLbOmAUeYf2OP8
6zaSsGDYLivif5zDDkrMlr3kWV4BrowYeB6x9htJb4FnVien8cl+6WXqQC99qSQG
R7Rdz4hTRibAdMrQI44I8FZikAAk+1vmlnWVQfKmBa2X2VfviXxPwXOLkL62Tp0=
=uG2Z
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--

--===============1557045694893255335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1557045694893255335==--
