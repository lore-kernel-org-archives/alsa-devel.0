From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ASoC: pcm186x: Fix device reset-registers
	trigger value
Date: Thu, 15 Nov 2018 11:08:33 -0600
Message-ID: <a7db24e0-94fe-7875-c4a6-84d739ac185b@ti.com>
References: <20181115170131.1839-1-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 by alsa0.perex.cz (Postfix) with ESMTP id BF484267AFC
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 18:08:36 +0100 (CET)
In-Reply-To: <20181115170131.1839-1-dannenberg@ti.com>
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
To: Andreas Dannenberg <dannenberg@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stephane Le Provost <stephane.leprovost@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On 11/15/18 11:01 AM, Andreas Dannenberg wrote:
> According to the current device datasheet (TI Lit # SLAS831D, revised
> March 2018) the value written to the device's PAGE register to trigger
> a complete register reset should be 0xfe, not 0xff. So go ahead and
> update to the correct value.
> 
> Reported-by: Stephane Le Provost <stephane.leprovost@mediatek.com>
> Tested-by: Stephane Le Provost <stephane.leprovost@mediatek.com>
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> ---


Does 0xff not reset the device? If so then this is not just a typo but a
bug and this patch should have a fixes tag. Either way:

Acked-by: Andrew F. Davis <afd@ti.com>


>  sound/soc/codecs/pcm186x.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/pcm186x.h b/sound/soc/codecs/pcm186x.h
> index 2c6ba55bf394..bb3f0c42a1cd 100644
> --- a/sound/soc/codecs/pcm186x.h
> +++ b/sound/soc/codecs/pcm186x.h
> @@ -139,7 +139,7 @@ enum pcm186x_type {
>  #define PCM186X_MAX_REGISTER		PCM186X_CURR_TRIM_CTRL
>  
>  /* PCM186X_PAGE */
> -#define PCM186X_RESET			0xff
> +#define PCM186X_RESET			0xfe
>  
>  /* PCM186X_ADCX_INPUT_SEL_X */
>  #define PCM186X_ADC_INPUT_SEL_POL	BIT(7)
> 
