From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 2/2] ASoC: compress: Fixup some minor style
 issues
Date: Wed, 24 Jan 2018 15:33:19 +0100
Message-ID: <20180124143319.GA29547@lenoch>
References: <20180124135525.5633-1-ckeepax@opensource.cirrus.com>
 <20180124135525.5633-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 1500B267537
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 15:33:21 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23990474AbeAXOdVRUFHp (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Wed, 24 Jan 2018 15:33:21 +0100
Content-Disposition: inline
In-Reply-To: <20180124135525.5633-2-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, vinod.koul@intel.com, lgirdwood@gmail.com, broonie@kernel.org, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 24, 2018 at 01:55:25PM +0000, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  sound/soc/soc-compress.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index 34834c02dda8..7c1955e9533a 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -262,7 +262,6 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
>  	if (!codec_dai->active)
>  		codec_dai->rate = 0;
>  
> -
>  	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->shutdown)
>  		rtd->dai_link->compr_ops->shutdown(cstream);
>  
> @@ -401,7 +400,6 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
>  	else
>  		stream = SNDRV_PCM_STREAM_CAPTURE;
>  
> -
>  	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
>  
>  	if (cpu_dai->driver->cops && cpu_dai->driver->cops->trigger) {
> @@ -859,7 +857,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>  	rtd->compr = compr;
>  	compr->private_data = rtd;
>  
> -	printk(KERN_INFO "compress asoc: %s <-> %s mapping ok\n", codec_dai->name,
> +	pr_info("compress asoc: %s <-> %s mapping ok\n", codec_dai->name,
>  		cpu_dai->name);

What about:
	dev_info(rtd->card->dev, ...
or better drop this change and make separate patch fixing logging
soc-compress-wide?

>  	return ret;
>  
> -- 
> 2.11.0
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
