From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH 1/3] sound/soc/codecs: add LAPIS Semiconductor ML26124
Date: Fri, 25 Nov 2011 11:03:17 +0900
Message-ID: <CANKRQng9zQkWPy8fH39BTQ9PKMEt2bOhEvrn9fWszhqSBO1rjw@mail.gmail.com>
References: <1321848532-8784-1-git-send-email-tomoya.rohm@gmail.com>
	<20111121112607.GB3784@opensource.wolfsonmicro.com>
	<CANKRQngsHv5M1+LaDq-fmaFCpG3f80DbJOrtvNShLn6hNWfg=w@mail.gmail.com>
	<20111122111920.GB30048@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111122111920.GB30048@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

>> > Use the standard register access code, don't open code things in y=
our
>> > driver unless there's a good reason to. =A0Current best practice f=
or most
>> > I2C or SPI devices is to use regmap, see any recently added driver=
 for
>> > examples.
>
>> What's "regmap" mean ? or do you mean drivers/mfd/* ?
>> Could you tell me this ?
>
> drivers/base/regmap and also grep in sound/soc/codecs/*.c
Though grepping "regmap" at sound/soc/codecs/*.c, I couldn't find any f=
ile.
Is this true ?

Thanks,
tomoya

2011/11/22 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Tue, Nov 22, 2011 at 07:47:10PM +0900, Tomoya MORINAGA wrote:
>> 2011/11/21 Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>
>> BTW, What's TLV ? Let me know the full spell of this "TLV".
>
> Tag/Length/Value.
>
>> >> +static const struct snd_kcontrol_new ml26124_dsp_controls[] =3D =
{
>> >> + =A0 =A0 SOC_SINGLE("Play Limitter ON/OFF", ML26124_FILTER_EN, 0=
, 1, 0),
>
>> Do you mean SOC_SINGLE("Play Limitter Switch", ML26124_FILTER_EN, 0,=
 1, 0) ?
>
> Yes.
>
>> >> + =A0 =A0 SOC_SINGLE("Set ALC position", ML26124_FILTER_EN, 5, 1,=
 0),
>
>> > What does this actually do? =A0From the name it *really* doesn't l=
ook like
>> > a mixer input.
>
>> The above means where connects the ALC.
>> So, this doesn't relate to mixer input.
>
> If this control is not a mixer input it should not be a mixer input i=
n
> the driver. =A0Though with your explanation I still don't understand =
what
> it does so presumably the naming also needs to be improved.
>
>> However I couldn't understand the meaning of the widgets. So I didn'=
t
>> write anything.
>
> See Documentation/sound/alsa/soc/dapm.txt.
>
>> >> +static int snd_card_codec_reg_read(struct ml26124_priv *priv,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
unsigned char reg, unsigned char *val)
>> >> +{
>> >> + =A0 =A0 unsigned char data;
>> >> + =A0 =A0 struct i2c_client *i2c;
>
>> > Use the standard register access code, don't open code things in y=
our
>> > driver unless there's a good reason to. =A0Current best practice f=
or most
>> > I2C or SPI devices is to use regmap, see any recently added driver=
 for
>> > examples.
>
>> What's "regmap" mean ? or do you mean drivers/mfd/* ?
>> Could you tell me this ?
>
> drivers/base/regmap and also grep in sound/soc/codecs/*.c
>
>> > Use snd_soc_update_bits() and the other standard register access
>> > functions.
>
>> Using snd_soc_update_bits(), need to register ".read" method.
>
> Or use a cache.
>
>> Is the same as the above =A0snd_card_codec_reg_read ?
>
> I don't understand this question.
>
