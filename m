From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/3] ASoC: TWL4030: Enable voice filters
	for voice sidetone
Date: Mon, 22 Jun 2009 09:09:28 +0300
Message-ID: <200906220909.28608.peter.ujfalusi@nokia.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31C@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id DF01C2454A
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 08:10:04 +0200 (CEST)
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E3543F31C@dlee04.ent.ti.com>
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

On Friday 19 June 2009 11:23:41 ext Lopez Cruz, Misael wrote:
> Digital voice loopback (sidetone) requires voice filters
> to be enabled: VTXL, VTXR, VRX.
>
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> ---
>  sound/soc/codecs/twl4030.c |   67
> +++++++++++++++++++++++++------------------- 1 files changed, 38
> insertions(+), 29 deletions(-)
>
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index 4dbb853..780217a 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -332,6 +332,28 @@ static void twl4030_power_down(struct snd_soc_codec
> *codec) twl4030_codec_enable(codec, 0);
>  }
>
> +/* In case of voice mode, the RX1 L(VRX) for downlink and the TX2 L/R
> + * (VTXL, VTXR) for uplink has to be enabled/disabled. */
> +static void twl4030_voice_enable(struct snd_soc_codec *codec, int
> direction, +				int enable)
> +{
> +	u8 reg, mask;
> +
> +	reg =3D twl4030_read_reg_cache(codec, TWL4030_REG_OPTION);
> +
> +	if (direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		mask =3D TWL4030_ARXL1_VRX_EN;
> +	else
> +		mask =3D TWL4030_ATXL2_VTXL_EN | TWL4030_ATXR2_VTXR_EN;
> +
> +	if (enable)
> +		reg |=3D mask;
> +	else
> +		reg &=3D ~mask;
> +
> +	twl4030_write(codec, TWL4030_REG_OPTION, reg);
> +}
> +
>  /* Earpiece */
>  static const struct snd_kcontrol_new twl4030_dapm_earpiece_controls[] =
=3D {
>  	SOC_DAPM_SINGLE("Voice", TWL4030_REG_EAR_CTL, 0, 1, 0),
> @@ -712,7 +734,22 @@ static int bypass_event(struct snd_soc_dapm_widget *=
w,
>
>  	reg =3D twl4030_read_reg_cache(w->codec, m->reg);
>
> -	if (m->reg <=3D TWL4030_REG_ARXR2_APGA_CTL) {
> +	if (m->reg =3D=3D TWL4030_REG_VSTPGA) {
> +		/* Voice digital bypass */
> +		if (reg) {
> +			twl4030->bypass_state |=3D (1 << 5);
> +			twl4030_voice_enable(w->codec,
> +					SNDRV_PCM_STREAM_PLAYBACK, 1);
> +			twl4030_voice_enable(w->codec,
> +					SNDRV_PCM_STREAM_CAPTURE, 1);
> +		} else {
> +			twl4030->bypass_state &=3D ~(1 << 5);
> +			twl4030_voice_enable(w->codec,
> +					SNDRV_PCM_STREAM_PLAYBACK, 0);
> +			twl4030_voice_enable(w->codec,
> +					SNDRV_PCM_STREAM_CAPTURE, 0);
> +		}
> +	} else if (m->reg <=3D TWL4030_REG_ARXR2_APGA_CTL) {

This is not going to work correctly, consider the following scenario (for =

example):
1. You start recording/playback on the voice interface
  This will enables VTXL, VTXR/VRX on start.
2. you enable the Voice bypass
  This will enables (again) VTXL, VTXR and VRX.
3. you disable the Voice bypass
  This will disables VTXL, VTXR/VRX.
4. The ongoing recording/playback will break, since the VTXL, VTXR/VRX has =

been disabled...

I think for the Voice bypass it is feasible (as Mark pointed out) to inject =

DAPM widgets into the Voice playback and capture route (to a place, where t=
he =

playback will enable the VRX, capture will enable the VTXL/VTXR, than make =
the =

bypass connection that it will enable both).


>  		/* Analog bypass */
>  		if (reg & (1 << m->shift))
>  			twl4030->bypass_state |=3D
> @@ -726,12 +763,6 @@ static int bypass_event(struct snd_soc_dapm_widget *=
w,
>  			twl4030->bypass_state |=3D (1 << 4);
>  		else
>  			twl4030->bypass_state &=3D ~(1 << 4);
> -	} else if (m->reg =3D=3D TWL4030_REG_VSTPGA) {
> -		/* Voice digital bypass */
> -		if (reg)
> -			twl4030->bypass_state |=3D (1 << 5);
> -		else
> -			twl4030->bypass_state &=3D ~(1 << 5);
>  	} else {
>  		/* Digital bypass */
>  		if (reg & (0x7 << m->shift))
> @@ -1806,28 +1837,6 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai
> *codec_dai, return 0;
>  }
>
> -/* In case of voice mode, the RX1 L(VRX) for downlink and the TX2 L/R
> - * (VTXL, VTXR) for uplink has to be enabled/disabled. */
> -static void twl4030_voice_enable(struct snd_soc_codec *codec, int
> direction, -				int enable)
> -{
> -	u8 reg, mask;
> -
> -	reg =3D twl4030_read_reg_cache(codec, TWL4030_REG_OPTION);
> -
> -	if (direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> -		mask =3D TWL4030_ARXL1_VRX_EN;
> -	else
> -		mask =3D TWL4030_ATXL2_VTXL_EN | TWL4030_ATXR2_VTXR_EN;
> -
> -	if (enable)
> -		reg |=3D mask;
> -	else
> -		reg &=3D ~mask;
> -
> -	twl4030_write(codec, TWL4030_REG_OPTION, reg);
> -}
> -
>  static int twl4030_voice_startup(struct snd_pcm_substream *substream,
>  		struct snd_soc_dai *dai)
>  {

-- =

P=E9ter
