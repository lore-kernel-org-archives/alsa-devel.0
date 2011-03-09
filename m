From: Cliff Cai <cliffcai.sh@gmail.com>
Subject: Re: [PATCH] Add driver for Analog Devices ADAU1701
	SigmaDSP
Date: Wed, 9 Mar 2011 15:04:03 +0800
Message-ID: <AANLkTinmbJWAoFPPT9aNrJQ+E+eb-3a1F_cV-d2J3YGj@mail.gmail.com>
References: <1299460302-15392-1-git-send-email-cliff.cai@analog.com>
	<20110307114142.GB13471@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 45A032452F
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 08:04:04 +0100 (CET)
Received: by fxm11 with SMTP id 11so184788fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Mar 2011 23:04:04 -0800 (PST)
In-Reply-To: <20110307114142.GB13471@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: cliff.cai@analog.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, akpm@linux-foundation.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 7, 2011 at 7:41 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Mar 07, 2011 at 09:11:42AM +0800, cliff.cai@analog.com wrote:
>
>> From: Cliff Cai <cliff.cai@analog.com>
>
>> ADAU1701 is an SigmaDSP processor,it supports I2S audio interface.
>
> As with previous submissions from you guys this won't compile with
> current ASoC versions. =A0All new driver code submitted for mainline
> should be submitted against the development versions of the trees you're
> submitting against, in general -next contains everything relevant.
>
>> It needs to include "linux/sigma.h" which is still in Andrew Morton's
>> tree.
>
> Is this needed by other trees? =A0I can't apply this driver until it's
> merged into ASoC via some means. =A0I guess it'll go in during the merge
> window, though, and you do need to respin.
>
>> =A0 =A0 =A0 select SND_SOC_PCM3008
>> =A0 =A0 =A0 select SND_SOC_SPDIF
>> =A0 =A0 =A0 select SND_SOC_SSM2602 if I2C
>> + =A0 =A0 select SND_SOC_ADAU1701 if I2C
>> =A0 =A0 =A0 select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
>> =A0 =A0 =A0 select SND_SOC_TLV320AIC23 if I2C
>
> This presumably also needs to select the DSP API otherwise it's not
> going to build.
>
> As ever, keep the Kconfig and Makefile sorted.
>
>> +#define AUDIO_NAME "adau1701"
>> +#define ADAU1701_VERSION "0.10"
>
> These aren't referenced anywhere, remove them.
>
>> +/*
>> + * Write a ADAU1701 register,since the register length is from 1 to 5,
>> + * So, use our own read/write functions instead of snd_soc_read/write.
>> + */
>> +static int adau1701_write_register(struct snd_soc_codec *codec,
>> + =A0 =A0 u16 reg_address, u8 length, u32 value)
>> +{
>
> It loooks like the register length is hard coded in every location that
> the register is referenced. =A0This doesn't seem ideal - it'd be much
> nicer to have the register I/O functions work this out without the
> callers needing to.

I'm afraid it's not easy to do so.

>> +static int adau1701_pcm_prepare(struct snd_pcm_substream *substream,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc=
_dai *dai)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D dai->codec;
>> + =A0 =A0 int reg =3D 0;
>> +
>> + =A0 =A0 reg =3D SEROCTL_MASTER | SEROCTL_OBF16 | SEROCTL_OLF1024;
>> + =A0 =A0 adau1701_write_register(codec, ADAU1701_SEROCTL, 2, reg);
>> +
>> + =A0 =A0 return 0;
>> +}
>
> This looks like some of it is DAI format and word length configuration?

no,it makes the processor work in master mode.and output bit clock and
frame clock.

>> +static void adau1701_shutdown(struct snd_pcm_substream *substream,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai=
 *dai)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D dai->codec;
>> +
>> + =A0 =A0 adau1701_write_register(codec, ADAU1701_SEROCTL, 2, 0);
>> +}
>
> I suspect this isn't going to work for simultaneous playback and capture
> - it's not clear what the code does but I'd guess it will stop things
> completely.

