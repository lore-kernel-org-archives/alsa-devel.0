From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] ALSA: compress: Pass id string to
 snd_compress_new
Date: Wed, 25 Nov 2015 08:51:20 -0600
Message-ID: <5655CAE8.80705@linux.intel.com>
References: <1448444918-29760-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1448444918-29760-3-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 02F0E260702
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 15:51:22 +0100 (CET)
In-Reply-To: <1448444918-29760-3-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


> @@ -689,7 +689,13 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>   		compr->ops->copy = soc_compr_copy;
>
>   	mutex_init(&compr->lock);
> -	ret = snd_compress_new(rtd->card->snd_card, num, direction, compr);
> +
> +	snprintf(new_name, sizeof(new_name), "%s %s-%d",
> +		 rtd->dai_link->stream_name,
> +		 rtd->codec_dai->name, num);

Adding an ID with a human-readable name sounds good.
Wondering though if the codec_dai name is relevant for compressed 
streams? In all the configurations we have with DPCM the name is 
snd-soc-dummy-dai, there is no connection to the codec proper. 
stream_name and id should be good enough, no?
