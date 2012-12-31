From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Help with adding mic bias to omap-twl4030 audio
	driver
Date: Mon, 31 Dec 2012 11:33:03 +0100
Message-ID: <50E169DF.2030304@ti.com>
References: <20121218101807.75187e8c@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 083662616F8
 for <alsa-devel@alsa-project.org>; Mon, 31 Dec 2012 11:33:06 +0100 (CET)
In-Reply-To: <20121218101807.75187e8c@notabene.brown>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: NeilBrown <neilb@suse.de>
Cc: Mark@suse.de, alsa-devel@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Neil,

On 12/18/2012 12:18 AM, NeilBrown wrote:
> Hi Peter,
>  I recently discovered your omap-twl4030 driver and thought to use it to
>  replace the hacked-around driver I'm using for the GTA04 mobile phone
>  platform.
> =

>  It works fine for playing sound out the speaker, but the microphone does=
n't
>  work - I think because there is no mechanism to enable the microphone bi=
as.
> =

>  I copied some bits out of the old driver - just enough to make it work.
>  However this probably makes the code specific to my platform.
> =

>  So I'm wondering if you could give me some guidelines on how this "shoul=
d"
>  be done.  Should these tables be passed in with the platform_data (I hav=
en't
>  graduated to device-tree yet)?

I'm going to send a series soon to update the omap-twl4030 machine driver.
This update going to add support for microphones and all other routings as =
well.
With the upcoming series the omap-twl4030 will support zoom2 and sdp3430. I=
'll
CC you with the series so you can take a look if it is going to help with y=
our
board.

> =

>  My 'hacked-up' driver has a few more entries in this table than just tho=
se
>  few, but I wanted to strip it down to what is needed for the main microp=
hone
>  to work.
> =

>  Thanks for any help you can provide,
> NeilBrown
> =

> P.S is there some good reason to use the name
>   struct omap_tw4030_pdata
> rather than
>   struct omap_twl4030_pdata
> =

> (i.e. with the 'l')??
> =

> diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
> index 3b97b879..aa4d866 100644
> --- a/sound/soc/omap/omap-twl4030.c
> +++ b/sound/soc/omap/omap-twl4030.c
> @@ -87,6 +87,32 @@ static struct snd_soc_ops omap_twl4030_ops =3D {
>  	.hw_params =3D omap_twl4030_hw_params,
>  };
>  =

> +static const struct snd_soc_dapm_widget gta04_dapm_widgets[] =3D {
> +	SND_SOC_DAPM_MIC("Internal Mic", NULL),
> +};
> +
> +static const struct snd_soc_dapm_route audio_map[] =3D {
> +	{"MAINMIC", NULL, "Mic Bias 1"},
> +	{"Mic Bias 1", NULL, "Internal Mic"},
> +};
> +
> +static int omap3gta04_init(struct snd_soc_pcm_runtime *runtime)
> +{
> +	int ret;
> +	struct snd_soc_codec *codec =3D runtime->codec;
> +	struct snd_soc_dapm_context *dapm =3D &codec->dapm;
> +
> +	ret =3D snd_soc_dapm_new_controls(dapm, gta04_dapm_widgets,
> +					ARRAY_SIZE(gta04_dapm_widgets));
> +	if (ret < 0)
> +		return ret;
> +
> +	snd_soc_dapm_add_routes(dapm, audio_map,
> +				ARRAY_SIZE(audio_map));
> +
> +	return snd_soc_dapm_sync(dapm);
> +}
> +
>  /* Digital audio interface glue - connects codec <--> CPU */
>  static struct snd_soc_dai_link omap_twl4030_dai_links[] =3D {
>  	{
> @@ -97,6 +123,7 @@ static struct snd_soc_dai_link omap_twl4030_dai_links[=
] =3D {
>  		.platform_name =3D "omap-pcm-audio",
>  		.codec_name =3D "twl4030-codec",
>  		.ops =3D &omap_twl4030_ops,
> +		.init =3D &omap3gta04_init,
>  	},
>  };
>  =

> =



-- =

P=E9ter
