From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH V5] ASoC: cs42xx8: add reset-gpios in binding document
Date: Thu, 16 May 2019 08:46:36 -0300
Message-ID: <CAOMZO5A7Xtg_pV2VAfmw5NacpRLS=0aGMAazu8p8tOTfa9PrCA@mail.gmail.com>
References: <3e15abaee348468a69005e4240346822320c7f69.1558006714.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3e15abaee348468a69005e4240346822320c7f69.1558006714.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>, Rob Herring <robh+dt@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Cc: "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

[You should always submit dt-bindings patches to Rob and to the
devicetree list as indicated by checkpatch]

On Thu, May 16, 2019 at 8:42 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:
>
> Add reset-gpios property, which is optional.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

> +Optional properties:
> +
> +  - reset-gpios : a GPIO spec to define which pin is connected to the chip's
> +    !RESET pin
> +
>  Example:
>
>  cs42888: codec@48 {
> @@ -25,4 +30,5 @@ cs42888: codec@48 {
>         VD-supply = <&reg_audio>;
>         VLS-supply = <&reg_audio>;
>         VLC-supply = <&reg_audio>;
> +       reset-gpios = <&pca9557_b 1 GPIO_ACTIVE_LOW>;

Reviewed-by: Fabio Estevam <festevam@gmail.com>
