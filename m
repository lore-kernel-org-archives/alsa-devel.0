From: "Wu, Songjun" <songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: atmel-classd: add the Audio Class D Amplifier
 code
Date: Sun, 6 Sep 2015 17:44:21 +0800
Message-ID: <55EC0AF5.8060403@atmel.com>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-2-git-send-email-songjun.wu@atmel.com>
 <20150903113716.GU12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150903113716.GU12027-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 9/3/2015 19:37, Mark Brown wrote:
> On Tue, Sep 01, 2015 at 01:41:40PM +0800, Songjun Wu wrote:
>
>> +static const char * const mono_text[] =3D {
>> +	"stereo", "mono"
>> +};
>> +
>> +static SOC_ENUM_SINGLE_DECL(classd_mono_enum,
>> +			CLASSD_INTPMR, CLASSD_INTPMR_MONO_SHIFT,
>> +			mono_text);
>
> This looks like it should be a simple Switch control called something
> like "Stereo Switch" or "Mono Switch".
>
Thank you, the code will be modified as you suggest.

>> +static const char * const deemp_text[] =3D {
>> +	"disabled", "enabled"
>> +};
>> +
>> +static SOC_ENUM_SINGLE_DECL(classd_deemp_enum,
>> +			CLASSD_INTPMR, CLASSD_INTPMR_DEEMP_SHIFT,
>> +			deemp_text);
>
> Similarly this looks like it should be "Deemph Switch".
>
Yes, it also will be modified.

>> +static const char * const eqcfg_bass_text[] =3D {
>> +	"-12 dB", "-6 dB", "0 dB", "+6 dB", "+12 dB"
>> +};
>
>> +static const unsigned int eqcfg_bass_value[] =3D {
>> +	CLASSD_INTPMR_EQCFG_B_CUT_12,
>> +	CLASSD_INTPMR_EQCFG_B_CUT_6, CLASSD_INTPMR_EQCFG_FLAT,
>> +	CLASSD_INTPMR_EQCFG_B_BOOST_6, CLASSD_INTPMR_EQCFG_B_BOOST_12
>> +};
>
> This should be a Volume control with TLV information, as should the
> following few controls.
>
The Volume control with TLV information is not suitable for this case.
Bass, Medium, and treble are mutually exclusive.
So I think the SOC_ENUM control is suitable for this case.
The register layout is not very good,
The register is defined as below.
=95  EQCFG: Equalization Selection
Value Name       Description
0     FLAT       Flat Response
1     BBOOST12   Bass boost +12 dB
2     BBOOST6    Bass boost +6 dB
3     BCUT12     Bass cut -12 dB
4     BCUT6      Bass cut -6 dB
5     MBOOST3    Medium boost +3 dB
6     MBOOST8    Medium boost +8 dB
7     MCUT3      Medium cut -3 dB
8     MCUT8      Medium cut -8 dB
9     TBOOST12   Treble boost +12 dB
10    TBOOST6    Treble boost +6 dB
11    TCUT12     Treble cut -12 dB
12    TCUT6      Treble cut -6 dB

>> +static const struct snd_kcontrol_new atmel_classd_snd_controls[] =3D=
 {
>> +SOC_SINGLE_TLV("Left Volume", CLASSD_INTPMR,
>> +		CLASSD_INTPMR_ATTL_SHIFT, 78, 1, classd_digital_tlv),
>> +
>> +SOC_SINGLE_TLV("Right Volume", CLASSD_INTPMR,
>> +		CLASSD_INTPMR_ATTR_SHIFT, 78, 1, classd_digital_tlv),
>
> This should be a single stereo control rather than separate left and
> right controls.
>
Since the classD IP defines two register fields to control left volume=20
and right volume respectively, I think it's better to provide two=20
controls to user.

>> +static const char * const pwm_type[] =3D {
>> +	"single-ended", "differential"
>> +};
>
> The normal style for ALSA controls is to capitalise strings so
> "Single ended" and "Differential".
>
Accept. It will be modified.

>> +	if (pdata->non_overlap_enable) {
>> +		val |=3D (CLASSD_MR_NON_OVERLAP_EN
>> +			<< CLASSD_MR_NON_OVERLAP_SHIFT);
>> +
>> +		mask |=3D CLASSD_MR_NOVR_VAL_MASK;
>> +		switch (pdata->non_overlap_time) {
>> +		case 5:
>> +			val |=3D (CLASSD_MR_NOVR_VAL_5NS
>> +				<< CLASSD_MR_NOVR_VAL_SHIFT);
>> +			break;
>> +		case 10:
>> +			val |=3D (CLASSD_MR_NOVR_VAL_10NS
>> +				<< CLASSD_MR_NOVR_VAL_SHIFT);
>> +			break;
>> +		case 15:
>> +			val |=3D (CLASSD_MR_NOVR_VAL_15NS
>> +				<< CLASSD_MR_NOVR_VAL_SHIFT);
>> +			break;
>> +		case 20:
>> +			val |=3D (CLASSD_MR_NOVR_VAL_20NS
>> +				<< CLASSD_MR_NOVR_VAL_SHIFT);
>> +			break;
>> +		default:
>> +			val |=3D (CLASSD_MR_NOVR_VAL_10NS
>> +				<< CLASSD_MR_NOVR_VAL_SHIFT);
>> +			break;
>> +		}
>
> I'd expect at least a warning if the user trys to specify an invalid
> value (if they didn't specify any value then I'd expect the DT parsin=
g
> function to assign the default value).
>
Accept. A warning will be added if the user trys to sepcify an invalid=20
value. This function is optional, So if the user did not specify any=20
value, this function will be disabled.

>> +static struct regmap *atmel_classd_codec_get_remap(struct device *d=
ev)
>> +{
>> +	struct atmel_classd *dd =3D dev_get_drvdata(dev);
>> +
>> +	return dd->regmap;
>> +}
>
> Can you just use dev_get_regmap()?
>
Thank you for your reminder, it's better to use dev_get_regmap().
The code will be modified.

>> +static int atmel_classd_codec_dai_startup(struct snd_pcm_substream =
*substream,
>> +				struct snd_soc_dai *codec_dai)
>> +{
>> +	struct atmel_classd *dd =3D snd_soc_dai_get_drvdata(codec_dai);
>> +
>> +	clk_prepare_enable(dd->aclk);
>> +	clk_prepare_enable(dd->gclk);
>
> Should check for errors here.
>
Accept.

>> +	dev_info(dev,
>> +		"Atmel Class D Amplifier (CLASSD) device at 0x%p (irq %d)\n",
>> +		io_base, dd->irq);
>
> This is a bit noisy and not really based on interaction with the
> hardware...  dev_dbg() seems better.
>
This information will occur only once when linux kernel starts.
It shows the classD is loaded to linux kernel.
I think it's better to provide more information to user.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
