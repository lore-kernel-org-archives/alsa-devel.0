From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Tue, 16 Aug 2016 11:38:54 +0100
Message-ID: <20160816103854.GP9347@sirena.org.uk>
References: <1471251743-32084-1-git-send-email-KCHSU0@nuvoton.com>
 <20160815140604.GK9347@sirena.org.uk>
 <57B28F1D.8070409@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2498066916424986260=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 14F59265A98
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2016 12:39:05 +0200 (CEST)
In-Reply-To: <57B28F1D.8070409@nuvoton.com>
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
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2498066916424986260==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h/VGaWN5ITqlMCVM"
Content-Disposition: inline


--h/VGaWN5ITqlMCVM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 16, 2016 at 11:57:17AM +0800, John Hsu wrote:
> On 8/15/2016 10:06 PM, Mark Brown wrote:
> > On Mon, Aug 15, 2016 at 05:02:23PM +0800, John Hsu wrote:

> > This looks very good overall, a few fairly small things but nothing too
> > major.

> > > +	val = (u16 *)ucontrol->value.bytes.data;
> > > +	reg = NAU8810_REG_EQ1;
> > > +	for (i = 0; i < params->max / sizeof(u16); i++) {
> > > +		regmap_read(nau8810->regmap, reg + i, &reg_val);
> > > +		reg_val = cpu_to_be16(reg_val);
> > > +		memcpy(val + i, &reg_val, sizeof(reg_val));
> > > +	}

> > This looks like it's trying to do regmap_raw_read()?  Raw I/O bypasses
> > all the endianness conversions.

> We also try regmap_raw_read() but it fails because the value width
> is 9 bits. Therefor, we make the functions by ourselves.

You're not open coding this, this is using regmap!

> > > +static struct snd_soc_codec_driver soc_codec_dev_nau8810 = {

> > > +	.controls = nau8810_snd_controls,
> > > +	.num_controls = ARRAY_SIZE(nau8810_snd_controls),
> > > +	.dapm_widgets = nau8810_dapm_widgets,
> > > +	.num_dapm_widgets = ARRAY_SIZE(nau8810_dapm_widgets),
> > > +	.dapm_routes = nau8810_dapm_routes,
> > > +	.num_dapm_routes = ARRAY_SIZE(nau8810_dapm_routes),

> > Move this data into the component driver please.

> I don't understand about it clearly. Is the snd_soc_codec_driver
> not component driver? Could you tell me more details? Thank you.

You need to set these values in the actual component driver struct, not
directly in the CODEC driver.  Look at the series of changes
Morimoto-san made recently for this.

--h/VGaWN5ITqlMCVM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXsu09AAoJECTWi3JdVIfQaEgH/3AHp6Qekl/dDMQ19tXD9fGG
mZZz31enYFhlBBXO2UbfhsRPwnBH5Ntj2brWig/hOwEat8lRUTryhpI+d9WK5rWp
R9hxMsDhMXkMVuYUnmqA+JZVlR2vBIbOU7w0bJeyQVil7qEung0y2QPL0PVqPZo4
JP+ZaWuZNzFA1u0uGm3ihPkTedWOt3+b0yTiMJt5+XXTn9/pejXJwvh1MLBq7Rtb
dEDyNeHegkPILbw8IgIfxEiM57sOuCTkF8RhWQOY8D6oSTU6GaYnbOLCUiwx/FO1
YmVtkPw49dZDXvYXKaudrLVw/jS4HRw6Xk4unHVjX7M+j76eSD/uX7++f4EdeOQ=
=BEbI
-----END PGP SIGNATURE-----

--h/VGaWN5ITqlMCVM--

--===============2498066916424986260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2498066916424986260==--
