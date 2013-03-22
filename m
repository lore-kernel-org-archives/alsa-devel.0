From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 03/14] ASoC: omap-pcm: No need to wrap
	snd_dmaengine_pcm_close()
Date: Fri, 22 Mar 2013 14:13:12 +0100
Message-ID: <514C58E8.4040605@ti.com>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
 <1363957934-20059-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id C24012665C7
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:13:17 +0100 (CET)
In-Reply-To: <1363957934-20059-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Sebastien Guiriec <s-guiriec@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 03/22/2013 02:12 PM, Lars-Peter Clausen wrote:
> If a PCM driver using the dmaengine PCM helper functions doesn't need to =
do
> anything special in its pcm_close callback, snd_dmaengine_pcm_close can b=
e used
> directly for as the pcm_close callback and there is no need to wrap it in=
 a
> custom function.
> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Sebastien Guiriec <s-guiriec@ti.com>
> ---

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>  sound/soc/omap/omap-pcm.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index c722c2e..c6f477c 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -185,12 +185,6 @@ static int omap_pcm_open(struct snd_pcm_substream *s=
ubstream)
>  				      &dma_data->dma_req);
>  }
>  =

> -static int omap_pcm_close(struct snd_pcm_substream *substream)
> -{
> -	snd_dmaengine_pcm_close(substream);
> -	return 0;
> -}
> -
>  static int omap_pcm_mmap(struct snd_pcm_substream *substream,
>  	struct vm_area_struct *vma)
>  {
> @@ -204,7 +198,7 @@ static int omap_pcm_mmap(struct snd_pcm_substream *su=
bstream,
>  =

>  static struct snd_pcm_ops omap_pcm_ops =3D {
>  	.open		=3D omap_pcm_open,
> -	.close		=3D omap_pcm_close,
> +	.close		=3D snd_dmaengine_pcm_close,
>  	.ioctl		=3D snd_pcm_lib_ioctl,
>  	.hw_params	=3D omap_pcm_hw_params,
>  	.hw_free	=3D omap_pcm_hw_free,
> =



-- =

P=E9ter
