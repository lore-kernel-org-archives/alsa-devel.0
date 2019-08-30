From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/5] ASoC: dt-bindings: Convert Allwinner A23 analog
 codec to a schema
Date: Fri, 30 Aug 2019 10:39:59 -0500
Message-ID: <CAL_JsqLMvKUu0hp6rSGn=KtPHGe++r4dYyAZcDfLgy16pUi2Bg@mail.gmail.com>
References: <20190828125209.28173-1-mripard@kernel.org>
 <20190828125209.28173-4-mripard@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190828125209.28173-4-mripard@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <mripard@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 28, 2019 at 7:52 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> The Allwinner A23 SoC and later have an embedded audio codec that uses a
> separate controller to drive its analog part, which is supported in Linux,
> with a matching Device Tree binding.
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v1:
>   - Fix subject prefix
> ---
>  .../allwinner,sun8i-a23-codec-analog.yaml     | 38 +++++++++++++++++++
>  .../bindings/sound/sun8i-codec-analog.txt     | 17 ---------
>  2 files changed, 38 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun8i-a23-codec-analog.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a23-codec-analog.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a23-codec-analog.yaml
> new file mode 100644
> index 000000000000..832779389cbd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a23-codec-analog.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/allwinner,sun8i-a23-codec-analog.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner A23 Analog Codec Device Tree Bindings
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <maxime.ripard@bootlin.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      # FIXME: This is documented in the PRCM binding, but needs to be
> +      # migrated here at some point
> +      # - const: allwinner,sun8i-a23-codec-analog
> +      - const: allwinner,sun8i-h3-codec-analog
> +      - const: allwinner,sun8i-v3s-codec-analog

enum is nicer than oneOf+const.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    codec_analog: codec-analog@1f015c0 {
> +      compatible = "allwinner,sun8i-h3-codec-analog";
> +      reg = <0x01f015c0 0x4>;
> +    };
> +
> +...
