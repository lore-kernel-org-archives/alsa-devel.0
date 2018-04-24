From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 05/23] ASoC: qdsp6: dt-bindings: Add
	q6adm dt bindings
Date: Tue, 24 Apr 2018 11:15:21 -0500
Message-ID: <20180424161521.tyhnpiwbz2tqqetj@rob-hp-laptop>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-6-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E3B5A2675CD
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 18:15:23 +0200 (CEST)
Received: by mail-ot0-f193.google.com with SMTP id y10-v6so8910913otg.10
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 09:15:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180418153157.1960-6-srinivas.kandagatla@linaro.org>
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

On Wed, Apr 18, 2018 at 04:31:39PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add DT bindings for ADM (Audio Device Manager) DSP module.
> This module implements mixer controls to setup the connections between
> AFE ports and ASM streams.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6adm.txt       | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt

Similar comments in this one.

> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
> new file mode 100644
> index 000000000000..f1e2df8d2ea8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
> @@ -0,0 +1,33 @@
> +Qualcomm Audio Device Manager (Q6ADM) binding
> +
> +Q6ADM is one of the APR audio service on Q6DSP.
> +Please refer to qcom,apr.txt for details of the coommon apr service bindings
> +used by the apr service device.
> +
> +- but must contain the following property:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
> +		   Or "qcom,adm" where the version number can be queried
> +		   from DSP.
> +		   example "qcom,adm-v2.0"
> +
> +
> += ADM routing
> +"routing" subnode of the ADM node represents adm routing specific configuration
> +
> +- #sound-dai-cells
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: Must be 0
> +
> += EXAMPLE
> +q6adm {

a6adm@?

Needs to be the number, not a define.

> +	compatible = "qcom,q6adm";
> +	reg = <APR_SVC_ADM>;
> +	q6routing: routing {
> +		#sound-dai-cells = <0>;
> +	};
> +};
> -- 
> 2.16.2
> 
