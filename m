From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: sound: sun6i-spdif: Document that the RX
 channel can be missing
Date: Mon, 15 Apr 2019 20:36:28 -0500
Message-ID: <CAL_Jsq+nv4fOBEVswtXFVvC_Va4suWa9F9H=E4Vt1xw6K7z-Ng@mail.gmail.com>
References: <4060ec46117ccf3cd643b8f1b9759ed44d38c5e7.1555330005.git-series.maxime.ripard@bootlin.com>
 <e671a8289b7176b1eacb79edf443575f940f4a22.1555330005.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e671a8289b7176b1eacb79edf443575f940f4a22.1555330005.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 15, 2019 at 7:07 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Not all controllers using the A31 SPDIF binding actually have some RX
> capabilities, and therefore on some controllers we don't have the option to
> set an RX DMA channel.
>
> This was already done in the DTSI, but the binding itself was never
> updated.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml
> index 7329d9fcf34c..800f794fafe0 100644
> --- a/Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml
> +++ b/Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml
> @@ -44,14 +44,24 @@ properties:
>        - const: spdif
>
>    dmas:
> +    minItems: 1
> +    maxItems: 2
>      items:
>        - description: RX DMA Channel
>        - description: TX DMA Channel
> +    description:
> +      Some controllers cannot receive but can only transmit data. In
> +      such a case, the RX DMA channel is to be omitted.

Really, the schema is saying rx is optional, but it doesn't really
matter here as the schema for each item is just 'description'.

>    dma-names:
> -    items:
> -      - const: rx
> -      - const: tx
> +    minItems: 1
> +    maxItems: 2
> +    enum:
> +      - rx
> +      - tx
> +    description:
> +      Some controllers cannot receive but can only transmit data. In
> +      such a case, the RX name is to be omitted.

Here it matters though. This would allow just 'tx', '"tx", "tx"', or
either order.

You need something like this:

oneOf:
  -  items:
       - const: rx
       - const: tx
  - const: tx

Ideally, we'd always put the required entry first and avoid this
problem. Not always possible if the first entry gets removed in later
h/w.

Rob
