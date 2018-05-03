From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v14 3/8] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into sun4i_codec_mixer_controls
Date: Thu, 3 May 2018 16:46:19 +0200
Message-ID: <20180503144618.oojhvmey44dtg5fa@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-4-dannym@scratchpost.org>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vpntmtxfbglbi65s"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBRWBVTLQKGQEH5X6CAY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20180502210800.1971-4-dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Andrea Bondavalli <andrea.bondavalli74-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--vpntmtxfbglbi65s
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Wed, May 02, 2018 at 11:07:55PM +0200, Danny Milosavljevic wrote:
> Since it's now possible to have a DAPM mixer control with multiple channels,
> use it to cut down the total number of controls.
> 
> Keep "Left Mixer Left DAC Playback Switch" and "Right Mixer Right DAC Playback
> Switch" name & layout the same as before for compatibility.
> 
> Signed-off-by: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 4af286f44a67..b62af407967f 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -715,15 +715,15 @@ static const struct snd_kcontrol_new sun7i_codec_extra_controls[] = {
>  		       sun7i_codec_micin_preamp_gain_scale),
>  };
>  
> -static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
> -	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> -			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
> -};
> -
> -static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
> -	SOC_DAPM_SINGLE("Right DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> -			SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
> -	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
> +	SOC_DAPM_SINGLE("Left Mixer Left DAC Playback Switch",
> +			SUN4I_CODEC_DAC_ACTL, SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
> +			1, 0),
> +	SOC_DAPM_SINGLE("Right Mixer Right DAC Playback Switch",
> +			SUN4I_CODEC_DAC_ACTL, SUN4I_CODEC_DAC_ACTL_RDACRMIXS,
> +			1, 0),
> +	SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
> +			SUN4I_CODEC_DAC_ACTL,
>  			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
>  };
>  
> @@ -759,11 +759,11 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
>  
>  	/* Mixers */
>  	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
> -			   sun4i_codec_left_mixer_controls,
> -			   ARRAY_SIZE(sun4i_codec_left_mixer_controls)),
> +			   sun4i_codec_mixer_controls,
> +			   ARRAY_SIZE(sun4i_codec_mixer_controls)),
>  	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
> -			   sun4i_codec_right_mixer_controls,
> -			   ARRAY_SIZE(sun4i_codec_right_mixer_controls)),
> +			   sun4i_codec_mixer_controls,
> +			   ARRAY_SIZE(sun4i_codec_mixer_controls)),

Doesn't that mean that the controls will be shared between the right
and left mixers now, which wasn't the case before? And also, wouldn't
the controls be called "Left Mixer Left Mixer Left DAC Playback
Switch" (for the first one) now?

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
--vpntmtxfbglbi65s--
