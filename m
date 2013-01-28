From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: soc-compress: Add support for not
 memory mapped DSPs
Date: Sun, 27 Jan 2013 20:04:16 -0800
Message-ID: <20130128040416.GJ26562@intel.com>
References: <1359104400-18527-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BA8A92650BD
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 05:29:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1359104400-18527-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com, vinod.koul@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 25, 2013 at 09:00:00AM +0000, Charles Keepax wrote:
> The ASoC compressed API did not implement the copy callback in its
> compressed ops which is required for DSPs that are not memory mapped.
> This patch adds a second set of compressed ops which does implement the
> copy callback and uses that when copy is defined in the platform
> compressed ops, ie. when the DSP is not memory mapped.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> +static struct snd_compr_ops soc_compr_nomap_ops = {
> +	.open		= soc_compr_open,
> +	.free		= soc_compr_free,
> +	.set_params	= soc_compr_set_params,
> +	.get_params	= soc_compr_get_params,
> +	.trigger	= soc_compr_trigger,
> +	.pointer	= soc_compr_pointer,
> +	.copy		= soc_compr_copy,
> +	.ack		= soc_compr_ack,
> +	.get_caps	= soc_compr_get_caps,
> +	.get_codec_caps = soc_compr_get_codec_caps
> +};
Somehow I dont like the idea of doing one more ops for this.
> +
>  /* create a new compress */
>  int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>  {
>  	struct snd_soc_codec *codec = rtd->codec;
> +	struct snd_soc_platform *platform = rtd->platform;
>  	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>  	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>  	struct snd_compr *compr;
> @@ -335,7 +366,10 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>  		return -ENOMEM;
>  	}
>  
> -	compr->ops = &soc_compr_ops;
> +	if (platform->driver->compr_ops && platform->driver->compr_ops->copy)
> +		compr->ops = &soc_compr_nomap_ops;
> +	else
> +		compr->ops = &soc_compr_ops;
How about:
	compr->ops = &soc_compr_ops;
	if (platform->driver->compr_ops && !platform->driver->compr_ops->copy)
		compr->ops->copy = NULL;

That way you set it to null for those who doent implement this and would called
for drivers who implement this.

--
~Vinod
