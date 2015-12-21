From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 2/2] dt-bindings: sound: add devicetree document for rt5616
Date: Mon, 21 Dec 2015 15:10:57 +0100
Message-ID: <1511057.C46mHiuCd6@diego>
References: <1450703894-32623-1-git-send-email-wxt@rock-chips.com> <1450703894-32623-2-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450703894-32623-2-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Am Montag, 21. Dezember 2015, 21:18:14 schrieb Caesar Wang:
> Add the description for rt5616 codec.
> 
> Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
>  Documentation/devicetree/bindings/sound/rt5616.txt | 38
> ++++++++++++++++++++++ 1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rt5616.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/rt5616.txt
> b/Documentation/devicetree/bindings/sound/rt5616.txt new file mode 100644
> index 0000000..af96207
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rt5616.txt
> @@ -0,0 +1,38 @@
> +RT5616 audio CODEC
> +
> +This device supports I2C only.
> +
> +Required properties:
> +
> +- compatible : "realtek,rt5616".
> +
> +- reg : The I2C address of the device.
> +
> +Optional properties:

you don't have optional properties, so that headline should probably also not 
be here.


Heiko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
