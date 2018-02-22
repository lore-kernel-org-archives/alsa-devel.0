From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v3 24/25] ASoC: qcom: apq8096: Add db820c
 machine driver
Date: Thu, 22 Feb 2018 16:30:59 +0530
Message-ID: <2d646729-9bb2-86e5-22f5-19aaf009c0cc@codeaurora.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-25-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 95FE82676AB
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 12:01:10 +0100 (CET)
In-Reply-To: <20180213165837.1620-25-srinivas.kandagatla@linaro.org>
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
To: srinivas.kandagatla@linaro.org, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, lgirdwood@gmail.com, plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, david.brown@linaro.org, robh+dt@kernel.org, spatakok@qti.qualcomm.com, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 2/13/2018 10:28 PM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support to DB820c machine driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/Kconfig   |   8 +++
>   sound/soc/qcom/apq8096.c | 173 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 181 insertions(+)
>   create mode 100644 sound/soc/qcom/apq8096.c
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 8c2d65e0a28e..fa4b575c086c 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -77,3 +77,11 @@ config SND_SOC_QDSP6
>   	 This will enable sound soc platform specific
>   	 audio drivers. This includes q6asm, q6adm,
>   	 q6afe interfaces to DSP using apr.
> +
> +config SND_SOC_MSM8996
> +	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
> +	depends on QCOM_APR
> +	select SND_SOC_QDSP6V2
should be select SND_SOC_QDSP6, V2 is not defined
> +	default n
> +	help
> +	 To add support for SoC audio on MSM8996 and APQ8096 boards
>
