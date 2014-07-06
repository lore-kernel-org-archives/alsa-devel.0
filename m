From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v5 2/5] ASoC: pcm: Add support for DAI
	multicodec
Date: Sun, 06 Jul 2014 16:18:24 +0200
Message-ID: <53B95AB0.8070307@metafoo.de>
References: <1404490075-24997-1-git-send-email-bcousson@baylibre.com>
 <1404490075-24997-3-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-155.synserver.de (smtp-out-155.synserver.de
 [212.40.185.155])
 by alsa0.perex.cz (Postfix) with ESMTP id 26D21264F2D
 for <alsa-devel@alsa-project.org>; Sun,  6 Jul 2014 16:18:26 +0200 (CEST)
In-Reply-To: <1404490075-24997-3-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: Fabien Parent <fparent@baylibre.com>, misael.lopez@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/04/2014 06:07 PM, Benoit Cousson wrote:
[...]
>    */
>   bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd)
>   {
> +	int i;
> +	bool ignore = true;
> +
>   	if (!rtd->pmdown_time || rtd->dai_link->ignore_pmdown_time)
>   		return true;
>
> -	return rtd->cpu_dai->component->ignore_pmdown_time &&
> -			rtd->codec_dai->component->ignore_pmdown_time;
> +	for (i = 0; (i < rtd->num_codecs) && !ignore; i++)

As you said last time this should be '&& ignore'. Or maybe just drop the 
check altogether.

> +		ignore &= rtd->codec_dais[i]->component->ignore_pmdown_time;
> +
> +	return rtd->cpu_dai->component->ignore_pmdown_time && ignore;
>   }
>
