From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/25] ASoC: Samsung: Add common I2S driver
Date: Tue, 19 Oct 2010 20:13:34 -0700
Message-ID: <20101020031333.GH3803@opensource.wolfsonmicro.com>
References: <1287472025-27898-1-git-send-email-jassisinghbrar@gmail.com>
	<20101019093550.GA11371@opensource.wolfsonmicro.com>
	<AANLkTimaQ=7Ejgb1jZW4=VGj2-ZV-2wcX6esZwUXsC4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84E41103879
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Oct 2010 05:13:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimaQ=7Ejgb1jZW4=VGj2-ZV-2wcX6esZwUXsC4a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 20, 2010 at 11:22:26AM +0900, Jassi Brar wrote:
> On Tue, Oct 19, 2010 at 6:35 PM, Mark Brown

> > Might be as easy just to embed a struct s3c_audio_pdata within the
> > struct samsung_i2s?

> struct s3c_audio_pdata is shared among I2S, AC97, SPDIF and PCM.
> Here the idea is that controller drivers add specific structures to the u=
nion
> as and when they need it.

Right, what I'm saying is that it'd seem more natural to do things the
other way around and embed the common structure within a device specific
pdata structure instead of having the union.

> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (is_secondary(i2s)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con |=3D CON_TXSDMA_ACTIVE;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con &=3D ~CON_TXSDMA_PAUSE;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con |=3D CON_TXDMA_ACTIVE;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con &=3D ~CON_TXDMA_PAUSE;

> > Can we do this stuff with a variable storing the mask to use? =A0It mig=
ht
> > compress the code a lot but I've not looked at what the bits actually
> > are.

> sorry, I am unable to understand what you suggest

If we have something in the driver data struct specifying the masks to
use then set these at probe time rather than having the if statements -
probably the same mask can be used for playback & record if the
bitfields are lined up similarly.  This would then be:

	con |=3D data->active_mask;
	con &=3D ~data->pause_mask;

or similar, possibly with some shifts.

> >> + =A0 =A0 /* Allow LRCLK-inverted version of the supported formats */
> >> + =A0 =A0 switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> >> + =A0 =A0 case SND_SOC_DAIFMT_NB_NF:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 case SND_SOC_DAIFMT_NB_IF:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (tmp & MOD_LR_RLOW)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp &=3D ~MOD_LR_RLOW;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D MOD_LR_RLOW;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;

> > This looks a bit odd - it'll flip MOD_LR_FLOW if the frame is inverted,
> > I'd expect it to want to set a specific value?

> The frame polarity is specified by the Format(I2S, LSB, MSB), so we
> set/clear MOD_LR_RLOW acc to the Format requested.
> The Inversion request works relative to the Format -- if Frame inversion
> is requested, we simply flip it from the value set during Format setting.

Please add a comment explaining that you're inverting the orientation
you set previously - it's really surprising when reading the code.

> >> +static int i2sv2_i2s_set_clkdiv(struct snd_soc_dai *dai,
> >> + =A0 =A0 int div_id, int div)
> >> +{
> >> + =A0 =A0 struct i2s_dai *i2s =3D to_info(dai);
> >> + =A0 =A0 struct i2s_dai *other =3D i2s->pri_dai ? : i2s->sec_dai;
> >> +
> >> + =A0 =A0 if (div_id =3D=3D SAMSUNG_I2S_DIV_BCLK) {

> > switch statement please.

> Switch didn't look very pretty with just one case, so I made it if-else
> Anyways, I'll change it to switch.

It helps make the code correspond to the expected patterns for selecting
one of many clocks which is especially helpful when doing a big picture
scan.

> >> +/*
> >> + * Maximum number of I2S blocks that any SoC can have.
> >> + * The secondary interface of a CPU dai(if there exists any),
> >> + * is indexed at [cpu-dai's ID + MAX_I2S]
> >> + */
> >> +#define MAX_I2S =A0 =A0 =A04

> > Can this be kept internal to the driver? =A0If not it should be
> > namespaced.

> ASoC machine drivers need to index the secondary dai that is
> automatically created and registered by the cpu driver.
> So, it needs to be available outside.
> I'll make it SAMSUNG_I2S_SECOFF -- secondary offset of I2S(?)

How would the index be used with multi-component?
