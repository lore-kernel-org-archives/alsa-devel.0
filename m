From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: sound: sun4i-spdif: Document that the
 RX channel can be missing
Date: Wed, 8 May 2019 14:35:10 -0500
Message-ID: <CAL_Jsq+iLmzti5TX-TUU3PN4taC66UMqHMk-aKTjZKt1kVRtMQ@mail.gmail.com>
References: <dc84c7e9ce272109052f553a5e050bfe1a09e9d6.1557252411.git-series.maxime.ripard@bootlin.com>
 <d9afb19c32f8b9b2c40c8d4c0c3df74bff0ccf35.1557252411.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d9afb19c32f8b9b2c40c8d4c0c3df74bff0ccf35.1557252411.git-series.maxime.ripard@bootlin.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 7, 2019 at 1:07 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The H3 and compatibles controllers don't have any reception capabilities,
> even though it was never documented as such in the binding before.
>
> Therefore, on those controllers, we don't have the option to set an RX DMA
> channel.
>
> This was already done in the DTSI, but the binding itself was never
> updated. Let's add a special case in the schemas.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v1:
>   - switch to a draft7 conditional
> ---
>  Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml | 45 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
> index 5698e5de5e31..8f1bc1a1af96 100644
> --- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
> +++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
> @@ -44,15 +44,8 @@ properties:
>        - const: apb
>        - const: spdif
>
> -  dmas:
> -    items:
> -      - description: RX DMA Channel
> -      - description: TX DMA Channel
> -
> -  dma-names:
> -    items:
> -      - const: rx
> -      - const: tx
> +  dmas: true
> +  dma-names: true
>
>    resets:
>      maxItems: 1
> @@ -70,6 +63,40 @@ allOf:
>        required:
>          - resets
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun8i-h3-spdif
> +
> +    then:
> +      properties:
> +        dmas:
> +          maxItems: 1

In this and below, these should get added automatically by
fixup_schema. If not present, we set minItems/maxItems to the size of
the items list. It look like you added support for that, so left over
from before you addressed that for if/then/else?

> +          items:
> +            - description: RX DMA Channel

s/RX/TX/

> +
> +        dma-names:
> +          maxItems: 1
> +          items:
> +            - const: tx
> +
> +    else:
> +      properties:
> +        dmas:
> +          minItems: 2
> +          maxItems: 2
> +          items:
> +            - description: RX DMA Channel
> +            - description: TX DMA Channel
> +
> +        dma-names:
> +          minItems: 2
> +          maxItems: 2
> +          items:
> +            - const: rx
> +            - const: tx

I'm really on the fence whether it's worth it to add all this just add
the restrictions based on the compatible. I guess with copy-n-paste
this would be a common error.

Rob
