From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH v4 10/14] ASoC: dt-bindings: Add WCD9335 MBHC specific
 properties
Date: Wed, 26 Sep 2018 02:27:29 -0700
Message-ID: <9802022e-2a1b-66ea-e0c8-8cf28ed9b9ce@codeaurora.org>
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
 <20180917005727.32728-11-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917005727.32728-11-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org, lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 9/16/2018 5:57 PM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch add new bindings required to support MBHC
> (Multi Button Headset Control) block in the codec.
> This block is used for jack insert/removal detection,
> headset type detection and 8 button press/release events.
>
> All these properties are very much specific to board.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   .../devicetree/bindings/sound/qcom,wcd9335.txt       | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> index 5d6ea66..a95a8b4 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> @@ -55,6 +55,26 @@ Required properties with SLIMbus Interface:

> +- qcom,hphl-jack-type-normally-open:
> +	Usage: Optional, only required if headset button support required.
...only required if headset insertion/removal support required

> +	Value type: <boolean>
> +	Definition: present if hphl pin on jack is a NO (Normally Open).
> +		If not specified, then its assumed that hphl pin on jack
> +		is NC (Normally Closed).
> +
> +- qcom,gnd-jack-type-normally-open:
> +	Usage: Optional, only required if headset button support required.
...only required if headset insertion/removal support required.

> +	Value type: <boolean>
> +	Definition: present if gnd pin on jack is NO (Normally Open).
> +		 If not specified, then its assumed that gnd pin on
> +		 jack is NC  (Normally Closed).
Ground pin  may not be present on most of the headset jacks. So we 
cannot assume the type is NC if not specified in the device tree.

> +
>   - vdd-buck-supply:
>   	Usage: required
>   	Value type: <phandle>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
