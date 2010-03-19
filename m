From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ALSA: ASoC: move dma_data from snd_soc_dai
	to snd_soc_pcm_stream
Date: Fri, 19 Mar 2010 08:56:40 +0200
Message-ID: <201003190856.40650.peter.ujfalusi@nokia.com>
References: <20100318182211.GH6142@rakim.wolfsonmicro.main>
	<1268940238-6283-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 6246C103881
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 07:57:05 +0100 (CET)
In-Reply-To: <1268940238-6283-1-git-send-email-daniel@caiaq.de>
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
Cc: Michael Hirsch <m.hirsch@raumfeld.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello,

On Thursday 18 March 2010 21:23:58 ext Daniel Mack wrote:
> This fixes a memory corruption when ASoC devices are used in
> full-duplex mode. Specifically for pxa-ssp code, where this pointer
> is dynamically allocated for each direction and destroyed upon each
> stream start.
> =

> All other platforms are fixed blindly, I couldn't even compile-test
> them. Sorry for any breakage I may have caused.

At least the OMAP code should not be affected by the bug, that you have wit=
h the =

pxa-ssp. I think the bug could be also fixed within the pxa code, since the =

whole thing goes down to inconsistent memory management within the pxa code.

Having said that, I do think having separate dma_data for each streams is a =

really good idea.
One thing that I can think of in OMAP case, where this could fix a nasty ra=
ce =

condition is (have never seen it, but it is in theory possible):
Also in duplex case, when the second hw_param gets called after the first =

omap_mcbsp_hw_params, and before the omap_pcm_hw_params for the first strea=
m.
The second omap_mcbsp_hw_params will override the dma_data, thus we would s=
et =

bogus parameters for the first stream.

I do have comment however (down).

For the omap-mcbsp.c and omap-pcm.c changes:
Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

..

> b/sound/soc/atmel/atmel_ssc_dai.c index e588e63..0b59806 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -363,12 +363,12 @@ static int atmel_ssc_hw_params(struct
> snd_pcm_substream *substream, ssc_p->dma_params[dir] =3D dma_params;
> =

>         /*
> -        * The cpu_dai->dma_data field is only used to communicate the
> -        * appropriate DMA parameters to the pcm driver hw_params()
> +        * The snd_soc_pcm_stream->dma_data field is only used to
> communicate +        * the appropriate DMA parameters to the pcm driver
> hw_params() * function.  It should not be used for other purposes
>          * as it is common to all substreams.
>          */
> -       rtd->dai->cpu_dai->dma_data =3D dma_params;
> +       snd_soc_dai_set_dma_data(rtd->dai->cpu_dai, substream, dma_params=
);
> =

>         channels =3D params_channels(params);
> =

> diff --git a/sound/soc/davinci/davinci-i2s.c
> b/sound/soc/davinci/davinci-i2s.c index 6362ca0..4aad7ec 100644
> --- a/sound/soc/davinci/davinci-i2s.c
> +++ b/sound/soc/davinci/davinci-i2s.c
> @@ -585,7 +585,8 @@ static int davinci_i2s_probe(struct platform_device
> *pdev) dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel =3D res->start;
> =

>         davinci_i2s_dai.private_data =3D dev;
> -       davinci_i2s_dai.dma_data =3D dev->dma_params;
> +       davinci_i2s_dai.capture.dma_data =3D dev->dma_params;
> +       davinci_i2s_dai.playback.dma_data =3D dev->dma_params;

Would not be more consistent around the places to actually use the
		snd_soc_dai_set_dma_data(...);
function instead of direct assignment here, and there randomly?

>         ret =3D snd_soc_register_dai(&davinci_i2s_dai);
>         if (ret !=3D 0)
>                 goto err_free_mem;

-- =

P=E9ter
