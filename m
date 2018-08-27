From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/1] axi-i2s: set period size register
Date: Mon, 27 Aug 2018 14:27:45 +0200
Message-ID: <b87937b6-da7c-76d7-5dd2-24909e648671@metafoo.de>
References: <20180824160430.10222-1-luca@lucaceresoli.net>
 <20180824160430.10222-2-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B64B2676BF
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 14:27:48 +0200 (CEST)
In-Reply-To: <20180824160430.10222-2-luca@lucaceresoli.net>
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
To: Luca Ceresoli <luca@lucaceresoli.net>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/24/2018 06:04 PM, Luca Ceresoli wrote:
> The default value of the PERIOD_LEN register is 0 and results in
> axi-i2s keeping TLAST always asserted in its AXI Stream output.
> 
> When the AXI Stream is sent to a Xilinx AXI-DMA, this results in the
> DMA generating an interrupt flood and ALSA produce a corrupted
> recording. This is because AXI-DMA raises an interrupt whenever TLAST
> is active.
> 
> Fix by setting the PERIOD_LEN register as soon as the period is
> known. This way TLAST is emitted once per period, and the DMA raises
> interrupts correctly.

The patch looks OK. But I'd prefer not to merge it if possible.

We've done some early experiments with the Xilinx AXI-DMA, but it turned out
to be to unreliable and we've abandoned support for it. One of the more
critical issues was that you can't abort a DMA transfer. That means when
audio capture is stopped the DMA will halt, but not complete the current
transfer. Then when the next audio capture start the DMA will continue with
the previous transfer. The observed effect of this was that the system would
just crash randomly (Presumably due to memory corruption).

Have you considered using the ADI AXI-DMAC? That should work just fine.

> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  sound/soc/adi/axi-i2s.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/adi/axi-i2s.c b/sound/soc/adi/axi-i2s.c
> index 4c23381727a1..af581a313a40 100644
> --- a/sound/soc/adi/axi-i2s.c
> +++ b/sound/soc/adi/axi-i2s.c
> @@ -24,6 +24,7 @@
>  #define AXI_I2S_REG_CTRL	0x04
>  #define AXI_I2S_REG_CLK_CTRL	0x08
>  #define AXI_I2S_REG_STATUS	0x10
> +#define AXI_I2S_REG_PERIOD_LEN	0x18
>  
>  #define AXI_I2S_REG_RX_FIFO	0x28
>  #define AXI_I2S_REG_TX_FIFO	0x2C
> @@ -101,6 +102,17 @@ static int axi_i2s_hw_params(struct snd_pcm_substream *substream,
>  	return 0;
>  }
>  
> +static int axi_i2s_prepare(struct snd_pcm_substream *substream,
> +			   struct snd_soc_dai *dai)
> +{
> +	struct axi_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +	unsigned int period_bytes = snd_pcm_lib_period_bytes(substream);
> +
> +	/* adi_i2s counts 32-bit words, thus divide bytes by 4 */
> +	return regmap_write(i2s->regmap, AXI_I2S_REG_PERIOD_LEN,
> +			    (period_bytes / 4) - 1);
> +}
> +
>  static int axi_i2s_startup(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *dai)
>  {
> @@ -147,6 +159,7 @@ static const struct snd_soc_dai_ops axi_i2s_dai_ops = {
>  	.shutdown = axi_i2s_shutdown,
>  	.trigger = axi_i2s_trigger,
>  	.hw_params = axi_i2s_hw_params,
> +	.prepare = axi_i2s_prepare,
>  };
>  
>  static struct snd_soc_dai_driver axi_i2s_dai = {
> @@ -175,7 +188,7 @@ static const struct regmap_config axi_i2s_regmap_config = {
>  	.reg_bits = 32,
>  	.reg_stride = 4,
>  	.val_bits = 32,
> -	.max_register = AXI_I2S_REG_STATUS,
> +	.max_register = AXI_I2S_REG_PERIOD_LEN,
>  };
>  
>  static int axi_i2s_probe(struct platform_device *pdev)
> 
