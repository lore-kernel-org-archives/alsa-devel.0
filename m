From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 3/5] ASoC: tda998x: add DT documentation of the tda998x
 CODEC
Date: Sat, 01 Feb 2014 22:30:00 +0400
Message-ID: <52ED3D28.7020709@cogentembedded.com>
References: <cover.1391274627.git.moinejf@free.fr> <8e4231b7a55802f58a14dd07ac5cd8b0babb1dce.1391274628.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8e4231b7a55802f58a14dd07ac5cd8b0babb1dce.1391274628.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello.

On 01-02-2014 20:48, Jean-Francois Moine wrote:

> This patch adds the DT documentation of the NXP TDA998x CODEC.

> Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> ---
>   Documentation/devicetree/bindings/drm/i2c/tda998x.txt | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)

> diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> index d7df01c..aa0d81b 100644
> --- a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> +++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
[...]
> @@ -24,4 +35,10 @@ Example:
>   		interrupts = <27 2>;		/* falling edge */
>   		pinctrl-0 = <&pmx_camera>;
>   		pinctrl-names = "default";
> +			hdmi_codec: codec {

    This line is indented too far to the right.

> +			compatible = "nxp,tda998x-codec";
> +			audio-ports = <0x03>, <0x04>;
> +			audio-port-names = "i2s", "spdif";
> +			#sound-dai-cells = <1>;
> +		};
>   	};

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
