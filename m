From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] ASoC: qcom: Kconfig: fix dependency for sdm845
Date: Mon, 25 Feb 2019 15:37:21 +0100
Message-ID: <82fe83ba-b967-66ee-1299-1cd98072089a@collabora.com>
References: <20190225135405.108052-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225135405.108052-1-cychiang@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>, linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, rdunlap@infradead.org, ncrews@chromium.org, bleung@chromium.org, dgreid@chromium.org, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On 25/2/19 14:54, Cheng-Yi Chiang wrote:
> SND_SOC_CROS_EC_CODEC depends on MFD_CROS_EC.
> Add that dependency to SND_SOC_SDM845 to fix unmet direct dependencies
> warning.
> 
> Fixes: 74c6ecf4194e (ASoC: qcom: Kconfig: select dmic for sdm845)

Reported-by: Randy Dunlap <rdunlap@infradead.org>

> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
Enric

> ---
>  sound/soc/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 8f206cb4fcc0..75ceb04d8bf0 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -98,7 +98,7 @@ config SND_SOC_MSM8996
>  
>  config SND_SOC_SDM845
>  	tristate "SoC Machine driver for SDM845 boards"
> -	depends on QCOM_APR
> +	depends on QCOM_APR && MFD_CROS_EC
>  	select SND_SOC_QDSP6
>  	select SND_SOC_QCOM_COMMON
>  	select SND_SOC_RT5663
> 
