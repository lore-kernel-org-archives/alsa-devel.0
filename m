From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2 4/4] dts: atmel: at91sam9g20: switch ssc compatible
 string
Date: Tue, 2 Sep 2014 11:14:31 +0200
Message-ID: <54058A77.3090603@atmel.com>
References: <1402481682-9811-1-git-send-email-voice.shen@atmel.com> <1402481682-9811-5-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1402481682-9811-5-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>, broonie@kernel.org
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/06/2014 12:14, Bo Shen :
> As the SSC integrate in at91sam9g20 support frame sync length
> extension, so switch compatible string to support this feature.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Now that the audio part is included, I take the DT for at91-3.18-dt3:
thanks!

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
> Changes in v2:
>   - New
> 
>  arch/arm/boot/dts/at91sam9g20.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
> index b8e7946..dcd39fe 100644
> --- a/arch/arm/boot/dts/at91sam9g20.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
> @@ -22,6 +22,10 @@
>  				compatible = "atmel,at91sam9g20-i2c";
>  			};
>  
> +			ssc0: ssc@fffbc000 {
> +				compatible = "atmel,at91sam9rl-ssc";
> +			};
> +
>  			adc0: adc@fffe0000 {
>  				atmel,adc-startup-time = <40>;
>  			};
> 


-- 
Nicolas Ferre
