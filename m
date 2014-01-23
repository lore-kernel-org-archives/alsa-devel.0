From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] ASoC: simple-card: fix simple card widgets routing
 property name usage
Date: Thu, 23 Jan 2014 11:00:16 +0000
Message-ID: <6982194301ae4ee48be60e23dbd79927@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1389331047-21437-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1389331047-21437-1-git-send-email-Li.Xiubo@freescale.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@linaro.org" <broonie@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I'd like to know the status about this patch.

Thanks very much.

Best Regards,
Xiubo


> Subject: [PATCH] ASoC: simple-card: fix simple card widgets routing property
> name usage
> 
> Fix the usage of simple card widgets routing property, and make it the
> same with simple card routing property name.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  Documentation/devicetree/bindings/sound/simple-card.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt
> b/Documentation/devicetree/bindings/sound/simple-card.txt
> index e9e20ec..19c84df 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.txt
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -43,7 +43,7 @@ Example:
>  sound {
>  	compatible = "simple-audio-card";
>  	simple-audio-card,format = "left_j";
> -	simple-audio-routing =
> +	simple-audio-card,routing =
>  		"MIC_IN", "Mic Jack",
>  		"Headphone Jack", "HP_OUT",
>  		"Ext Spk", "LINE_OUT";
> --
> 1.8.4
> 

