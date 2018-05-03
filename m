From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v14 1/8] ASoC: sun4i-codec: Add MIC2
 Pre-Amplifier, Mic2, Mic Playback Volume
Date: Thu, 3 May 2018 16:30:15 +0200
Message-ID: <20180503143015.txtwdbt5icpeq4u5@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-2-dannym@scratchpost.org>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6kf2zepmquszwjys"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB6FZVTLQKGQE25Q2BTI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20180502210800.1971-2-dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Andrea Bondavalli <andrea.bondavalli74-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--6kf2zepmquszwjys
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Wed, May 02, 2018 at 11:07:53PM +0200, Danny Milosavljevic wrote:
> Add MIC2 Pre-Amplifier, Mic2 input and Mic Playback Volume for Allwinner A10
> and Allwinner A20.

That's a general remark for all your commits here, but you should have
more context in your commit logs, for example to define what is the
usual use case for these microphones, if the playback volume applies
to all mic at once, or just a fraction of them, etc.

> Signed-off-by: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 9a3cb7704810..060a40b45ab0 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -64,6 +64,7 @@
>  #define SUN4I_CODEC_DAC_ACTL_DACAENR			(31)
>  #define SUN4I_CODEC_DAC_ACTL_DACAENL			(30)
>  #define SUN4I_CODEC_DAC_ACTL_MIXEN			(29)
> +#define SUN4I_CODEC_DAC_ACTL_MICG			(20)
>  #define SUN4I_CODEC_DAC_ACTL_LDACLMIXS			(15)
>  #define SUN4I_CODEC_DAC_ACTL_RDACRMIXS			(14)
>  #define SUN4I_CODEC_DAC_ACTL_LDACRMIXS			(13)
> @@ -673,11 +674,16 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
>  			SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);
>  
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
> +static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale, -450, 150,
> +			    0);
>  
>  static const struct snd_kcontrol_new sun4i_codec_controls[] = {
>  	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
>  		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
>  		       sun4i_codec_pa_volume_scale),
> +	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
> +		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
> +		       sun4i_codec_micin_loopback_gain_scale),

This should probably go in a separate patch, it isn't directly related
to the rest of the patch.

Looks good otherwise, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
--6kf2zepmquszwjys--
