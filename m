From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v3 19/25] ASoC: qcom: q6afe: add support to
 MI2S ports
Date: Wed, 7 Mar 2018 15:05:17 +0530
Message-ID: <7d3c344c-ccb5-78b8-e184-3ab65bdef6ac@codeaurora.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-20-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 09087266EBE
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 10:35:42 +0100 (CET)
In-Reply-To: <20180213165837.1620-20-srinivas.kandagatla@linaro.org>
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
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   include/dt-bindings/sound/qcom,q6afe.h |  10 +++
>   sound/soc/qcom/qdsp6/q6afe.c           | 111 +++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6afe.h           |  10 +++
>   3 files changed, 131 insertions(+)
>
> diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
> index e9004ee39f72..3cd862262369 100644
> --- a/include/dt-bindings/sound/qcom,q6afe.h
> +++ b/include/dt-bindings/sound/qcom,q6afe.h
> @@ -16,6 +16,16 @@
>   #define SLIMBUS_4_TX    24
>   #define SLIMBUS_5_RX    25
>   #define SLIMBUS_5_TX    26
> +#define QUATERNARY_MI2S_RX	34
> +#define QUATERNARY_MI2S_TX	35
> +#define SECONDARY_MI2S_RX	36
> +#define SECONDARY_MI2S_TX	37
> +#define TERTIARY_MI2S_RX	38
> +#define TERTIARY_MI2S_TX	39
> +#define PRIMARY_MI2S_RX		40
> +#define PRIMARY_MI2S_TX		41
Can we assign ids to Primary, secondary, tertiary and quaternary MI2S 
ports in sequence starting with Primary.
> +#define SECONDARY_PCM_RX	42
> +#define SECONDARY_PCM_TX	43
Why only SECONDARY_PCM_RX ? This is not required for MI2S right?
>   #define SLIMBUS_6_RX    45
>   #define SLIMBUS_6_TX    46
>
[..]
