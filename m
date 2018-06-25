From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH 03/11] ASoC: q6afe: dt-bindings: add
 compatible string to dais
Date: Mon, 25 Jun 2018 20:01:30 +0200
Message-ID: <20180625180130.GC10876@centauri.lan>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D91232673F5
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 20:01:34 +0200 (CEST)
Received: by mail-lj1-f193.google.com with SMTP id t21-v6so6754904lji.0
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 11:01:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180625143115.8346-4-srinivas.kandagatla@linaro.org>
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
Cc: rohkumar@qti.qualcomm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 25, 2018 at 03:31:07PM +0100, Srinivas Kandagatla wrote:
> Add compatible string to dais so that it can support DT based module
> autoloading.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,q6afe.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> index bdbf87df8c0b..f7ea77ba7947 100644
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
> @@ -103,6 +108,7 @@ q6afe@4 {
>  		#sound-dai-cells = <1>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		compatible = "qcom,q6afe-dais";

Perhaps have the compatible before #sound-dai-cells
(and #size-cells, #address-cells) like in two previous
patches.

>  
>  		hdmi@1 {
>  			reg = <1>;
> -- 
> 2.16.2
> 
