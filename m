From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] ASoC: da7213: Add bindings documentation for codec driver
Date: Wed, 7 Oct 2015 11:22:04 -0500
Message-ID: <CAL_JsqL0R0jVSm6w0V=F5c1Odw3RKATjcq96QaUcA99JJmD2Xw@mail.gmail.com>
References: <cover.1444223905.git.Adam.Thomson.Opensource@diasemi.com> <bfc7c5e61d8c398bc4cfa56a7908032dc3bdf82f.1444223905.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bfc7c5e61d8c398bc4cfa56a7908032dc3bdf82f.1444223905.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 7, 2015 at 8:27 AM, Adam Thomson
<Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org> wrote:
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/da7213.txt | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/da7213.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/da7213.txt b/Documentation/devicetree/bindings/sound/da7213.txt
> new file mode 100644
> index 0000000..7280e82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/da7213.txt
> @@ -0,0 +1,41 @@
> +Dialog Semiconductor DA7213 Audio Codec bindings
> +
> +======
> +
> +Required properties:
> +- compatible : Should be "dlg,da7213"
> +- reg: Specifies the I2C slave address
> +
> +Optional properties:
> +- clocks : phandle and clock specifier for codec MCLK.
> +- clock-names : Clock name string for 'clocks' attribute, should be "mclk".
> +
> +- dlg,micbias1-lvl : Voltage (mV) for Mic Bias 1
> +       [<1600>, <2200>, <2500>, <3000>]
> +- dlg,micbias2-lvl : Voltage (mV) for Mic Bias 2
> +       [<1600>, <2200>, <2500>, <3000>]

Please append the units (-microvolt).

> +- dlg,dmic-data-sel : DMIC channel select based on clock edge.
> +       ["lrise_rfall", "lfall_rrise"]
> +- dlg,dmic-samplephase : When to sample audio from DMIC.
> +       ["on_clkedge", "between_clkedge"]

How about boolean for these two.

> +- dlg,dmic-clkrate : DMIC clock frequency (MHz).
> +       [<1500000>, <3000000>]

So 1.5GHz or 3GHz?

Add units (-hz).

> +
> +======
> +
> +Example:
> +
> +       codec_i2c: da7213@1a {
> +               compatible = "dlg,da7213";
> +               reg = <0x1a>;
> +
> +               clocks = <&clks 201>;
> +               clock-names = "mclk";
> +
> +               dlg,micbias1-lvl = <2500>;
> +               dlg,micbias2-lvl = <2500>;
> +
> +               dlg,dmic-data-sel = "lrise_rfall";
> +               dlg,dmic-samplephase = "between_clkedge";
> +               dlg,dmic-clkrate = <3000000>;
> +       };
> --
> 1.9.3
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
