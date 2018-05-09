From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH v7 21/24] ASoC: qdsp6: q6asm: Add q6asm dai driver
Date: Wed, 9 May 2018 02:57:13 -0700
Message-ID: <d4972fcf-c513-83db-4770-8009b5ab6d76@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-22-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180501120820.11016-22-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to q6asm dai driver which configures Q6ASM streams
> to pass pcm data.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig           |   4 +
>   sound/soc/qcom/qdsp6/Makefile    |   1 +
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 628 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 633 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6asm-dai.c
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
