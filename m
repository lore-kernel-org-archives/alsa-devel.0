From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/3] ASoC: core: Allow CODECs to set
 ignore_pmdown_time in the driver struct
Date: Thu, 09 Feb 2012 08:49:04 +0000
Message-ID: <1328777344.3951.6.camel@odin>
References: <1328726238-556-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FEB8104000
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2012 09:49:22 +0100 (CET)
Received: by mail-we0-f175.google.com with SMTP id c1so1126331wer.20
	for <alsa-devel@alsa-project.org>; Thu, 09 Feb 2012 00:49:06 -0800 (PST)
In-Reply-To: <1328726238-556-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-08 at 18:37 +0000, Mark Brown wrote:
> This is usually not a use case dependant flag anyway.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/sound/soc.h  |    2 ++
>  sound/soc/soc-core.c |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index ecd5d72..d1e7a6a 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -657,6 +657,8 @@ struct snd_soc_codec_driver {
>  	/* codec stream completion event */
>  	int (*stream_event)(struct snd_soc_dapm_context *dapm, int event);
>  
> +	bool ignore_pmdown_time;  /* Doesn't benefit from pmdown delay */
> +
>  	/* probe ordering - for components with runtime dependencies */
>  	int probe_order;
>  	int remove_order;
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 3a3b487..0b9974f 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -3380,6 +3380,7 @@ int snd_soc_register_codec(struct device *dev,
>  	codec->volatile_register = codec_drv->volatile_register;
>  	codec->readable_register = codec_drv->readable_register;
>  	codec->writable_register = codec_drv->writable_register;
> +	codec->ignore_pmdown_time = codec_drv->ignore_pmdown_time;
>  	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
>  	codec->dapm.dev = dev;
>  	codec->dapm.codec = codec;

All

Acked-by: Liam Girdwood <lrg@ti.com>
