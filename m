From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/2] ASoC: omap: Stop DMA re enabling in
	self linkage mode
Date: Tue, 7 Dec 2010 11:17:26 +0200
Message-ID: <201012071117.26440.peter.ujfalusi@nokia.com>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E81@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B744103835
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 10:17:27 +0100 (CET)
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4C52E81@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "ext Olaya, Margarita" <magi.olaya@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 07 December 2010 00:34:47 ext Olaya, Margarita wrote:
> From: Hari Nagalla <hnagalla@ti.com>
> =

> While using self linking, there is a chance that the DMA
> has re-enabled the channel just after disabling it.
> =

> This patch stops the OMAP4 DMA re-enabling after stoping the
> DMA channel.

I have not seen this happening on OMAP2/3, or at least I'm not aware of it.
Is this problem OMAP4 only?
Do you know if this happens on playback, capture or in both direction?
Is it worth to do this workaround only on OMAP4?

> =

> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> ---
>  sound/soc/omap/omap-pcm.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index 6a21447..afe91ad 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -234,6 +234,13 @@ static int omap_pcm_trigger(struct snd_pcm_substream
> *substream, int cmd) case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  		prtd->period_index =3D -1;
>  		omap_stop_dma(prtd->dma_ch);
> +		/*
> +		 * Since we are using self linking, there is a
> +		 * chance that the DMA as re-enabled the channel
> +		 * just after disabling it.
> +		 */
> +		while (omap_get_dma_active_status(prtd->dma_ch))
> +			omap_stop_dma(prtd->dma_ch);
>  		break;
>  	default:
>  		ret =3D -EINVAL;

-- =

P=E9ter
