From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 07/14] ASoC: ux500_pcm: No need to use
	snd_dmaengine_pcm_set_data()
Date: Fri, 22 Mar 2013 16:01:04 +0100
Message-ID: <514C7230.5070408@stericsson.com>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
 <1363957934-20059-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog119.obsmtp.com (eu1sys200aog119.obsmtp.com
 [207.126.144.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C5632651A1
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 16:01:14 +0100 (CET)
In-Reply-To: <1363957934-20059-8-git-send-email-lars@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Acked.

Regards,
Ola

On 03/22/2013 02:12 PM, Lars-Peter Clausen wrote:

> The driver never uses snd_dmaengine_pcm_get_data(), so there is no need to use
> snd_dmaengine_pcm_set_data().
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Ola Lilja <ola.o.lilja@stericsson.com>
> ---
>  sound/soc/ux500/ux500_pcm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
> index d000ba2..1ab36fa 100644
> --- a/sound/soc/ux500/ux500_pcm.c
> +++ b/sound/soc/ux500/ux500_pcm.c
> @@ -155,8 +155,6 @@ static int ux500_pcm_open(struct snd_pcm_substream *substream)
>  		return ret;
>  	}
>  
> -	snd_dmaengine_pcm_set_data(substream, dma_cfg);
> -
>  	return 0;
>  }
>  
