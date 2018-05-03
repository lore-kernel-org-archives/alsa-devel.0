From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH v7 05/24] ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
Date: Thu, 3 May 2018 16:53:44 -0700
Message-ID: <dea3ab89-bc4e-a6eb-f2ee-452a7a34cceb@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-6-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180501120820.11016-6-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org



On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch add DT bindings for ADM (Audio Device Manager) DSP module.
> This module implements mixer controls to setup the connections between
> AFE ports and ASM streams.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/sound/qcom,q6adm.txt       | 33 ++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
> new file mode 100644
> index 000000000000..cb709e5dbc44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
> @@ -0,0 +1,33 @@
> +Qualcomm Audio Device Manager (Q6ADM) binding
> +
> +Q6ADM is one of the APR audio service on Q6DSP.
> +Please refer to qcom,apr.txt for details of the coommon apr service bindings
Correct "coommon" to "common". Otherwise looks good.
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
