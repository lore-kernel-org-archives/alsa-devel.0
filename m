From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 2/7] ASoC: atmel_ssc_dai: Fix TCMR settings
 in I2S slave mode
Date: Tue, 27 Feb 2018 18:09:21 +0100
Message-ID: <20180227170921.GE1479@piout.net>
References: <20180130110604.GA18123@lenoch>
 <20180130110810.GC18123@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D54D2676DC
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 18:09:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180130110810.GC18123@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

This one needs a proper git message because it is not obvious what this
is fixing.

Also, this doesn't exactly fix salve mode. Instead it is enabled
synchronous mode. Maybe we need a new DT property to handle sychronous
RX/TX. Probably something like what is done here:

https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/sound/fsl-sai.txt#L39

But our default would be asynchronous.


On 30/01/2018 at 12:08:10 +0100, Ladislav Michl wrote:
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  sound/soc/atmel/atmel_ssc_dai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index a1e2c5682dcd..8e145487cb18 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -647,7 +647,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>  
>  		tcmr =	  SSC_BF(TCMR_PERIOD, 0)
>  			| SSC_BF(TCMR_STTDLY, START_DELAY)
> -			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
> +			| SSC_BF(TCMR_START, SSC_START_TX_RX)
>  			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
>  			| SSC_BF(TCMR_CKO, SSC_CKO_NONE)
>  			| SSC_BF(TCMR_CKS, ssc->clk_from_rk_pin ?
> -- 
> 2.15.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
