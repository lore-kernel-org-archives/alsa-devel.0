From: "Omair M. Abdullah" <omair.m.abdullah@intel.com>
Subject: Re: [PATCH RFT] ASoC: lm49453: Fix mask for setting
 mode bit in lm49453_set_dai_fmt()
Date: Mon, 24 Dec 2012 11:08:22 +0530
Message-ID: <20121224053822.GA26412@oma-dev>
References: <1356052760.9177.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BD9A62615F5
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 06:36:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1356052760.9177.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, M R Swami Reddy <MR.Swami.Reddy@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 21, 2012 at 09:19:20AM +0800, Axel Lin wrote:
> The mode variable is either 0 or 1.
> To update mode setting, the mask should be BIT(0) rather than BIT(1).
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi M R Swami,
> I don't have the datasheet. Can you check if this patch is correct?
Yes, according to the datasheet the STEREO mode is BIT(0).

> Thanks,
> Axel
>  sound/soc/codecs/lm49453.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
> index d75257d..c0d203b 100644
> --- a/sound/soc/codecs/lm49453.c
> +++ b/sound/soc/codecs/lm49453.c
> @@ -1218,7 +1218,7 @@ static int lm49453_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
>  	}
>  
>  	snd_soc_update_bits(codec, LM49453_P0_AUDIO_PORT1_BASIC_REG,
> -			    LM49453_AUDIO_PORT1_BASIC_FMT_MASK|BIT(1)|BIT(5),
> +			    LM49453_AUDIO_PORT1_BASIC_FMT_MASK|BIT(0)|BIT(5),
>  			    (aif_val | mode | clk_phase));
>  
>  	snd_soc_write(codec, LM49453_P0_AUDIO_PORT1_RX_MSB_REG, clk_shift);
> -- 
> 1.7.9.5
> 
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
