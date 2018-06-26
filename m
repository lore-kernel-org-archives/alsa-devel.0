From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v2 03/12] ASoC: q6afe: dt-bindings: add
 compatible string to dais
Date: Tue, 26 Jun 2018 11:28:59 +0200
Message-ID: <20180626092859.GA25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 531922675C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 11:29:03 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so16823589lfc.7
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 02:29:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-4-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:07AM +0100, Srinivas Kandagatla wrote:
> Add compatible string to dais so that it can support DT based module
> autoloading.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,q6afe.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> index bdbf87df8c0b..a8179409c194 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> @@ -17,6 +17,11 @@ used by all apr services. Must contain the following properties.
>  subnode of "dais" representing board specific dai setup.
>  "dais" node should have following properties followed by dai children.
>  
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,q6afe-dais"
> +
>  - #sound-dai-cells
>  	Usage: required
>  	Value type: <u32>
> @@ -100,6 +105,7 @@ q6afe@4 {
>  	reg = <APR_SVC_AFE>;
>  
>  	dais {
> +		compatible = "qcom,q6afe-dais";
>  		#sound-dai-cells = <1>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -- 
> 2.16.2
> 
