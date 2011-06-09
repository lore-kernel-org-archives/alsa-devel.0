From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Re: [PATCH 1/1] ASoC: codecs: max98088: Combined DAI
 operations for DAI1 and DAI2.
Date: Thu, 9 Jun 2011 11:55:11 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40DDEA37AB0@ITSVLEX06.it.maxim-ic.internal>
References: <BANLkTik5m4Guvqq_UtDpCzEjZDdbMM1vZQ@mail.gmail.com>
	<BANLkTi=_3uKgTC1O7KSUPMKEVEGHC1e=Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id D2CE5103BE1
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 20:55:17 +0200 (CEST)
In-Reply-To: <BANLkTi=_3uKgTC1O7KSUPMKEVEGHC1e=Kw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jin Park <jinyoungp@nvidia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jassi Brar <jassisinghbrar@gmail.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 09, 2011, Jin Park wrote:

> Combined DAI operations for DAI1 and DAI2.
> For this, added id into DAI runtime data to identify each DAI.
> =

> Signed-off-by: Jin Park <jinyoungp@nvidia.com>

> @@ -1262,87 +1262,43 @@ static int max98088_dai1_hw_params(struct snd_pcm=
_substream *substream,
>
> - =A0 =A0 =A0 cdata =3D &max98088->dai[1];
> + =A0 =A0 =A0 cdata =3D &max98088->dai[dai->id - 1];

Please add BUG_ON protection in case later someone changes the id usage.

Mark, what's your thought on the use of id for this purpose here?
Would it be better to have 2 wrapper DAI functions passing in the DAI numbe=
r?


> +static int max98088_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fm=
t)
> =A0{
> + =A0 =A0 =A0 unsigned short fmt_reg;
> + =A0 =A0 =A0 unsigned short clk_reg;
> + =A0 =A0 =A0 unsigned short clkcfg_hi_reg;
> + =A0 =A0 =A0 unsigned short clkcfg_lo_reg;
> + =A0 =A0 =A0 u8 clk_val;
> + =A0 =A0 =A0 u8 fmt_val =3D 0;
> +
> + =A0 =A0 =A0 switch (dai->id) {
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmt_reg =3D M98088_REG_14_DAI1_FORMAT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_reg =3D M98088_REG_15_DAI1_CLOCK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkcfg_hi_reg =3D M98088_REG_12_DAI1_CLKCFG=
_HI;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkcfg_lo_reg =3D M98088_REG_13_DAI1_CLKCFG=
_LO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmt_reg =3D M98088_REG_1C_DAI2_FORMAT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_reg =3D M98088_REG_1D_DAI2_CLOCK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkcfg_hi_reg =3D M98088_REG_1A_DAI2_CLKCFG=
_HI;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkcfg_lo_reg =3D M98088_REG_1B_DAI2_CLKCFG=
_LO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }

These added local variables and their initialization repeats.
It may be better to put them in struct max98088_cdata[].


> @@ -1470,127 +1439,54 @@ static int max98088_dai1_set_fmt(struct snd_soc_=
dai *codec_dai,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg15val =3D M98088_DAI_BSEL64;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_val =3D M98088_DAI_BSEL64;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (max98088->digmic)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg15val |=3D M98088_DAI_OS=
R64;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, M98088_REG_15_DAI1_CLO=
CK, reg15val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_val |=3D M98088_DAI_OSR=
64;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, clk_reg, clk_val);

DAI2 does not have an OSR bit in the _CLOCK register.
In the combined function, this should be conditionally for DAI1 only.

Peter
