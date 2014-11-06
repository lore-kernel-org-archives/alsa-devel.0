From: Peter Rosin <peda@axentia.se>
Subject: RE: [PATCH 1/2] ASoC: tfa9879: New driver for NXP Semiconductors
 TFA9879 amplifier.
Date: Thu, 6 Nov 2014 14:37:31 +0000
Message-ID: <8798d3c4cf124aa9879225d08d8477f5@EMAIL.axentia.se>
References: <1415278441-27866-1-git-send-email-peda@lysator.liu.se>
 <1415278441-27866-2-git-send-email-peda@lysator.liu.se>
 <20141106133720.GG8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141106133720.GG8509@sirena.org.uk>
Content-Language: sv-SE
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Peter Rosin <peda@lysator.liu.se>, Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Thanks for the review! I'm answering here, but would like to thank
Lars-Peter for the review as well.

Mark Brown wrote:
> On Thu, Nov 06, 2014 at 01:54:00PM +0100, Peter Rosin wrote:
> 
> > +#define TFA9879_REG(codec, reg, field, value) 	\
> > +	snd_soc_update_bits(codec, TFA9879_ ## reg,			\
> > +			    TFA9879_ ## field ## _MASK, 	\
> > +			    (value) << TFA9879_ ## field ## _SHIFT)
> 
> Please don't do stuff like this, it just makes the code look more obscure than
> it should be for people who work with multiple devices - just use
> update_bits() directly.

Ok, I'll zap it. Pity though, I really liked the actual code even if the macro was a
bit hard to digest...

> > +static int tfa9879_prepare(struct snd_pcm_substream *substream,
> > +			   struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_codec *codec = dai->codec;
> > +
> > +	TFA9879_REG(codec, DEVICE_CONTROL, POWERUP, 1);
> 
> Use DAPM to manage power, you're probably looking for a supply widget.

I'll try to find out how to hook that up. BTW, there is very limited info about
the supply widget at http://www.alsa-project.org/main/index.php/DAPM

> > +	switch (params_format(params)) {
> > +	case SNDRV_PCM_FORMAT_S16_LE:
> 
> Use params_width() rather than a specific memory layout.

Ok.

> > +	if (tfa9879->lsb_justified)
> > +		TFA9879_REG(codec, SERIAL_INTERFACE_1, I2S_SET,
> i2s_set);
> 
> Why does this need to be reset every time, shouldn't we just be setting the
> register in set_fmt().?

Yes, I'd sure like to do that, but how do I get to the width in set_fmt()?

> > +static int tfa9879_probe(struct snd_soc_codec *codec) {
> > +	struct tfa9879_priv *tfa9879 = snd_soc_codec_get_drvdata(codec);
> > +
> > +	codec->control_data = tfa9879->regmap;
> 
> This is redundant, just remove the entire function - ASoC will get the regmap
> automatically.

Oops, sorry. Forward-porting in progress...

> > +	{ TFA9879_MISC_STATUS,		0x0000 }, /* 0x15, read-only */
> > +};
> > +
> > +static bool tfa9879_volatile_register(struct device *dev, unsigned
> > +int reg) {
> > +	return reg == TFA9879_MISC_STATUS;
> 
> If the register is volatile it shouldn't have a default value provided.

Then I misunderstood what volatile was meant to do. I'll just nuke the
function. It works fine anyway...

I'll send a v2 later, with the other bits from Lars-Peter taken care of, and
with 2/2 squashed. Need to test first though...

Cheers,
Peter
