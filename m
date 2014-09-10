From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: soc-pcm: fix dpcm_path_get error
	handling
Date: Wed, 10 Sep 2014 13:32:53 +0530
Message-ID: <20140910080253.GB1770@intel.com>
References: <1410335852-29957-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A9B8261B31
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 10:25:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1410335852-29957-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 10, 2014 at 03:57:32PM +0800, Qiao Zhou wrote:
> dpcm_path_get may return -ENOMEM when allocating memory for list
> fails. We should not keep processing path or start up dpcm dai in
> this case.
> 
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
> ---
>  sound/soc/soc-compress.c |    7 +++++--
For this:
Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod

>  sound/soc/soc-pcm.c      |    7 +++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index 27c06ac..b969a13 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -101,10 +101,13 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
>  
>  	fe->dpcm[stream].runtime = fe_substream->runtime;
>  
> -	if (dpcm_path_get(fe, stream, &list) <= 0) {
> +	ret = dpcm_path_get(fe, stream, &list);
> +	if (ret < 0) {
> +		mutex_unlock(&fe->card->mutex);
> +		goto fe_err;
> +	} else if (ret == 0)
>  		dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
>  			fe->dai_link->name, stream ? "capture" : "playback");
> -	}
>  
>  	/* calculate valid and active FE <-> BE dpcms */
>  	dpcm_process_paths(fe, stream, &list, 1);
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 731fdb5..d341777 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2352,10 +2352,13 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
>  	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
>  	fe->dpcm[stream].runtime = fe_substream->runtime;
>  
> -	if (dpcm_path_get(fe, stream, &list) <= 0) {
> +	ret = dpcm_path_get(fe, stream, &list);
> +	if (ret < 0) {
> +		mutex_unlock(&fe->card->mutex);
> +		return ret;
> +	} else if (ret == 0)
>  		dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
>  			fe->dai_link->name, stream ? "capture" : "playback");
> -	}
>  
>  	/* calculate valid and active FE <-> BE dpcms */
>  	dpcm_process_paths(fe, stream, &list, 1);
> -- 
> 1.7.0.4
> 

-- 
