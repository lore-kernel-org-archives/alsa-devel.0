From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH] ASoC: Remove warnings in ep93xx-i2s.c
Date: Mon, 07 Mar 2011 11:05:51 +1300
Message-ID: <4D74053F.4010003@bluewatersys.com>
References: <1299286652.27359.108.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 85BB224154
	for <alsa-devel@alsa-project.org>; Sun,  6 Mar 2011 23:05:53 +0100 (CET)
In-Reply-To: <1299286652.27359.108.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Sverdlin <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 03/05/2011 01:57 PM, Alexander Sverdlin wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Remove warnings in ep93xx-i2s.c
> 
> Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

> ---
>  sound/soc/ep93xx/ep93xx-i2s.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
> index 3d4c086..042f4e9 100644
> --- a/sound/soc/ep93xx/ep93xx-i2s.c
> +++ b/sound/soc/ep93xx/ep93xx-i2s.c
> @@ -313,10 +313,12 @@ static int ep93xx_i2s_suspend(struct snd_soc_dai *dai)
>  	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
>  
>  	if (!dai->active)
> -		return;
> +		return 0;
>  
>  	ep93xx_i2s_disable(info, SNDRV_PCM_STREAM_PLAYBACK);
>  	ep93xx_i2s_disable(info, SNDRV_PCM_STREAM_CAPTURE);
> +
> +	return 0;
>  }
>  
>  static int ep93xx_i2s_resume(struct snd_soc_dai *dai)
> @@ -324,10 +326,12 @@ static int ep93xx_i2s_resume(struct snd_soc_dai *dai)
>  	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
>  
>  	if (!dai->active)
> -		return;
> +		return 0;
>  
>  	ep93xx_i2s_enable(info, SNDRV_PCM_STREAM_PLAYBACK);
>  	ep93xx_i2s_enable(info, SNDRV_PCM_STREAM_CAPTURE);
> +
> +	return 0;
>  }
>  #else
>  #define ep93xx_i2s_suspend	NULL
> 
> 


-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
