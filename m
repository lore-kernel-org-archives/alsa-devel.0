From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [alsa-devel][PATCH 2/3] dt-binding: Add sunxi SPDIF
 machine driver
Date: Thu, 24 Sep 2015 23:00:09 +0800
Message-ID: <CAGb2v65QP_+zO19B5zWpeww=yorXzftE2oo9kwhEY3pCVuXTnQ@mail.gmail.com>
References: <1443031494-32469-1-git-send-email-codekipper@gmail.com> <1443031494-32469-3-git-send-email-codekipper@gmail.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBEVASCYAKGQEW7QOTDQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1443031494-32469-3-git-send-email-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 24, 2015 at 2:04 AM,  <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Add device tree bindings for the SPDIF machine driver for Allwinner SoC
> devices.

Is there a particular reason for having 2 separate bindings for one piece of
hardware?

Also, both this binding and the driver bits look almost like imx-audio-spdif.
This seems like unneeded duplication. Can we generalize that and use it? Or
just use simple-card?


Regards
ChenYu

> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../bindings/sound/sunxi-audio-spdif.txt           | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
> new file mode 100644
> index 0000000..b9e8152
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
> @@ -0,0 +1,36 @@
> +Allwinner audio complex with S/PDIF transceiver
> +
> +Required properties:
> +
> +  - compatible         : "Allwinner,sunxi-audio-spdif"
> +
> +  - model              : The user-visible name of this sound complex
> +
> +  - spdif-controller   : The phandle of the Allwinner S/PDIF controller
> +
> +
> +Optional properties:
> +
> +  - spdif-out          : This is a boolean property. If present, the
> +                         transmitting function of S/PDIF will be enabled,
> +                         indicating there's a physical S/PDIF out connector
> +                         or jack on the board or it's connecting to some
> +                         other IP block, such as an HDMI encoder or
> +                         display-controller.
> +
> +  - spdif-in           : This is a boolean property. If present, the receiving
> +                         function of S/PDIF will be enabled, indicating there
> +                         is a physical S/PDIF in connector/jack on the board.
> +
> +* Note: At least one of these two properties should be set in the DT binding.
> +
> +
> +Example:
> +
> +sound-spdif {
> +       compatible = "allwinner,sunxi-audio-spdif";
> +       model = "sunxi-spdif";
> +       spdif-controller = <&spdif>;
> +       spdif-out;
> +       spdif-in;
> +};
> --
> 2.5.3
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.
