From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH v3 1/2] ASoC: msm8916: Add codec Device Tree bindings.
Date: Tue, 14 Jun 2016 09:12:27 -0700
Message-ID: <20160614161227.GA10893@kwestfie-linux.qualcomm.com>
References: <1465582725-30183-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1465582725-30183-2-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465582725-30183-2-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, plai@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 10, 2016 at 11:18:44AM -0700, Srinivas Kandagatla wrote:
> diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt
> b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt
> new file mode 100644
> index 0000000..0559c1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt
> @@ -0,0 +1,103 @@
> +msm8916 audio CODEC audio CODEC
> +
> +Codec IP is divided into two parts, first analog which is integrated in
> pmic pm8916
> +and secondly digital part which is integrated into application processor.
> Codec register
> +controls are also split across pmic an lpass. Analog part is controlled
> via spmi bus to pmic.

Cleaning up the description:

msm8916 audio CODEC

Codec IP is divided into two parts:
  * analog, which is integrated into pmic pm8916
  * digital, which is integrated into LPASS on the SOC
Codec registers are also split across pmic and LPASS.
Analog codec is controlled via spmi bus to pmic.

> +## Bindings for codec core on pmic:
> +
> +Required properties
> + - compatible = "qcom,msm8916-pmic-wcd-codec";

OK.  Looking at this again, I think its better just to drop the pmic.

> +  "spk_cnp_int" - Speaker click and pop interrupt
> +  "spk_clip_int" - Speaker clip interrupt
> +  "spk_ocp_int" - Speaker over current protect interrupt.
> +  "ins_rem_det1" - jack insert removal detect interrupt 1.
> +  "but_rel_det" - button release interrupt
> +  "but_press_det" - button press event
> +  "ins_rem_det" - jack insert removal detect interrup
> +  "mbhc_int"	- multi button headset interrupt.
> +  "ear_ocp_int" - Earphone over current protect interrupt.
> +  "hphr_ocp_int" - Headphone R over current protect interrupt.
> +  "hphl_ocp_det" - Headphone L over current protect interrupt
> +  "ear_cnp_int" - earphone cnp interrupt.
> +  "hphr_cnp_int" - hphr click and pop interrupt.
> +  "hphl_cnp_int" - hphl click and pop interrupt

Please use labels that more closely match the HW spec:
  "cdc_spk_cnp_int"
  "cdc_spk_clip_int"
  "cdc_spk_ocp_int"
  "mbhc_ins_rem_det1"
  "mbhc_but_rel_det"
  "mbhc_but_press_det"
  "mbhc_ins_rem_det"
  "mbhc_switch_int"
  "cdc_ear_ocp_int"
  "cdc_hphr_ocp_int"
  "cdc_hphl_ocp_int"
  "cdc_ear_cnp_int"
  "cdc_hphr_cnp_int"
  "cdc_hphl_cnp_int"

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
