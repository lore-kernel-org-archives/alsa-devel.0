From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Disable DACs in analog
	loopback
Date: Thu, 30 Apr 2009 11:46:48 +0300
Message-ID: <200904301146.49080.peter.ujfalusi@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F63E05BA@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 57AAE244F4
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 10:46:58 +0200 (CEST)
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F63E05BA@dlee07.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 30 April 2009 10:31:20 ext Lopez Cruz, Misael wrote:
> In analog loopback mode, DACs should not be enabled. For that reason,
> DAC widgets (DAC Right1, DAC Left1, DAC Right2, DAC Left2) will power
> DACs only during playback.
>
> Analog loopback requires to set a master enable bit when any of the
> analog bypass switches are enabled.

I have also noticed this, also in analog loopback mode the bits in the OPTI=
ON =

register can be cleared, since we don't need those to have analog loopback.

But I'm afraid, this patch does break the Digital loopback, which needs the =

DACs to be powered, in case when the capture path is set in analog mode the =

ADC(s) also need to be powered. =


Both analog and digital loopback connects to 'Analog XY Playback Mixer', wh=
ich =

turns on/off the physical DAC on the given route.
I have been thinking of - as a part of a big clean up - to separate these, =

since as you have pointed out, the DACs are not needed for the analog =

loopback.

>
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> ---
>  sound/soc/codecs/twl4030.c |   34 +++++++++++++++++++++-------------
>  1 files changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index efa1a80..d3184a0 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -64,7 +64,7 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] =3D {
>  	0x00, /* REG_VRXPGA		(0x14)	*/
>  	0x00, /* REG_VSTPGA		(0x15)	*/
>  	0x00, /* REG_VRX2ARXPGA		(0x16)	*/
> -	0x0c, /* REG_AVDAC_CTL		(0x17)	*/
> +	0x00, /* REG_AVDAC_CTL		(0x17)	*/
>  	0x00, /* REG_ARX2VTXPGA		(0x18)	*/
>  	0x00, /* REG_ARXL1_APGA_CTL	(0x19)	*/
>  	0x00, /* REG_ARXR1_APGA_CTL	(0x1A)	*/

Now that we have the DAPM routing for most of the things, these defaults ne=
eds =

to be revisited... They are left as they were mostly, but now it is safe to =

turn off most of the thing by default.

> @@ -585,7 +585,7 @@ static int bypass_event(struct snd_soc_dapm_widget *w,
>  	struct soc_mixer_control *m =3D
>  		(struct soc_mixer_control *)w->kcontrols->private_value;
>  	struct twl4030_priv *twl4030 =3D w->codec->private_data;
> -	unsigned char reg;
> +	unsigned char reg, misc;
>
>  	reg =3D twl4030_read_reg_cache(w->codec, m->reg);
>
> @@ -605,6 +605,14 @@ static int bypass_event(struct snd_soc_dapm_widget *=
w,
>  			twl4030->bypass_state &=3D ~(1 << (m->shift ? 5 : 4));
>  	}
>
> +	/* Enable master analog loopback mode if any analog switch is enabled*/
> +	misc =3D twl4030_read_reg_cache(w->codec, TWL4030_REG_MISC_SET_1);
> +	if (twl4030->bypass_state & 0xF)
> +		misc |=3D TWL4030_FMLOOP_EN;
> +	else
> +		misc &=3D ~TWL4030_FMLOOP_EN;
> +	twl4030_write(w->codec, TWL4030_REG_MISC_SET_1, misc);
> +

Oh, so there is another register/bit to be configured to enable the analog =

loopback ;) I certainly missed this bit...

>  	if (w->codec->bias_level =3D=3D SND_SOC_BIAS_STANDBY) {
>  		if (twl4030->bypass_state)
>  			twl4030_codec_mute(w->codec, 0);
> @@ -927,13 +935,13 @@ static const struct snd_soc_dapm_widget
> twl4030_dapm_widgets[] =3D {
>
>  	/* DACs */
>  	SND_SOC_DAPM_DAC("DAC Right1", "Right Front Playback",
> -			SND_SOC_NOPM, 0, 0),
> +			TWL4030_REG_AVDAC_CTL, 0, 0),
>  	SND_SOC_DAPM_DAC("DAC Left1", "Left Front Playback",
> -			SND_SOC_NOPM, 0, 0),
> +			TWL4030_REG_AVDAC_CTL, 1, 0),
>  	SND_SOC_DAPM_DAC("DAC Right2", "Right Rear Playback",
> -			SND_SOC_NOPM, 0, 0),
> +			TWL4030_REG_AVDAC_CTL, 2, 0),
>  	SND_SOC_DAPM_DAC("DAC Left2", "Left Rear Playback",
> -			SND_SOC_NOPM, 0, 0),
> +			TWL4030_REG_AVDAC_CTL, 3, 0),
>  	SND_SOC_DAPM_DAC("DAC Voice", "Voice Playback",
>  			TWL4030_REG_AVDAC_CTL, 4, 0),
>
> @@ -971,14 +979,14 @@ static const struct snd_soc_dapm_widget
> twl4030_dapm_widgets[] =3D { &twl4030_dapm_dbypassr_control, bypass_event,
>  			SND_SOC_DAPM_POST_REG),
>
> -	SND_SOC_DAPM_MIXER("Analog R1 Playback Mixer", TWL4030_REG_AVDAC_CTL,
> +	SND_SOC_DAPM_MIXER("Analog R1 Playback Mixer", SND_SOC_NOPM,
> +			0, 0, NULL, 0),
> +	SND_SOC_DAPM_MIXER("Analog L1 Playback Mixer", SND_SOC_NOPM,
> +			0, 0, NULL, 0),
> +	SND_SOC_DAPM_MIXER("Analog R2 Playback Mixer", SND_SOC_NOPM,
> +			0, 0, NULL, 0),
> +	SND_SOC_DAPM_MIXER("Analog L2 Playback Mixer", SND_SOC_NOPM,
>  			0, 0, NULL, 0),
> -	SND_SOC_DAPM_MIXER("Analog L1 Playback Mixer", TWL4030_REG_AVDAC_CTL,
> -			1, 0, NULL, 0),
> -	SND_SOC_DAPM_MIXER("Analog R2 Playback Mixer", TWL4030_REG_AVDAC_CTL,
> -			2, 0, NULL, 0),
> -	SND_SOC_DAPM_MIXER("Analog L2 Playback Mixer", TWL4030_REG_AVDAC_CTL,
> -			3, 0, NULL, 0),
>
>  	/* Output MIXER controls */
>  	/* Earpiece */

-- =

P=E9ter
