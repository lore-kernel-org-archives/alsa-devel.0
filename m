From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: ssm2518: Fix trivial typo in
 checking tx_mask and rx_mask values
Date: Mon, 10 Jun 2013 16:26:45 +0200
Message-ID: <51B5E225.2020003@metafoo.de>
References: <1370874233.25883.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-075.synserver.de (smtp-out-075.synserver.de
 [212.40.185.75])
 by alsa0.perex.cz (Postfix) with ESMTP id F041D261664
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 16:33:18 +0200 (CEST)
In-Reply-To: <1370874233.25883.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/10/2013 04:23 PM, Axel Lin wrote:
> Otherwise, ssm2518_set_tdm_slot() always returns error if slots != 0.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>  sound/soc/codecs/ssm2518.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
> index a76b341..f4883d9 100644
> --- a/sound/soc/codecs/ssm2518.c
> +++ b/sound/soc/codecs/ssm2518.c
> @@ -538,7 +538,7 @@ static int ssm2518_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
>  			SSM2518_REG_SAI_CTRL1, SSM2518_SAI_CTRL1_SAI_MASK,
>  			SSM2518_SAI_CTRL1_SAI_I2S);
>  
> -	if (tx_mask == 0 || tx_mask != 0)
> +	if (tx_mask == 0 || rx_mask != 0)
>  		return -EINVAL;
>  
>  	if (slots == 1) {
