From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: sound: Convert Allwinner SPDIF binding
 to YAML
Date: Tue, 16 Apr 2019 16:36:18 -0500
Message-ID: <CAL_JsqLuMObaNzrRMGDi-m=0B8AA7CYqJkrvD_K3cTmH7rdE4Q@mail.gmail.com>
References: <4060ec46117ccf3cd643b8f1b9759ed44d38c5e7.1555330005.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4060ec46117ccf3cd643b8f1b9759ed44d38c5e7.1555330005.git-series.maxime.ripard@bootlin.com>
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
> The Allwinner SoCs feature an SPDIF controller across multiple SoC
> generations.
>
> However, earlier generations were a bit simpler than the subsequent ones,
> and for example would always have RX and TX capabilities, and no reset
> lines.
>
> In order to express this, let's create two YAML schemas instead of the free
> form text we had before.

The only difference is 'reset' is required in one? Perhaps better to
just not make 'reset' required til we figure out how to handle a
conditional like this. Seems like we discussed this and I probably
said to split things? I guess it's a judgement call depending on how
different things are.

Possibly, we could handle this case like this:

allOf:
  - $ref: allwinner,sun4i-a10-spdif.yaml

properties:
  resets:
    maxItems: 1

required:
  - resets


Plus we'd need the 'allwinner,sun6i-a31-spdif' and other compatibles
in both files. Note that you can't use 'additionalProperties: false'
in either file in this case.

I don't really love this solution though.

Rob
