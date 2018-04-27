From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 04/24] ASoC: qdsp6: dt-bindings: Add
	q6afe dt bindings
Date: Fri, 27 Apr 2018 09:13:23 -0500
Message-ID: <20180427141323.2ykh676xpdf7b6bl@rob-hp-laptop>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-5-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 by alsa0.perex.cz (Postfix) with ESMTP id B3F8C26728A
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 16:13:25 +0200 (CEST)
Received: by mail-oi0-f68.google.com with SMTP id y15-v6so1685868oia.13
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 07:13:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-5-srinivas.kandagatla@linaro.org>
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

On Thu, Apr 26, 2018 at 10:45:46AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add DT bindings for AFE (Audio Frontend) DSP module.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6afe.txt       | 88 ++++++++++++++++++++++
>  include/dt-bindings/sound/qcom,q6afe.h             | 31 ++++++++
>  2 files changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>  create mode 100644 include/dt-bindings/sound/qcom,q6afe.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> new file mode 100644
> index 000000000000..05208a63dd3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> @@ -0,0 +1,88 @@
> +Qualcomm Audio Front End (Q6AFE) binding
> +
> +AFE is one of the APR audio service on Q6DSP
> +Please refer to qcom,apr.txt for details of the common apr service bindings
> +used by all apr services.
> +
> +- but must contain the following property:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,q6afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>"
> +		  Or "qcom,q6afe" where the version number can be queried
> +		  from DSP.
> +		  example "qcom,q6afe"

reg too.

> +
> += AFE DAIs (Digial Audio Interface)
> +"dais" subnode of the AFE node represents dai specific configuration
> +
> +- #sound-dai-cells
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Must be 1
> +
> +- reg

It's not clear here these are in a grandchild node.

> +	Usage: required
> +	Value type: <u32>
> +	Definition: Must be dai id
> +
> +- qcom,sd-lines
> +	Usage: required for mi2s interface
> +	Value type: <prop-encoded-array>
> +	Definition: Must be list of serial data lines used by this dai.
> +	should be one or more of the 1-4 sd lines.
