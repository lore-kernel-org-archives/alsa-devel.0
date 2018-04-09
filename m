From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ASoC: fsl_esai: Fix divisor calculation
 failure at lower ratio
Date: Mon, 9 Apr 2018 23:43:02 +0200
Message-ID: <42010284-6fbd-2d1a-ffe1-8a825478d1d7@denx.de>
References: <1523231855-7854-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 41A66266C1C
 for <alsa-devel@alsa-project.org>; Tue, 10 Apr 2018 01:46:00 +0200 (CEST)
In-Reply-To: <1523231855-7854-1-git-send-email-nicoleotsuka@gmail.com>
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
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 04/09/2018 01:57 AM, Nicolin Chen wrote:
> When the desired ratio is less than 256, the savesub (tolerance)
> in the calculation would become 0. This will then fail the loop-
> search immediately without reporting any errors.
> 
> But if the ratio is smaller enough, there is no need to calculate
> the tolerance because PM divisor alone is enough to get the ratio.
> 
> So a simple fix could be just to set PM directly instead of going
> into the loop-search.
> 
> Reported-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: Marek Vasut <marex@denx.de>

On i.MX6Q with TI PCM1808
Tested-by: Marek Vasut <marex@denx.de>

> ---
>  sound/soc/fsl/fsl_esai.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 40a7004..da8fd98 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -144,6 +144,13 @@ static int fsl_esai_divisor_cal(struct snd_soc_dai *dai, bool tx, u32 ratio,
>  
>  	psr = ratio <= 256 * maxfp ? ESAI_xCCR_xPSR_BYPASS : ESAI_xCCR_xPSR_DIV8;
>  
> +	/* Do not loop-search if PM (1 ~ 256) alone can serve the ratio */
> +	if (ratio <= 256) {
> +		pm = ratio;
> +		fp = 1;
> +		goto out;
> +	}
> +
>  	/* Set the max fluctuation -- 0.1% of the max devisor */
>  	savesub = (psr ? 1 : 8)  * 256 * maxfp / 1000;
>  
> 


-- 
Best regards,
Marek Vasut
