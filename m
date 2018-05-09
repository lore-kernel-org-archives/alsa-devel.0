From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH v7 14/24] ASoC: qdsp6: q6asm: Add q6asm driver
Date: Wed, 9 May 2018 01:10:03 -0700
Message-ID: <3e7601d4-0304-3aa1-66cc-617b99727567@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-15-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180501120820.11016-15-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org



On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds basic support to Q6 ASM (Audio Stream Manager) module on
> Q6DSP. ASM supports up to 8 concurrent streams. each stream can be setup
> as playback/capture. ASM provides top control functions like
> Pause/flush/resume for playback and record. ASM can Create/destroy encoder,
> decoder and also provides POPP dynamic services.
>
> This patch adds support to basic features to allow hdmi playback.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig        |   4 +
>   sound/soc/qcom/qdsp6/Makefile |   1 +
>   sound/soc/qcom/qdsp6/q6asm.c  | 215 ++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6asm.h  |  15 +++
>   4 files changed, 235 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6asm.c
>   create mode 100644 sound/soc/qcom/qdsp6/q6asm.h
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 971127edbc23..941774abd94f 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -53,6 +53,9 @@ config SND_SOC_QDSP6_AFE
>   config SND_SOC_QDSP6_ADM
>   	tristate
>   
> +config SND_SOC_QDSP6_ASM
<snip>
> +static const struct of_device_id q6asm_device_id[]  = {
> +	{ .compatible = "qcom,q6asm" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, q6asm_device_id);
> +
> +static struct apr_driver qcom_q6asm_driver = {
> +	.probe = q6asm_probe,
> +	.remove = q6asm_remove,
> +	.callback = q6asm_srvc_callback,
> +	.driver = {
> +		.name = "qcom-q6asm",
> +		.of_match_table = of_match_ptr(q6asm_device_id),
> +	},
> +};
> +
> +module_apr_driver(qcom_q6asm_driver);
> +MODULE_DESCRIPTION("Q6 Audio Stream Manager driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
> new file mode 100644
> index 000000000000..92cc0efaa2c8
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6asm.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __Q6_ASM_H__
> +#define __Q6_ASM_H__
> +
> +#define MAX_SESSIONS	16
MAX_SESSIONS should be 8?

Otherwise LGTM.
Once addressed about, add acked-by-
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
