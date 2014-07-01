From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
 multicodec
Date: Tue, 1 Jul 2014 22:11:34 +0530
Message-ID: <20140701164134.GH2296@intel.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id D737E265744
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 18:42:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 01, 2014 at 09:47:59AM +0200, Benoit Cousson wrote:
> Add multicodec support in soc-compress.c
> 
> @@ -294,13 +299,19 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
>  			goto out;
>  	}
>  
> -	switch (cmd) {
> -	case SNDRV_PCM_TRIGGER_START:
> -		snd_soc_dai_digital_mute(codec_dai, 0, cstream->direction);
> -		break;
> -	case SNDRV_PCM_TRIGGER_STOP:
> -		snd_soc_dai_digital_mute(codec_dai, 1, cstream->direction);
> -		break;
> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
> +
> +		switch (cmd) {
> +		case SNDRV_PCM_TRIGGER_START:
> +			snd_soc_dai_digital_mute(codec_dai, 0,
> +						 cstream->direction);
> +			break;
> +		case SNDRV_PCM_TRIGGER_STOP:
> +			snd_soc_dai_digital_mute(codec_dai, 1,
> +						 cstream->direction);
Wouldnt it make sense to fix snd_soc_dai_digital_mute() for multi-codecs. Did
you do same thing for pcm?

> +			break;
> +		}
>  	}
>  
>  out:
> @@ -622,23 +633,33 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>  {
>  	struct snd_soc_codec *codec = rtd->codec;
>  	struct snd_soc_platform *platform = rtd->platform;
> -	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>  	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>  	struct snd_compr *compr;
>  	struct snd_pcm *be_pcm;
>  	char new_name[64];
> -	int ret = 0, direction = 0;
> -
> -	/* check client and interface hw capabilities */
> -	snprintf(new_name, sizeof(new_name), "%s %s-%d",
> -			rtd->dai_link->stream_name, codec_dai->name, num);
> -
> -	if (codec_dai->driver->playback.channels_min)
> -		direction = SND_COMPRESS_PLAYBACK;
> -	else if (codec_dai->driver->capture.channels_min)
> -		direction = SND_COMPRESS_CAPTURE;
> -	else
> -		return -EINVAL;
> +	int i, ret = 0, direction = -1;
> +
> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
> +		/* check client and interface hw capabilities */
> +		snprintf(new_name, sizeof(new_name), "%s %s-%d",
> +			 rtd->dai_link->stream_name, codec_dai->name, num);
> +
> +		if (direction < 0) {
> +			if (codec_dai->driver->playback.channels_min)
> +				direction = SND_COMPRESS_PLAYBACK;
> +			else if (codec_dai->driver->capture.channels_min)
> +				direction = SND_COMPRESS_CAPTURE;
direction wont change with multiple codecs, so this loop makes no sense here.
For simplcity perhaps we can use cpu_dai?
> +			else
> +				return -EINVAL;
> +		} else {
when will this get executed? You have initialized direction to -1 and if case is
always true. I think compiler will simply remove the below sinppet.
> +			if ((codec_dai->driver->playback.channels_min &&
> +					direction != SND_COMPRESS_PLAYBACK) ||
> +			    (codec_dai->driver->capture.channels_min &&
> +					direction != SND_COMPRESS_CAPTURE))
and what exactly are we trying to check here?
> +				return -EINVAL;
> +		}
> +	}
>  
>  	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
>  	if (compr == NULL) {
> @@ -692,8 +713,11 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>  	rtd->compr = compr;
>  	compr->private_data = rtd;
>  
> -	printk(KERN_INFO "compress asoc: %s <-> %s mapping ok\n", codec_dai->name,
> -		cpu_dai->name);
> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
> +		printk(KERN_INFO "compress asoc: %s <-> %s mapping ok\n",
> +		       codec_dai->name, cpu_dai->name);
wrong again. You are not creating multiple links with multi-codec. Link is still
single.

-- 
~Vinod
