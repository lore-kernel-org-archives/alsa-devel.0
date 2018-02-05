From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] ASoC: ak5558: Add bindings for AK5558 ADC
Date: Mon, 5 Feb 2018 18:26:38 -0200
Message-ID: <CAOMZO5D_5E9H6dJw8ivOgvOqxNvAZ72qhADCoG7VAZ7QwiOcUw@mail.gmail.com>
References: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com> <1517850115-24340-3-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1517850115-24340-3-git-send-email-daniel.baluta-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org, shengjiu.wang-3arQi8VN3Tc@public.gmane.org, Mihai Serban <mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, cosmin.samoila-3arQi8VN3Tc@public.gmane.org, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 5, 2018 at 3:01 PM, Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org> wrote:
> Document the bindings for AK5558 ADC.
>
> Signed-off-by: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/ak5558.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
> new file mode 100644
> index 0000000..7d67ca6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ak5558.txt
> @@ -0,0 +1,22 @@
> +AK5558 8 channel differential 32-bit delta-sigma ADC
> +
> +This device supports I2C mode only.
> +
> +Required properties:
> +
> +- compatible : "asahi-kasei,ak5558"
> +- reg : The I2C address of the device.
> +
> +Optional properties:
> +
> +- reset-gpios: A GPIO specifier for the power down & reset pin.
> +
> +Example:
> +
> +&i2c {
> +       ak5558: adc@10 {

If I understood well Rob's suggestion was to make it only:

adc@10 {

Other than that:

Reviewed-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
