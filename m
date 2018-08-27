From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: sigmadsp: safeload should not
 have lower byte limit
Date: Mon, 27 Aug 2018 14:29:10 +0200
Message-ID: <64a0349d-2235-98eb-162e-858947b3f625@metafoo.de>
References: <20180823082620.21129-1-dannys@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9844E2676BF
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 14:29:12 +0200 (CEST)
In-Reply-To: <20180823082620.21129-1-dannys@axis.com>
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
To: Danny Smith <danny.smith@axis.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Robert Rosengren <robertr@axis.com>, Danny Smith <dannys@axis.com>
List-Id: alsa-devel@alsa-project.org

On 08/23/2018 10:26 AM, Danny Smith wrote:
> Fixed range in safeload conditional to allow safeload to up to 20 bytes,
> without a lower limit.
> 
> Signed-off-by: Danny Smith <dannys@axis.com>

I'd have liked the commit message to be a bit more verbose about the why.
But either way:

Acked-by: Lars-Peter Clausen <lars@metafoo.de>


> ---
>  sound/soc/codecs/sigmadsp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
> index d53680ac78e4..6df158669420 100644
> --- a/sound/soc/codecs/sigmadsp.c
> +++ b/sound/soc/codecs/sigmadsp.c
> @@ -117,8 +117,7 @@ static int sigmadsp_ctrl_write(struct sigmadsp *sigmadsp,
>  	struct sigmadsp_control *ctrl, void *data)
>  {
>  	/* safeload loads up to 20 bytes in a atomic operation */
> -	if (ctrl->num_bytes > 4 && ctrl->num_bytes <= 20 && sigmadsp->ops &&
> -	    sigmadsp->ops->safeload)
> +	if (ctrl->num_bytes <= 20 && sigmadsp->ops && sigmadsp->ops->safeload)
>  		return sigmadsp->ops->safeload(sigmadsp, ctrl->addr, data,
>  			ctrl->num_bytes);
>  	else
> 
