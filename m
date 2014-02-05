From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ASoC: cs4271: Remove outdated comment
Date: Wed, 05 Feb 2014 11:31:24 +0100
Message-ID: <52F212FC.3020200@zonque.org>
References: <1391521702-15594-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id A0A3A2625ED
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 11:31:28 +0100 (CET)
In-Reply-To: <1391521702-15594-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/04/2014 02:48 PM, Lars-Peter Clausen wrote:
> Commit 1b1861ead ("ASoC: cs4271: convert to direct regmap API usage") removed
> the bus_type field from the cs4271_private struct, but left the comment that
> described the field in there. This patch removes the comment.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Jup, I seem to have forgotten to remove this comment.

Acked-by: Daniel Mack <daniel@zonque.org>


Thanks,
Daniel


> ---
>  sound/soc/codecs/cs4271.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
> index ce05fd9..f7bbe6f 100644
> --- a/sound/soc/codecs/cs4271.c
> +++ b/sound/soc/codecs/cs4271.c
> @@ -159,7 +159,6 @@ static bool cs4271_volatile_reg(struct device *dev, unsigned int reg)
>  }
>  
>  struct cs4271_private {
> -	/* SND_SOC_I2C or SND_SOC_SPI */
>  	unsigned int			mclk;
>  	bool				master;
>  	bool				deemph;
> 
