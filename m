From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 25/53] ASoC: switch over to use
 snd_soc_register_component() on omap mcbsp
Date: Tue, 19 Mar 2013 13:36:09 +0100
Message-ID: <51485BB9.3090803@ti.com>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <87txo95inq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id B108C265D78
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 13:36:17 +0100 (CET)
In-Reply-To: <87txo95inq.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/18/2013 07:25 AM, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 8d2defd..f51685d 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -586,6 +586,10 @@ static struct snd_soc_dai_driver omap_mcbsp_dai =3D {
>  	.ops =3D &mcbsp_dai_ops,
>  };
>  =

> +static const struct snd_soc_component_driver omap_mcbsp_component =3D {
> +	.name		=3D "omap-mcbsp",
> +};
> +
>  static int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
>  			struct snd_ctl_elem_info *uinfo)
>  {
> @@ -793,7 +797,8 @@ static int asoc_mcbsp_probe(struct platform_device *p=
dev)
>  =

>  	ret =3D omap_mcbsp_init(pdev);
>  	if (!ret)
> -		return snd_soc_register_dai(&pdev->dev, &omap_mcbsp_dai);
> +		return snd_soc_register_component(&pdev->dev, &omap_mcbsp_component,
> +						  &omap_mcbsp_dai, 1);

This certainly breaks OMAP audio without the 'ASoC:
snd_soc_register_component() uses properly snd_soc_register_dai[s]()' patch
sent within the thread. But the comment from Lars stands for the users who
registers 1 dai with snd_soc_register_dais() call.

On the other hand I'm not sure what is the long time aim with the
snd_soc_register_component().
In essence it is just a wrapper for snd_soc_register_dai/s() without any
advantage, except that we register the DAIs with a new api which does not g=
ive
clue what it is doing.

Or is the aim is to eventually merge the snd_soc_codec_driver struct into
snd_soc_component_driver struct and use the same structure for the CPU/DAI =
and
CODEC/DAI registration and share the same code to do it?

I'm sure this had been discussed at some conference but unfortunately I cou=
ld
not attend to them lately.

All in all this is not going to break OMAP, but as of now I don't know the
reasoning why this is a good thing...

>  	return ret;
>  }
> @@ -802,7 +807,7 @@ static int asoc_mcbsp_remove(struct platform_device *=
pdev)
>  {
>  	struct omap_mcbsp *mcbsp =3D platform_get_drvdata(pdev);
>  =

> -	snd_soc_unregister_dai(&pdev->dev);
> +	snd_soc_unregister_component(&pdev->dev);
>  =

>  	if (mcbsp->pdata->ops && mcbsp->pdata->ops->free)
>  		mcbsp->pdata->ops->free(mcbsp->id);
> =



-- =

P=E9ter
