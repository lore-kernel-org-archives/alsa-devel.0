From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: nau8825: fix issue that pop noise
 when start playback
Date: Mon, 8 Feb 2016 16:52:58 +0000
Message-ID: <20160208165258.GI7265@sirena.org.uk>
References: <1454383094-6778-1-git-send-email-KCHSU0@nuvoton.com>
 <1454661165-15275-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6015998549944967808=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 485B62605C1
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 17:53:08 +0100 (CET)
In-Reply-To: <1454661165-15275-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6015998549944967808==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fckbADODYWZD5TdN"
Content-Disposition: inline


--fckbADODYWZD5TdN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 05, 2016 at 04:32:45PM +0800, John Hsu wrote:

>  	switch (event) {
>  	case SND_SOC_DAPM_POST_PMU:
>  		/* Prevent startup click by letting charge pump to ramp up */
>  		msleep(10);
> +		regmap_update_bits(nau8825->regmap, NAU8825_REG_CHARGE_PUMP,
> +			NAU8825_JAMNODCLOW, NAU8825_JAMNODCLOW);
> +		break;
> +	case SND_SOC_DAPM_PRE_PMD:
> +		regmap_update_bits(nau8825->regmap, NAU8825_REG_CLASSG_CTRL,
> +			NAU8825_CLASSG_EN, 0);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
> +			NAU8825_HP_BOOST_DIS, 0);
>  		break;

This is really hard to follow, the enables and disables here don't match
up (I see that at least some of these are handled by other widgets on
the other path).  I at least need some words explaining what the
intended effect of the change is.

--fckbADODYWZD5TdN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuMfpAAoJECTWi3JdVIfQ1goH/3+tzeq9qfyOAy7k24f9A1xx
liJ+371x0uhrnEMx/o9RLvE3NR91ERJBiQvtwsLMGVHak+4kYtXOhiKhGj7rM+8m
fRIlQuFFqHkKh9VWBoM1CjKAMW5P5TWhzpb9pJyIBWJQ10gz3W8Wm/pxQy+HXT07
dVZXF3cnJRo9QlKpEYOrGIXocUaJZJm1wC9p5GqLgs/qBQj1J/bRu85EajL31CME
C9zoWHGZezfVJKzn2ElcM6poHVetsbFXcG5EM69Ass/nglXnntJ563BAInwtZPjc
WqMa1JhZGIrFg5CpHMDsRe/45JtRrWHagjvQxEBmfpn7xuOKpR3yJEHZMEkm6O4=
=Qlaj
-----END PGP SIGNATURE-----

--fckbADODYWZD5TdN--

--===============6015998549944967808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6015998549944967808==--