this SigmaDSP doesn't support duplex operation,it can choose either
ADCs or serial port as input source.
>> +static int adau1701_set_dai_fmt(struct snd_soc_dai *codec_dai,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int fmt)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D codec_dai->codec;
>> + =A0 =A0 u32 reg =3D 0;
>> +
>> + =A0 =A0 reg =3D adau1701_read_register(codec, ADAU1701_SERITL1, 1);
>> + =A0 =A0 /* interface format */
>> + =A0 =A0 switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>> + =A0 =A0 case SND_SOC_DAIFMT_I2S:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SND_SOC_DAIFMT_LEFT_J:
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D SERITL1_LEFTJ;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 /* TODO: support TDM */
>
> I'd expect that the I2S case should be clearing a bitmask.
>
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>
> Return an error if you don't support something. =A0The same issue applies
> elsewhere in the function.
>
>> +static int adau1701_set_bias_level(struct snd_soc_codec *codec,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum snd_so=
c_bias_level level)
>> +{
>> + =A0 =A0 u16 reg;
>> + =A0 =A0 switch (level) {
>> + =A0 =A0 case SND_SOC_BIAS_ON:
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D adau1701_read_register(codec, ADAU1701=
_AUXNPOW, 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(AUXNPOW_AAPD | AUXNPOW_D0PD | AUXNP=
OW_D1PD | =A0AUXNPOW_D2PD |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AUXNPOW_D3PD | AUXNPOW_VBPD=
 | AUXNPOW_VRPD);
>> + =A0 =A0 =A0 =A0 =A0 =A0 adau1701_write_register(codec, ADAU1701_AUXNPO=
W, 2, reg);
>
> You were also updating some of the same register bits in the mute
> function. =A0This looks buggy.

the processor has no switchs to mute or unmute ADCS/DACs,only thing we
can do is turning them off or on.

>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SND_SOC_BIAS_PREPARE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SND_SOC_BIAS_STANDBY:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SND_SOC_BIAS_OFF:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* everything off, dac mute, inactive */
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D adau1701_read_register(codec, ADAU1701=
_AUXNPOW, 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D AUXNPOW_AAPD | AUXNPOW_D0PD | AUXNPOW=
_D1PD | =A0AUXNPOW_D2PD |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AUXNPOW_D3PD | AUXNPOW_VBPD=
 | AUXNPOW_VRPD;
>> + =A0 =A0 =A0 =A0 =A0 =A0 adau1701_write_register(codec, ADAU1701_AUXNPO=
W, 2, reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> It's very odd that the code only does anything in _OFF or _ON - what
> exactly are these updates doing?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 .rates =3D ADAU1701_RATES,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .formats =3D ADAU1701_FORMATS,
>> + =A0 =A0 },
>> + =A0 =A0 .ops =3D &adau1701_dai_ops,
>> +};
>> +EXPORT_SYMBOL_GPL(adau1701_dai);
>
> This is not required.
>
>> +static ssize_t adau1371_dsp_load(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dev=
ice_attribute *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char=
 *buf, size_t count)
>> +{
>> + =A0 =A0 int ret =3D 0;
>> + =A0 =A0 struct adau1701_priv *adau1701 =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct snd_soc_codec *codec =3D adau1701->codec;
>> + =A0 =A0 ret =3D adau1701_setprogram(codec);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return count;
>> +}
>> +static DEVICE_ATTR(dsp, 0644, NULL, adau1371_dsp_load);
>
> You're marking the file as supporting both read and write but only
> providing write functionality, and the write functionality totally
> ignores the written data.
>
> More generally this doesn't seem like a great interface - apparently the
> device requries that firmware be loaded but the whole firmware load
> process isn't at all joined up with the driver code meaning that the
> application layer has to figure out when firmware needs to be reloaded,
> there's no understanding on the part of the driver of what the firmware
> on the device is doing or how it's glued into the audio subsystem.
>
>> + =A0 =A0 ret =3D adau1701_setprogram(codec);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Loading program data failed\n=
");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> + =A0 =A0 }
>> + =A0 =A0 reg =3D DSPCTRL_DAM | DSPCTRL_ADM;
>> + =A0 =A0 adau1701_write_register(codec, ADAU1701_DSPCTRL, 2, reg);
>> + =A0 =A0 reg =3D 0x08;
>> + =A0 =A0 adau1701_write_register(codec, ADAU1701_DSPRES, 1, reg);
>
> Should these DSP configuations things be part of downloading firmware?

these configurations above loading firmware mainly used to avoid pops/clicks
and cleanup some registers in the DSP core.

>> + =A0 =A0 adau1701_write_register(codec, ADAU1701_AUXNPOW, 2, 0);
>> + =A0 =A0 reg =3D AUXADCE_AAEN;
>> + =A0 =A0 adau1701_write_register(codec, ADAU1701_AUXADCE, 2, reg);
>> + =A0 =A0 reg =3D DACSET_DACEN;
>> + =A0 =A0 adau1701_write_register(codec, ADAU1701_DACSET, 2, reg);
>> + =A0 =A0 reg =3D DSPCTRL_DAM | DSPCTRL_ADM | DSPCTRL_CR;
>> + =A0 =A0 adau1701_write_register(codec, ADAU1701_DSPCTRL, 2, reg);
>> + =A0 =A0 /* Power-up the oscillator */
>> + =A0 =A0 adau1701_write_register(codec, ADAU1701_OSCIPOW, 2, 0);
>
> This looks like it's all power management which I'd expect to see
> handled in either the bias management functions or ideally DAPM. =A0It
> also appears that the oscillator is an optional feature so it should be
> used conditionally.

the processor can receive MCLK either from external clock source or
crystal oscillator,
currently we use the on board crystal,and it can't be turned
off,otherwise the whole chip will be in an unpredicted status,
only output clocks can be disabled.

>> + =A0 =A0 struct adau1701_priv *adau1701 =3D snd_soc_codec_get_drvdata(c=
odec);
>> +
>> + =A0 =A0 adau1701->codec =3D codec;
>
> You don't actually ever seem to reference the codec pointer you're
> storing, perhaps just loose it?
>
>> +/* Bit fields */
>> +#define DSPCTRL_CR =A0 =A0 =A0 =A0 =A0 (1 << 2)
>> +#define DSPCTRL_DAM =A0 =A0 =A0 =A0 =A0(1 << 3)
>> +#define DSPCTRL_ADM =A0 =A0 =A0 =A0 =A0(1 << 4)
>> +#define DSPCTRL_IST =A0 =A0 =A0 =A0 =A0(1 << 5)
>> +#define DSPCTRL_IFCW =A0 =A0 =A0 =A0 (1 << 6)
>> +#define DSPCTRL_GPCW =A0 =A0 =A0 =A0 (1 << 7)
>> +#define DSPCTRL_AACW =A0 =A0 =A0 =A0 (1 << 8)
>
> These and the other bitfield definitions in the header should all be
> namespaced.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
