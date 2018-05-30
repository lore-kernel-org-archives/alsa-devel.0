From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH] ASoC: fix 0-day warnings with
	snd_soc_new_compress()
Date: Wed, 30 May 2018 08:46:56 +0530
Message-ID: <20180530031656.GL5666@vkoul-mobl>
References: <20180529233002.23656-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id F251B26772F
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 05:17:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180529233002.23656-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 29-05-18, 18:30, Pierre-Louis Bossart wrote:
> All conditionally-defined routines in include/sound/soc.h expose a
> static inline fallback to avoid 0-day warnings and compilation issues,
> except snd_soc_new_compress().

Hey Pierre,

Thanks for the fix, but typically the title should not mention things like
reporter. It should describe the change, so something like "Add
snd_soc_new_compress() wrapper when CONFIG_SND_SOC_COMPRESS is not defined"

Right now patch title is not describing the change

> Fixes: 5db6aab6f36f ('ASoC: topology: Add support for compressed PCMs')
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  include/sound/soc.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 600a7ebd10c0..1378dcd2128a 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -462,6 +462,11 @@ struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
>  int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
>  #ifdef CONFIG_SND_SOC_COMPRESS
>  int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num);
> +#else
> +static inline int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
> +{
> +	return 0;
> +}
>  #endif
>  
>  void snd_soc_disconnect_sync(struct device *dev);
> -- 
> 2.14.1

-- 
~Vinod
