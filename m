From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH 1/3] sound/soc/codecs: add LAPIS Semiconductor ML26124
Date: Tue, 22 Nov 2011 19:47:10 +0900
Message-ID: <CANKRQngsHv5M1+LaDq-fmaFCpG3f80DbJOrtvNShLn6hNWfg=w@mail.gmail.com>
References: <1321848532-8784-1-git-send-email-tomoya.rohm@gmail.com>
	<20111121112607.GB3784@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111121112607.GB3784@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Thank you for your comments.
I have some questions.

2011/11/21 Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>> +static const struct snd_kcontrol_new ml26124_snd_controls[] =3D {
>> + =A0 =A0 SOC_SINGLE_TLV("Record Digital Volume", ML26124_RECORD_DIG=
_VOL, 0, 0xff, 1, rec_play_digi_vol),
>
> Capture, not Record.

OK,
BTW, What's TLV ? Let me know the full spell of this "TLV".

>
>> +static const struct snd_kcontrol_new ml26124_dsp_controls[] =3D {
>> + =A0 =A0 SOC_SINGLE("Play Limitter ON/OFF", ML26124_FILTER_EN, 0, 1=
, 0),
>
Do you mean SOC_SINGLE("Play Limitter Switch", ML26124_FILTER_EN, 0, 1,=
 0) ?


>> + =A0 =A0 SOC_SINGLE("Set ALC position", ML26124_FILTER_EN, 5, 1, 0)=
,
>
> What does this actually do? =A0From the name it *really* doesn't look=
 like
> a mixer input.
>
The above means where connects the ALC.
So, this doesn't relate to mixer input.


>> +static const struct snd_soc_dapm_route intercon[] =3D {
>> +};
>
> I can't see how any of the DAPM widgets you specify will ever work wi=
th
> no interconnections.
I see.
However I couldn't understand the meaning of the widgets. So I didn't
write anything.
=46or example, wm8731 writes like below.
Could you explain this ?

static const struct snd_soc_dapm_route wm8731_intercon[] =3D {
	{"DAC", NULL, "OSC", wm8731_check_osc},
	{"ADC", NULL, "OSC", wm8731_check_osc},
	{"DAC", NULL, "ACTIVE"},
	{"ADC", NULL, "ACTIVE"},

	/* output mixer */
	{"Output Mixer", "Line Bypass Switch", "Line Input"},
	{"Output Mixer", "HiFi Playback Switch", "DAC"},
	{"Output Mixer", "Mic Sidetone Switch", "Mic Bias"},

	/* outputs */
	{"RHPOUT", NULL, "Output Mixer"},
	{"ROUT", NULL, "Output Mixer"},
	{"LHPOUT", NULL, "Output Mixer"},
	{"LOUT", NULL, "Output Mixer"},

	/* input mux */
	{"Input Mux", "Line In", "Line Input"},
	{"Input Mux", "Mic", "Mic Bias"},
	{"ADC", NULL, "Input Mux"},

	/* inputs */
	{"Line Input", NULL, "LLINEIN"},
	{"Line Input", NULL, "RLINEIN"},
	{"Mic Bias", NULL, "MICIN"},
};



>
>> +
>> +static int snd_card_codec_reg_read(struct ml26124_priv *priv,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uns=
igned char reg, unsigned char *val)
>> +{
>> + =A0 =A0 unsigned char data;
>> + =A0 =A0 struct i2c_client *i2c;
>
> Use the standard register access code, don't open code things in your
> driver unless there's a good reason to. =A0Current best practice for =
most
> I2C or SPI devices is to use regmap, see any recently added driver fo=
r
> examples.
What's "regmap" mean ? or do you mean drivers/mfd/* ?
Could you tell me this ?

>> + =A0 =A0 unsigned char data;
>> + =A0 =A0 unsigned int rate =3D priv->rate;
>> + =A0 =A0 unsigned int channels =3D priv->ch;
>> +
>> + =A0 =A0 snd_card_codec_reg_read(priv, 0x30, &data); =A0 =A0 =A0/* =
Read MICVIAS Voltage */
>> +
>> + =A0 =A0 snd_card_codec_reg_write(priv, 0x10, 0x01); =A0 =A0 /* sof=
t reset assert */
>> + =A0 =A0 snd_card_codec_reg_write(priv, 0x10, 0x00); =A0 =A0 /* sof=
t reset negate */
>> +
>> + =A0 =A0 snd_card_codec_reg_write(priv, 0x0c, 0x00); =A0 =A0 /* Sto=
p clock =A0*/
>
> Use snd_soc_update_bits() and the other standard register access
> functions.
Using snd_soc_update_bits(), need to register ".read" method.
Is the same as the above  snd_card_codec_reg_read ?

Thanks in advance,
---
tomoya
ROHM Co., Ltd
