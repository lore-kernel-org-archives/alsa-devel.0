From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v4 2/2] ALSA: ASoC: davinci-mcasp: don't
 overwrite DIT settings
Date: Mon, 04 Mar 2013 11:43:48 +0100
Message-ID: <51347AE4.9040403@gmail.com>
References: <1362393266-5127-1-git-send-email-yegorslists@googlemail.com>
 <1362393266-5127-2-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 16BC8265062
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 11:44:04 +0100 (CET)
Received: by mail-bk0-f41.google.com with SMTP id q16so2297288bkw.28
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2013 02:44:03 -0800 (PST)
In-Reply-To: <1362393266-5127-2-git-send-email-yegorslists@googlemail.com>
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

On 04.03.2013 11:34, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Channel size settings will be made at the end of
> davinci_mcasp_hw_params() routine and thus overwrite frame
> format settings made for DIT mode. This patch fixes this issue
> by taking op_mode into account. Tested with official PSP 3.2
> kernel and sii9022a HDMI transmitter.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

For both, wrt a survived regression test :)

Tested-by: Daniel Mack <zonque@gmail.com>



Thanks,
Daniel


> ---
> v4: change subjuct to include "ALSA: ASoC: "
> v3: don't set mask in davinci_hw_dit_param()
> v2: fix checkpatch.pl warnings
> 
>  sound/soc/davinci/davinci-mcasp.c |   25 +++++++++++++------------
>  1 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index 90a9b99..dcd56f2 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -643,16 +643,20 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
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
> +	if (dev->op_mode != DAVINCI_MCASP_DIT_MODE) {
> +		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
> +				RXSSZ(fmt), RXSSZ(0x0F));
> +		mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
> +				TXSSZ(fmt), TXSSZ(0x0F));
> +		mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
> +				TXROT(rotate), TXROT(7));
> +		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
> +				RXROT(rotate), RXROT(7));
> +		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG,
> +				mask);
> +	}
> +
>  	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, mask);
> -	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG, mask);
>  
>  	return 0;
>  }
> @@ -772,9 +776,6 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
>  /* S/PDIF */
>  static void davinci_hw_dit_param(struct davinci_audio_dev *dev)
>  {
> -	/* TXMASK for 24 bits */
> -	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, 0x00FFFFFF);
> -
>  	/* Set the TX format : 24 bit right rotation, 32 bit slot, Pad 0
>  	   and LSB first */
>  	mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
> 
