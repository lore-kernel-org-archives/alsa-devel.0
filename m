From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 06/24] ASoC: qdsp6: dt-bindings: Add
	q6asm dt bindings
Date: Fri, 27 Apr 2018 09:17:26 -0500
Message-ID: <20180427141726.f2wrdhm7qwl6de2l@rob-hp-laptop>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-7-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 035812677FD
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 16:17:29 +0200 (CEST)
Received: by mail-oi0-f66.google.com with SMTP id v2-v6so1712401oif.3
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 07:17:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-7-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 10:45:48AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add DT bindings for ASM (Audio Stream Manager) DSP module.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6asm.txt       | 33 ++++++++++++++++++++++
>  include/dt-bindings/sound/qcom,q6asm.h             | 22 +++++++++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>  create mode 100644 include/dt-bindings/sound/qcom,q6asm.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
> new file mode 100644
> index 000000000000..2178eb91146f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
> @@ -0,0 +1,33 @@
> +Qualcomm Audio Stream Manager (Q6ASM) binding
> +
> +Q6ASM is one of the APR audio service on Q6DSP.
> +Please refer to qcom,apr.txt for details of the common apr service bindings
> +used by the apr service device.
> +
> +- but must contain the following property:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,q6asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
> +		    Or "qcom,q6asm" where the version number can be queried
> +		    from DSP.
> +		    example "qcom,q6asm-v2.0"
> +
> += ASM DAIs (Digial Audio Interface)
> +"dais" subnode of the ASM node represents dai specific configuration
> +
> +- #sound-dai-cells
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Must be 1
> +
> += EXAMPLE
> +
> +q6asm@7 {
> +	compatible = "qcom,q6asm";
> +	reg = <APR_SVC_ASM>;
> +	q6asmdai: dais {
> +		#sound-dai-cells = <1>;
> +	};
> +};
> diff --git a/include/dt-bindings/sound/qcom,q6asm.h b/include/dt-bindings/sound/qcom,q6asm.h
> new file mode 100644
> index 000000000000..1eb77d87c2e8
> --- /dev/null
> +++ b/include/dt-bindings/sound/qcom,q6asm.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __DT_BINDINGS_Q6_ASM_H__
> +#define __DT_BINDINGS_Q6_ASM_H__
> +
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA1	0
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA2	1
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA3	2
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA4	3
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA5	4
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA6	5
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA7	6
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA8	7
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA9	8
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA10	9
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA11	10
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA12	11
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA13	12
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA14	13
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA15	14
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA16	15

Do you plan to add more? I find the defines here fairly pointless. 
Nothing says cell values need to be 0 based, so you could just use 1-16 
directly.

In any case,

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
