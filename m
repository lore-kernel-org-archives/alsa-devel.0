From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qdsp6: q6asm-dai: clean up a return
Date: Mon, 10 Sep 2018 11:04:40 +0100
Message-ID: <2790e939-5802-a044-cd5d-a36587d70074@linaro.org>
References: <20180910084048.uhgbbsasp25czuud@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FB11267657
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 12:04:42 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so21247483wrw.7
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 03:04:42 -0700 (PDT)
In-Reply-To: <20180910084048.uhgbbsasp25czuud@kili.mountain>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Niklas Cassel <niklas.cassel@linaro.org>
List-Id: alsa-devel@alsa-project.org



On 10/09/18 09:40, Dan Carpenter wrote:
> Smatch complains that if both "psubstream" and "csubstream" are NULL
> then "ret" is uninitialized.  That probably can't happen, but it's
> cleaner to just return zero anyway so let's do that.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index 9db9a2944ef2..c75fab38905d 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -493,7 +493,7 @@ static int q6asm_dai_pcm_new(struct snd_soc_pcm_runtime *rtd)
>   		}
>   	}
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static void q6asm_dai_pcm_free(struct snd_pcm *pcm)
> 
