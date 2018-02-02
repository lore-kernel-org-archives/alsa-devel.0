From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 2/2] ASoC: ak5558: Add bindings for AK5558 ADC
Date: Fri, 2 Feb 2018 20:48:44 -0200
Message-ID: <CAOMZO5BOq6XN8TMXLSW5QPtLYg7EghkkK0bP4uxMja2onnK7iw@mail.gmail.com>
References: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com> <1517588406-3295-3-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1517588406-3295-3-git-send-email-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, daniel.baluta@gmail.com, shengjiu.wang@nxp.com, linux-kernel <linux-kernel@vger.kernel.org>, wakasugi.jb@om.asahi-kasei.co.jp, linux-imx@nxp.com, cosmin.samoila@nxp.com, Mihai Serban <mihai.serban@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

You missed to add the dt maintainer, Rob Herring.

On Fri, Feb 2, 2018 at 2:20 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Please add a commit log.

> ---
>  Documentation/devicetree/bindings/sound/ak5558.txt | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
> new file mode 100644
> index 0000000..61c85568
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ak5558.txt
> @@ -0,0 +1,23 @@
> +AK5558 8 channel differential 32-bit delta-sigma ADC
> +
> +This device supports I2C mode only.
> +
> +Required properties:
> +
> +- compatible : "asahi-kasei,ak5558"
> +- reg : The I2C address of the device for I2C.

No need for repeating "I2C" in this phrase.

"- reg : The I2C address of the device." would be better.

> +Optional properties:
> +
> +- reset-gpios: A GPIO specifier for the GPIO controlling
> +       the power down & reset pin.

No need for repeating "GPIO" in this phrase.

"- reset-gpios: A GPIO specifier for the the power down & reset pin."
would be better.
