From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ALSA: ASoc: TLV320AIC3X: ad SPI and
	clock on GPIO2 or BCLK
Date: Mon, 4 Apr 2011 09:03:19 +0100
Message-ID: <20110404080319.GA22584@opensource.wolfsonmicro.com>
References: <1300949648-15078-1-git-send-email-horms@verge.net.au> <1300949648-15078-2-git-send-email-horms@verge.net.au> <4D8B1AFD.5060508@aksignal.cz> <20110402082604.GE21737@sirena.org.uk> <4D99781D.3030807@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D99781D.3030807@aksignal.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Prchal =?utf-8?B?SmnFmcOt?= <jiri.prchal@aksignal.cz>
Cc: alsa-devel@vger.kernel.org, alsa-devel@alsa-project.org, vbarinov@embeddedalley.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 04, 2011 at 09:49:49AM +0200, Prchal Ji=C5=99=C3=AD wrote:
> Dne 2.4.2011 10:26, Mark Brown napsal(a):

> >> TODO: Set the model in SPI probe the right way. I don't know how.

> > Register two SPI drivers with different names.

> ???

Register a SPI driver per model.

> > This looks mostly good but there's some cleanups needed, mostly fro=
m
> > extra stuff which snuck in there, and you need to rebase against cu=
rrent
> > code.

> What cleanup? I copy functions snd_soc_8_8_* and made change to 7_8.

The comments I've made in the rest of the review such as removing rando=
m
whitespace updates.

> > As covered in SubmittingPatches you should always CC maintainers on
> > patches.

> Who is maintainer? I didn't find anyone, so I CC to author.

Myself and Liam Girdwood.  At the most basic level the people you'd
expect to apply the patch.

> >> +	/* set external clock on GPIO2 or BCLK */
> >> +	data =3D snd_soc_read(codec, AIC3X_CLKGEN_CTRL_REG);
> >> +	data &=3D 0x0f;
> >> +	data |=3D ((clk_id << PLLCLK_IN_SHIFT) | (clk_id << CLKDIV_IN_SH=
IFT));
> >> +	snd_soc_write(codec, AIC3X_CLKGEN_CTRL_REG, data);

> > This looks like an unrelated change which is specific to your board=
=2E
> > You should add an interface for configuring this functionality .

> No, it's for all, who uses other clock source. Interface is standard =
function:
> 	/* Set the codec system clock for DAC and ADC */
> 	ret =3D snd_soc_dai_set_sysclk(codec_dai,
> 				     CLKIN_BCLK, cdu_audio[i].codecclk,
> 				     SND_SOC_CLOCK_IN);

In that case you should submit a separate patch adding this
functionality, taking care to ensure that you don't break existing
users.

> >> +static struct spi_driver aic3x_spi_driver =3D {
> >> +	.driver =3D {
> >> +		.name	=3D "tlv320aic3x-codec",
> >> +		.owner	=3D THIS_MODULE,

> > Remove the -codec from the driver name.

> Why? In I2C part it must be there, so should it be same?

No, it should be removed from the I2C driver too.
