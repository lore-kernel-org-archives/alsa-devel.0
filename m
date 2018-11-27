From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH 4/4] ASoC: qcom: Kconfig: select config for
 codec
Date: Tue, 27 Nov 2018 09:17:26 +0000
Message-ID: <4a59167e-1219-dc0a-61e8-4c1fde0e4c0c@linaro.org>
References: <20181124110948.209019-1-cychiang@chromium.org>
 <20181124110948.209019-4-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181124110948.209019-4-cychiang@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>, linux-kernel@vger.kernel.org
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, tzungbi@chromium.org, Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org



On 24/11/18 11:09, Cheng-Yi Chiang wrote:
> Select SND_SOC_RT5663 and SND_SOC_MAX98927 for SND_SOC_SDM845.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 2a4c912d1e484..3528c4279cbae 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -100,6 +100,8 @@ config SND_SOC_SDM845
>   	depends on QCOM_APR
>   	select SND_SOC_QDSP6
>   	select SND_SOC_QCOM_COMMON
> +	select SND_SOC_RT5663
> +	select SND_SOC_MAX98927
>   	help
>   	  To add support for audio on Qualcomm Technologies Inc.
>   	  SDM845 SoC-based systems.
> 
