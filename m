From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] davinci-mcasp: don't overwrite DIT settings
Date: Mon, 04 Mar 2013 10:45:34 +0100
Message-ID: <51346D3E.1050408@gmail.com>
References: <1362389913-4450-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f169.google.com (mail-ea0-f169.google.com
 [209.85.215.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 54099264F24
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 10:45:34 +0100 (CET)
Received: by mail-ea0-f169.google.com with SMTP id d13so747420eaa.14
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2013 01:45:34 -0800 (PST)
In-Reply-To: <1362389913-4450-1-git-send-email-yegorslists@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yegorslists@googlemail.com
Cc: mporter@ti.com, alsa-devel@alsa-project.org, vaibhav.bedia@ti.com
List-Id: alsa-devel@alsa-project.org

Hi Yegor,

On 04.03.2013 10:38, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Channel size settings will be made at the end of
> davinci_mcasp_hw_params() routine and thus overwrite frame
> format settings made for DIT mode. This patch fixes this issue
> by taking op_mode into account. Tested with official PSP 3.2
> kernel and sii9022a HDMI transmitter.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  sound/soc/davinci/davinci-mcasp.c |   27 +++++++++++++++++----------
>  1 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index 90a9b99..de59075 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -643,16 +643,23 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
>  	/* mapping of the XSSZ bit-field as described in the datasheet */
>  	fmt = (word_length >> 1) - 1;
>  
> -	mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
> -					RXSSZ(fmt), RXSSZ(0x0F));
> -	mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
> -					TXSSZ(fmt), TXSSZ(0x0F));
> -	mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, TXROT(rotate),
> -							TXROT(7));
> -	mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, RXROT(rotate),
> -							RXROT(7));
> -	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, mask);
> -	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG, mask);
> +	if (dev->op_mode == DAVINCI_MCASP_DIT_MODE)
> +	{
> +		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, mask);
> +	}
> +	else

The indentation is wrong here. Please see Documentation/CodingStyle, or
let scripts/checkpatch.pl have a look :)

> +	{
> +		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
> +						RXSSZ(fmt), RXSSZ(0x0F));
> +		mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
> +						TXSSZ(fmt), TXSSZ(0x0F));
> +		mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, TXROT(rotate),
> +								TXROT(7));
> +		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, RXROT(rotate),
> +								RXROT(7));
> +		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, mask);

As you do the same thing with the DAVINCI_MCASP_TXMASK_REG here as in
the branch above, you can as well pull it out of the if-block and invert
the condition, right?


Thanks,
Daniel
