From: Alex Elder <elder@linaro.org>
Subject: Re: [PATCH] slimbus: ngd: QCOM_QMI_HELPERS has to be selected
Date: Mon, 1 Oct 2018 07:10:39 -0500
Message-ID: <02cd4893-ff58-a1ee-bf60-44cc29c21dec@linaro.org>
References: <20181001101116.27281-1-niklas.cassel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001101116.27281-1-niklas.cassel@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <niklas.cassel@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: bjorn.andersson@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10/01/2018 05:11 AM, Niklas Cassel wrote:
> QCOM_QMI_HELPERS is a hidden kconfig, so the proper usage is
> to select it, not depend upon it.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/slimbus/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
> index 9d73ad806698..9cca2c3559f2 100644
> --- a/drivers/slimbus/Kconfig
> +++ b/drivers/slimbus/Kconfig
> @@ -22,8 +22,8 @@ config SLIM_QCOM_CTRL
>  
>  config SLIM_QCOM_NGD_CTRL
>  	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
> -	depends on QCOM_QMI_HELPERS
>  	depends on HAS_IOMEM && DMA_ENGINE
> +	select QCOM_QMI_HELPERS
>  	help
>  	  Select driver if Qualcomm's SLIMbus Satellite Non-Generic Device
>  	  Component is programmed using Linux kernel.
> 
