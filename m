From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/5] ASoC: codecs: Add msm8916-wcd analog codec
Date: Fri, 16 Sep 2016 10:43:48 -0500
Message-ID: <20160916154348.GA15543@rob-hp-laptop>
References: <1473339896-9409-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1473339896-9409-2-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473339896-9409-2-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 08, 2016 at 02:04:52PM +0100, Srinivas Kandagatla wrote:
> msm8916-wcd codec is found in Qualcomm msm8916 and apq8016 processors.
> This codec IP is split in to two parts (Digital & Analog).
> Analog part is integrated in to PMIC PM8916 and the digital part is
> integrated into Application processor. Data transfer between Analog and
> Digital Die is done via a internal bus called PDM.
> 
> This patch adds support to Analog part of the Codec which is integrated
> into PMIC PM8916.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  .../bindings/sound/qcom,msm8916-wcd-analog.txt     |  83 ++
>  sound/soc/codecs/Kconfig                           |   4 +
>  sound/soc/codecs/Makefile                          |   3 +-
>  sound/soc/codecs/msm8916-wcd-analog.c              | 888 +++++++++++++++++++++
>  4 files changed, 977 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
>  create mode 100644 sound/soc/codecs/msm8916-wcd-analog.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
> new file mode 100644
> index 0000000..f426c06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
> @@ -0,0 +1,83 @@
> +msm8916 analog audio CODEC
> +
> +Bindings for codec Analog IP which is integrated in pmic pm8916,
> +
> +## Bindings for codec core on pmic:
> +
> +Required properties
> + - compatible = "qcom,msm8916-wcd-analog-codec";

If this is part of the pm8916 PMIC, then shouldn't it be named that way.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
