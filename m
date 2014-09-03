From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC: Add snd_soc_component_{get,
	set}_drvdata()
Date: Wed, 3 Sep 2014 17:52:58 +0530
Message-ID: <20140903122258.GB1610@intel.com>
References: <1408532929-26978-1-git-send-email-lars@metafoo.de>
 <1408532929-26978-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BE3642655D5
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 14:43:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1408532929-26978-2-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 20, 2014 at 01:08:46PM +0200, Lars-Peter Clausen wrote:
> Add Add snd_soc_component_{get,set}_drvdata() similar to
> snd_soc_codec_{get,set}_drvdata() and snd_soc_platform_{get,set}_drvdata().
> Also update them to use the new functions internally.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod

> ---
>  include/sound/soc.h | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index e43fbb6..e6440d8 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -1299,26 +1299,37 @@ static inline void *snd_soc_card_get_drvdata(struct snd_soc_card *card)
>  	return card->drvdata;
>  }
>  
> +static inline void snd_soc_component_set_drvdata(struct snd_soc_component *c,
> +		void *data)
> +{
> +	dev_set_drvdata(c->dev, data);
> +}
> +
> +static inline void *snd_soc_component_get_drvdata(struct snd_soc_component *c)
> +{
> +	return dev_get_drvdata(c->dev);
> +}
> +
>  static inline void snd_soc_codec_set_drvdata(struct snd_soc_codec *codec,
>  		void *data)
>  {
> -	dev_set_drvdata(codec->dev, data);
> +	snd_soc_component_set_drvdata(&codec->component, data);
>  }
>  
>  static inline void *snd_soc_codec_get_drvdata(struct snd_soc_codec *codec)
>  {
> -	return dev_get_drvdata(codec->dev);
> +	return snd_soc_component_get_drvdata(&codec->component);
>  }
>  
>  static inline void snd_soc_platform_set_drvdata(struct snd_soc_platform *platform,
>  		void *data)
>  {
> -	dev_set_drvdata(platform->dev, data);
> +	snd_soc_component_set_drvdata(&platform->component, data);
>  }
>  
>  static inline void *snd_soc_platform_get_drvdata(struct snd_soc_platform *platform)
>  {
> -	return dev_get_drvdata(platform->dev);
> +	return snd_soc_component_get_drvdata(&platform->component);
>  }
>  
>  static inline void snd_soc_pcm_set_drvdata(struct snd_soc_pcm_runtime *rtd,
> -- 
> 1.8.0
> 

-- 
