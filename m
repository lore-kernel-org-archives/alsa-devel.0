From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH] ASoC: sta32x: shortcut the for loop to get
	ir and mcs
Date: Mon, 15 Aug 2011 14:25:06 +0200
Message-ID: <20110815122506.GA26490@sig21.net>
References: <1313292664.6074.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C58C24604
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 14:25:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313292664.6074.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 14, 2011 at 11:31:04AM +0800, Axel Lin wrote:
> There is exactly one match or no match at all during the for loop iteration,
> thus we can break from the for loop once a match is found.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Looks good.

Acked-by: Johannes Stezenbach <js@sig21.net>


Thanks,
Johannes


> ---
>  sound/soc/codecs/sta32x.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
> index fbd7eb9..3d155f5 100644
> --- a/sound/soc/codecs/sta32x.c
> +++ b/sound/soc/codecs/sta32x.c
> @@ -524,13 +524,17 @@ static int sta32x_hw_params(struct snd_pcm_substream *substream,
>  	rate = params_rate(params);
>  	pr_debug("rate: %u\n", rate);
>  	for (i = 0; i < ARRAY_SIZE(interpolation_ratios); i++)
> -		if (interpolation_ratios[i].fs == rate)
> +		if (interpolation_ratios[i].fs == rate) {
>  			ir = interpolation_ratios[i].ir;
> +			break;
> +		}
>  	if (ir < 0)
>  		return -EINVAL;
>  	for (i = 0; mclk_ratios[ir][i].ratio; i++)
> -		if (mclk_ratios[ir][i].ratio * rate == sta32x->mclk)
> +		if (mclk_ratios[ir][i].ratio * rate == sta32x->mclk) {
>  			mcs = mclk_ratios[ir][i].mcs;
> +			break;
> +		}
>  	if (mcs < 0)
>  		return -EINVAL;
>  
> -- 
> 1.7.4.1
> 
> 
> 
> 
