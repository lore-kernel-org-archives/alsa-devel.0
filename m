From: =?UTF-8?B?5a6L5a6d5Y2O?= <21cnbao@gmail.com>
Subject: Re: [PATCH] New ASoC Drivers for ADI AD1938 codec
Date: Mon, 13 Jul 2009 16:12:14 +0800
Message-ID: <3c17e3570907130112i128dd0f2o4673200de3125d5d@mail.gmail.com>
References: <1245403695-20537-1-git-send-email-21cnbao@gmail.com>
	 <20090619104738.GF5270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754676AbZGMIMV@vger.kernel.org>
In-Reply-To: <20090619104738.GF5270@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lrg@slimlogic.co.uk, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

2009/6/19 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Jun 19, 2009 at 05:28:15PM +0800, Barry Song wrote:
>> 1. add AD1938 codec driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (codec)
>> 2. add blackfin SPORT-TDM DAI and PCM driver (platform)
>> 3. add bf5xx board with AD1938 driver =C2=A0 =C2=A0 =C2=A0 =C2=A0(ma=
chine)
>
> As Liam said you really need to submit this as a patch series rather
> than as a single big patch - as your commit log here indicates you've
> got several different things going on here.
>
>> +++ b/include/sound/soc-dai.h
>> @@ -30,6 +30,7 @@ struct snd_pcm_substream;
>> =C2=A0#define SND_SOC_DAIFMT_DSP_A =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 /* =
L data msb after FRM LRC */
>> =C2=A0#define SND_SOC_DAIFMT_DSP_B =C2=A0 =C2=A0 =C2=A0 =C2=A0 4 /* =
L data msb during FRM LRC */
>> =C2=A0#define SND_SOC_DAIFMT_AC97 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
5 /* AC97 */
>> +#define SND_SOC_DAIFMT_SPORT_TDM =C2=A0 =C2=A0 6 /* SPORT TDM for A=
DI parts */
>
> If you're going to add a new DAI format that really needs more
> explanation than this explaining what the DAI format is. =C2=A0It'd b=
e very
> surprising to see hardware needing a new format.
>
> Looking at the datasheet for the ad1938 it appears that the actual
> format here is just normal I2S with TDM. =C2=A0This does not need a n=
ew DAI
> format or new CPU DAI, you just need to add suport for TDM to the
> Blackfin I2S driver. =C2=A0The format is fairly standard and implemen=
ted by a
> number of other devices.
>
> See set_tdm_slot() for setting up the higher channel counts - there's
> some ongoing revisions to that API so you'll want to also ensure that
> the code is set up so that it can cope with specification of the samp=
le
> width for each slot in set_tdm_slot().
>
> Given this I've only looked at the CODEC driver below.
>
>> diff --git a/sound/soc/codecs/ad1938.c b/sound/soc/codecs/ad1938.c
>> new file mode 100644
>> index 0000000..9aa78e1
>> --- /dev/null
>> +++ b/sound/soc/codecs/ad1938.c
>
>> + *
>> + * =C2=A0Revision history
>> + * =C2=A0 =C2=A04 June 2009 =C2=A0 Initial version.
>
> Don't include this, git provides code history for us.
>
>> +struct snd_soc_device *ad1938_socdev;
>> +
>> +/* dac de-emphasis enum control */
>> +static const char *ad1938_deemp[] =3D {"flat", "48kHz", "44.1kHz", =
"32kHz"};
>
> For consistency with other drivers "flat" should be "None".
>
>> +/* AD1938 volume/mute/de-emphasis etc. controls */
>> +static const struct snd_kcontrol_new ad1938_snd_controls[] =3D {
>> + =C2=A0 =C2=A0 /* DAC volume control */
>> + =C2=A0 =C2=A0 SOC_SINGLE("DAC L1 Volume", AD1938_DAC_L1_VOL, 0, 0x=
=46F, 1),
>> + =C2=A0 =C2=A0 SOC_SINGLE("DAC R1 Volume", AD1938_DAC_R1_VOL, 0, 0x=
=46F, 1),
>
> These (and the other stereo pairs below) should be SOC_DOUBLE_R(). =C2=
=A0This
> allows ALSA to represent them as stereo controls to applications rath=
er
> than as two separate controls. =C2=A0You should also provide TLV info=
rmation
> so actually SOC_DOUBLE_R_TLV() if possible.
>
>> + =C2=A0 =C2=A0 /* DAC mute control */
>> + =C2=A0 =C2=A0 SOC_SINGLE("DAC L1 Switch", AD1938_DAC_CHNL_MUTE, 0,=
 1, 1),
>> + =C2=A0 =C2=A0 SOC_SINGLE("DAC R1 Switch", AD1938_DAC_CHNL_MUTE, 1,=
 1, 1),
>
> These should be stereo controls too - SOC_DOUBLE() since they're in t=
he
> same register.
>
>> + =C2=A0 =C2=A0 /* ADC mute control */
>> + =C2=A0 =C2=A0 SOC_SINGLE("ADC L1 Switch", AD1938_ADC_CTRL0, ADC0_M=
UTE, 1, 1),
>> + =C2=A0 =C2=A0 SOC_SINGLE("ADC R1 Switch", AD1938_ADC_CTRL0, ADC1_M=
UTE, 1, 1),
>
> These too.
>
>> + =C2=A0 =C2=A0 /* DAC de-emphasis */
>> + =C2=A0 =C2=A0 SOC_ENUM("Playback Deemphasis", ad1938_enum[0]),
>
> Don't put your enums in an array, use named variables for them. =C2=A0=
This
> makes drivers easier to maintian when you get a lot of enums.
>
>> +static int ad1938_add_controls(struct snd_soc_codec *codec)
>> +{
>> + =C2=A0 =C2=A0 int err, i;
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < ARRAY_SIZE(ad1938_snd_controls); i=
++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D snd_ctl_add(code=
c->card,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snd_soc_cnew(&ad1938_snd_controls[i], c=
odec, NULL));
>
> Use snd_soc_add_controls() here - you can replace the entire function
> with a call to that.
>
>> +/* dac/adc/pll poweron/off functions */
>> +static int ad1938_dac_powerctrl(struct snd_soc_codec *codec, int cm=
d)
>> +{
>> + =C2=A0 =C2=A0 int reg;
>> +
>> + =C2=A0 =C2=A0 reg =3D codec->read(codec, AD1938_DAC_CTRL0);
>> + =C2=A0 =C2=A0 if (cmd)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg &=3D ~DAC_POWERDOWN;
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg |=3D DAC_POWERDOWN;
>> + =C2=A0 =C2=A0 codec->write(codec, AD1938_DAC_CTRL0, reg);
>
> This should be handled by DAPM - either have a single DAC widget
> representing all the channels (since you don't appear to have
> independant control anyway) or have a bunch of dummy DAC widgets and =
a
> supply widget representing the actual power control. =C2=A0The same t=
hing
> applies to the ADCs.

I want to use ADC/DAC widgets.
static const struct snd_soc_dapm_widget ad1938_dapm_widgets[] =3D {
        SND_SOC_DAPM_DAC("DAC", "HiFi Playback", AD1938_DAC_CTRL0, 0, 1=
),
        SND_SOC_DAPM_ADC("ADC", "HiFi Capture", AD1938_ADC_CTRL0, 0, 1)=
,
};
But for this AD1938 codec, DAC's work depends on ADC is powered on in
hardware.  I think there is no any mechanism to handle this kind of
strange depending now.  So is there a generic way to handle this?


>
>> +static int ad1938_set_pll(struct snd_soc_dai *codec_dai,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pll_id, unsigned int=
 freq_in, unsigned int freq_out)
>> +{
>> + =C2=A0 =C2=A0 struct snd_soc_codec *codec =3D codec_dai->codec;
>> +
>> + =C2=A0 =C2=A0 if (freq_out)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ad1938_pll_powerctrl(cod=
ec, 1);
>> + =C2=A0 =C2=A0 else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* playing while recordi=
ng, framework will poweroff-poweron pll redundantly */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((!codec_dai->capture=
=2Eactive) && (!codec_dai->playback.active))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ad1938_pll_powerctrl(codec, 0);
>> + =C2=A0 =C2=A0 }
>
> Hrm. =C2=A0This appears to completely ignore the frequencies supplied=
 for the
> PLL and just provide power control. =C2=A0I suspect that you can just=
 handle
> the PLL as a SND_SOC_DAPM_SUPPLY(), there seems to be no need to expo=
se
> the set_pll() operation and make machine drivers call it given that
> there isn't any frequency configuration going on.
>
>> +static int ad1938_mute(struct snd_soc_dai *dai, int mute)
>> +{
>> + =C2=A0 =C2=A0 struct snd_soc_codec *codec =3D dai->codec;
>> +
>> + =C2=A0 =C2=A0 if (!mute)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 codec->write(codec, AD19=
38_DAC_CHNL_MUTE, 0);
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 codec->write(codec, AD19=
38_DAC_CHNL_MUTE, 0xff);
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>
> This isn't going to play well with the explicit mute controls you've =
got
> above - it's writing to the same register bits without any coordinati=
on.
> One or the other set of controls ought to be removed.
>
>> +static int ad1938_tdm_set(struct snd_soc_codec *codec)
>> +{
>> + =C2=A0 =C2=A0 codec->write(codec, AD1938_DAC_CTRL0, (codec->read(c=
odec, AD1938_DAC_CTRL0) &
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (~DAC_SERFMT_MASK)) | DAC_SERFMT_TDM);
>> + =C2=A0 =C2=A0 codec->write(codec, AD1938_DAC_CTRL1, 0x84); /* inve=
rt bclk, 256bclk/frame, latch in mid */
>> + =C2=A0 =C2=A0 codec->write(codec, AD1938_ADC_CTRL1, 0x43); /* sata=
 delay=3D1, adc aux mode */
>> + =C2=A0 =C2=A0 codec->write(codec, AD1938_ADC_CTRL2, 0x6F); /* left=
 high, driver on rising edge */
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>
> If you use set_tdm_slot() then the BCLK/frame ratio will be set by th=
at.
>
> Inversion of BCLK (and any other clocks) should be handled by the
> set_dai_fmt() operation based on the machine driver request rather th=
an
> done unconditionally.
>
>> + =C2=A0 =C2=A0 /* bit size */
>> + =C2=A0 =C2=A0 switch (params_format(params)) {
>> + =C2=A0 =C2=A0 case SNDRV_PCM_FORMAT_S16_LE:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 word_len =3D 3;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>
> Once you implement set_tdm_slot() you should allow the word length to=
 be
> configured there if it's called or otherwise keep this code here - se=
e
> Daniel Ribeiro's patche "change set_tdm_slot api to allow slot_width
> override" posted to the ALSA list this week.
>
>> +static int __devinit ad1938_spi_probe(struct spi_device *spi)
>> +{
>> + =C2=A0 =C2=A0 spi->dev.power.power_state =3D PMSG_ON;
>> + =C2=A0 =C2=A0 ad1938_socdev->card->codec->control_data =3D spi;
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static int __devexit ad1938_spi_remove(struct spi_device *spi)
>> +{
>> + =C2=A0 =C2=A0 return 0;
>> +}
>
> Your device probing should all be restructured so that the SPI device
> for the CODEC is registered as any other SPI device rather than being
> set up as part of probing the ASoC device. =C2=A0See the wm8731 drive=
r for
> an example of doing this for a SPI device.
>
> This will require that the arch code for any systems with the ad1938
> do the setup of the device.
>
>> + =C2=A0 =C2=A0 .name =3D "AD1938",
>> + =C2=A0 =C2=A0 .playback =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .stream_name =3D "Playba=
ck",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .channels_min =3D 2,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .channels_max =3D 8,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .rates =3D SNDRV_PCM_RAT=
E_48000,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .formats =3D SNDRV_PCM_F=
MTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | SND=
RV_PCM_FMTBIT_S24_LE, },
>
> Please keep your lines to under 80 columns.
>
>> +#define AD1938_PLL_CLK_CTRL0 =C2=A0 =C2=A00
>> +#define PLL_POWERDOWN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01
>> +#define AD1938_PLL_CLK_CTRL1 =C2=A0 =C2=A01
>> +#define AD1938_DAC_CTRL0 =C2=A0 =C2=A0 =C2=A0 =C2=A02
>> +#define DAC_POWERDOWN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01
>> +#define DAC_SERFMT_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00xC0
>> +#define DAC_SERFMT_STEREO =C2=A0 =C2=A0(0 << 6)
>> +#define DAC_SERFMT_TDM =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 << 6)
>
> These defines need namespacing if they're going to appear in the head=
ers
> - everything should have the AD1938_ prefix.
>



--=20
=E5=AE=8B=E5=AE=9D=E5=8D=8E 21cnbao@21cn.com
http://21cnbao.blog.51cto.com
