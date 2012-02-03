From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH ] ASoC: Add support for TI LM49453 Audio
	codec
Date: Fri, 3 Feb 2012 13:25:04 +0000
Message-ID: <20120203132504.GK3151@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89434AB423B2@EXMAIL02.scwf.nsc.com>
	<20120202231427.GG3112@opensource.wolfsonmicro.com>
	<290463D19D2E064191F1F96ECA480A89434ABCAEDD@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6426746358134963005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 79CA9103E85
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 14:25:06 +0100 (CET)
In-Reply-To: <290463D19D2E064191F1F96ECA480A89434ABCAEDD@EXMAIL02.scwf.nsc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Reddy, MR Swami" <MR.Swami.Reddy@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6426746358134963005==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g4MvFqI7wmANiPDo"
Content-Disposition: inline


--g4MvFqI7wmANiPDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2012 at 04:19:00AM -0800, Reddy, MR Swami wrote:

Fix your mailer to word wrap within paragraphs.  I'm sure I've mentioned
this before...

> >> +       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQL_REG, (state->in =
& 0xff));
> >> +       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQH_REG,
> >> +                            ((state->in >> 8) & 0xff));
> >> +
> >> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETLL_REG,
> >> +                            state->out & 0xff);
> >> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETLH_REG,
> >> +                            (state->out >> 8) & 0xff);
> >> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETHL_REG,
> >> +                            (state->out >> 16) & 0xff);
> >> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETHH_REG,
> >> +                            (state->out >> 24) & 0xff);

> The above code used to set the reference frequencies for FLL and VCO.
> Ideally, this code can be removed, because these registers are used
> for reference only.

You're saying that the PLL is actually not user configurable at all and
the above register writes have no effect?

> >> +       switch (lm49453->sysclk) {
> >> +       case 12288000:
> >> +       case 26000000:
> >> +       case 19000000:
> >> +               /* PLL CLK slection */
> >> +               pll_clk =3D ~BIT(4);
> >> +               break;
> >> +       case 48000:
> >> +       case 32576:
> >> +               /* FLL CLK slection */
> >> +               pll_clk =3D BIT(4);
> >> +               break;
> >> +       default:
> >> +               return -EINVAL;
> >> +       }

> The above code used to set for CLOCK type (ie either PLL or  FLL). The
> sysclk is PLL (HIGH FREQ mode) or FLL (LOW FREQ mode). So based on the
> sysclk, the BIT(4) will be set.

This doesn't address my comment (which you've deleted from my reply)
at all.  Why is this being done in hw_params()?  It appears to be
totally unrelated to hw_params().

The clocking configuration in this driver seems very confused, the
system clock for the device should be being configured by some
combinantion of set_sysclk() and set_pll() and hw_params() should do any
adjustment of the clock dividers and so on to configure the rest of the
chip for the sample rate based on the current clocking configuration.

> >> +       case SND_SOC_BIAS_STANDBY:
> >> +               if (codec->dapm.bias_level =3D=3D SND_SOC_BIAS_OFF)
> >> +                       regcache_sync(lm49453->regmap);
> >> +      =20
> >> +               snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
> >> +                                   LM49453_PMC_SETUP_CHIP_EN, 0);
> >> +               break;
> >> +
> >> +       case SND_SOC_BIAS_OFF:
> >> +               snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
> >> +                                   LM49453_PMC_SETUP_CHIP_EN, 0);
> >> +               break;
> >> +       }

> Setting CHIP_EN bit as '0'. In the _STANDBY mode, CHIP_EN bit setting
> not needed and will remove in the next patch.

This also sounds broken, as I repeatedly said when reviewing previous
versions of the driver if disabling the chip does anything at all then
why don't you need to reenable the chip later?

--g4MvFqI7wmANiPDo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPK+AoAAoJEBus8iNuMP3divoP/1Gb4ldTmOKjaufzNFLaHtal
PV0i02uDXPhYg9wGABKCE1YNjU5NUZW1jECWXPpdUx199DdkTviE3ykH3eQdUTpG
SX8m96iRPDR72uFG9rhNmSCN+eiT4d157oa58ePc8b2Rh1EePQRWv6hJHOqiOmi8
HW3m6r94IDikh3jcJ8reWz16czH79oNqFYec9QZu0Sz6k95NX73nPVaFP3M4xMUD
qkQusNtHp7k4Bygk7E7ise2sBeV+OM/EVo7HUQjb9Wwi9XD0sU4kVoMCnF2D2x6I
RThSARCT/+aM4RGmu2doJqwQayBPmqTnLyXt2aifgm6U5Fk1x4yYfrCSJgWOAoIO
5qLxVw/fFQ8jv/SS8S3XhM+EP8ATOvRmoS6EHvjLC/GV5hihJ9YiCwLsr8PHfhTN
bLKT5PmGNrH+BqziPtkyhKCciBLZtQovlICqjH4iJPS/WXsIhK0qlN0/ZvLCzEFk
xctHRSq6xJv5mAv+oZ5XXbIhaw37pnD01+7EFcwZutFuVGw7hlDfXyu7Nad6Awdp
09XL4wLTpD/4YIE1EnJO+ebgLbNKC77m9wuAGoiFfGDhBLg49bmwv7495zdBEChn
aEs2LP3o+o26H8OYS77tDcnyBjG44lHI7ZYN25vsk66WCOn7X0QmsvcvhstkKHHQ
RFGAc0klcMUAaGdHttoB
=uDwl
-----END PGP SIGNATURE-----

--g4MvFqI7wmANiPDo--

--===============6426746358134963005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6426746358134963005==--
