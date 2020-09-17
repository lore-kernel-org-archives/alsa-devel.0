Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4E8C43463
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:12:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB58C20874
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ovCgs8jN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Q0VtsHkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB58C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C09D1695;
	Mon, 21 Sep 2020 10:11:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C09D1695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600675928;
	bh=4DMjAbU38sRZa4Hb+7uteuEdS1wnI9GFHiIgCUgEZ/c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ovCgs8jNQGtV2Xbtfi1Ttbx1Dnmq+YaiKLU7b38fE1A3gtt0dw67I93Zd+SExVw05
	 8DadHfgWHVLxEMNqMvu0kXFbg8iNJ+NAgFWCk5iskQRRwQmxRcs1A42jI6NgseqPwd
	 D1jRVfRGUWZoDEKfH12Sh3GwF7aAikN+P33hciog=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68CF6F8020B;
	Mon, 21 Sep 2020 10:10:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7DBAF80212; Thu, 17 Sep 2020 22:10:12 +0200 (CEST)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C785F8013A
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 22:10:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C785F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com
 header.b="Q0VtsHkh"
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi
 [62.78.145.57])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 361D6E42;
 Thu, 17 Sep 2020 22:10:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1600373406;
 bh=4DMjAbU38sRZa4Hb+7uteuEdS1wnI9GFHiIgCUgEZ/c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q0VtsHkhoUVlzTu7tNMMcMsFAPfpXoYMh4cRGn6MmDxvumEgpl8HoPhsaS9P5RQ0Y
 NVTFOFHBfusC0IIVq9IenTWY3skD0ldFuVOF8UWv0RFNF3NZ/lN8K6JSoJROzof6o8
 kv65KBP9KWCuIrAttiiUNKk2jIgT65ueP7LagMtc=
Date: Thu, 17 Sep 2020 23:09:36 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 01/13] dt-bindings: gpio: add common schema for GPIO
 controllers
Message-ID: <20200917200936.GF3969@pendragon.ideasonboard.com>
References: <20200917165301.23100-1-krzk@kernel.org>
 <20200917165301.23100-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917165301.23100-2-krzk@kernel.org>
X-Mailman-Approved-At: Mon, 21 Sep 2020 10:10:22 +0200
Cc: Amelie Delaunay <amelie.delaunay@st.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org,
 Stefan Agner <stefan@agner.ch>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Chris Brandt <chris.brandt@renesas.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-riscv@lists.infradead.org, Fabio Estevam <festevam@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 Alexandre Torgue <alexandre.torgue@st.com>, linux-renesas-soc@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Anson Huang <Anson.Huang@nxp.com>, Lee Jones <lee.jones@linaro.org>,
 Takashi Iwai <tiwai@suse.com>, Magnus Damm <magnus.damm@gmail.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Andy Gross <agross@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 NXP Linux Team <linux-imx@nxp.com>, Andy Teng <andy.teng@mediatek.com>,
 Jacopo Mondi <jacopo+renesas@jmondi.org>, Sungbo Eo <mans0n@gorani.run>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Sean Wang <sean.wang@mediatek.com>,
 Maxime Ripard <mripard@kernel.org>, linux-gpio@vger.kernel.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Sricharan R <sricharan@codeaurora.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hoan Tran <hoan@os.amperecomputing.com>, linux-arm-kernel@lists.infradead.org,
 Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Scott Branden <sbranden@broadcom.com>, linux-unisoc@lists.infradead.org,
 - <patches@opensource.cirrus.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Liam Girdwood <lgirdwood@gmail.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-kernel@vger.kernel.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Yash Shah <yash.shah@sifive.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Mark Brown <broonie@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-media@vger.kernel.org,
 Shawn Guo <shawnguo@kernel.org>,
 Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Krzysztof,

Thank you for the patch.

On Thu, Sep 17, 2020 at 06:52:49PM +0200, Krzysztof Kozlowski wrote:
> Convert parts of gpio.txt bindings into common dtschema file for GPIO
> controllers.

How about deleting the part that has been converted from gpio.txt ?

> The schema enforces proper naming of GPIO controller nodes and GPIO
> hogs.
> 
> The schema should be included by specific GPIO controllers bindings.

Instead of including it manually, could we use a conditional select: to
apply the schema automatically when a gpio-controller property is
present ?

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Do not require compatible (some child nodes are gpio-controllers
>    without the compatible).
> ---
>  .../devicetree/bindings/gpio/gpio-common.yaml | 125 ++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-common.yaml b/Documentation/devicetree/bindings/gpio/gpio-common.yaml
> new file mode 100644
> index 000000000000..af9f6c7feeec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-common.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/gpio-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common GPIO controller properties
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +properties:
> +  nodename:
> +    pattern: "^(gpio-controller|gpio)(@[0-9a-f]+|-[0-9a-f]+)?$"
> +
> +  '#gpio-cells': true
> +  gpio-controller: true
> +  gpio-ranges: true
> +
> +  gpio-line-names:
> +    description: |
> +      Optionally, a GPIO controller may have a "gpio-line-names" property. This
> +      is an array of strings defining the names of the GPIO lines going out of
> +      the GPIO controller. This name should be the most meaningful producer
> +      name for the system, such as a rail name indicating the usage. Package
> +      names such as pin name are discouraged: such lines have opaque names
> +      (since they are by definition generic purpose) and such names are usually
> +      not very helpful.
> +
> +      For example "MMC-CD", "Red LED Vdd" and "ethernet reset" are reasonable
> +      line names as they describe what the line is used for. "GPIO0" is not a
> +      good name to give to a GPIO line.
> +
> +      Placeholders are discouraged: rather use the "" (blank string) if the use
> +      of the GPIO line is undefined in your design. The names are assigned
> +      starting from line offset 0 from left to right from the passed array. An
> +      incomplete array (where the number of passed named are less than ngpios)
> +      will still be used up until the last provided valid line index.
> +
> +  gpio-reserved-ranges:
> +    description:
> +      Indicates the start and size of the GPIOs that can't be used.
> +
> +  ngpios:
> +    description: |
> +      Optionally, a GPIO controller may have a "ngpios" property. This property
> +      indicates the number of in-use slots of available slots for GPIOs. The
> +      typical example is something like this: the hardware register is 32 bits
> +      wide, but only 18 of the bits have a physical counterpart. The driver is
> +      generally written so that all 32 bits can be used, but the IP block is
> +      reused in a lot of designs, some using all 32 bits, some using 18 and
> +      some using 12. In this case, setting "ngpios = <18>;" informs the driver
> +      that only the first 18 GPIOs, at local offset 0 .. 17, are in use.
> +
> +      If these GPIOs do not happen to be the first N GPIOs at offset 0...N-1,
> +      an additional set of tuples is needed to specify which GPIOs are
> +      unusable, with the gpio-reserved-ranges binding.
> +
> +patternProperties:
> +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
> +    type: object
> +    description:
> +      The GPIO chip may contain GPIO hog definitions. GPIO hogging is a mechanism
> +      providing automatic GPIO request and configuration as part of the
> +      gpio-controller's driver probe function.
> +      Each GPIO hog definition is represented as a child node of the GPIO controller.
> +
> +    properties:
> +      gpio-hog: true
> +      gpios: true
> +      input: true
> +      output-high: true
> +      output-low: true
> +      line-name:
> +        description:
> +          The GPIO label name. If not present the node name is used.
> +
> +    required:
> +      - gpio-hog
> +      - gpios
> +
> +    oneOf:
> +      - required:
> +          - input
> +      - required:
> +          - output-high
> +      - required:
> +          - output-low
> +
> +    additionalProperties: false
> +
> +required:
> +  - "#gpio-cells"
> +  - gpio-controller
> +
> +examples:
> +  - |
> +    gpio-controller@15000000 {
> +        compatible = "foo";
> +        reg = <0x15000000 0x1000>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        ngpios = <18>;
> +        gpio-reserved-ranges = <0 4>, <12 2>;
> +        gpio-line-names = "MMC-CD", "MMC-WP", "VDD eth", "RST eth", "LED R",
> +                          "LED G", "LED B", "Col A", "Col B", "Col C", "Col D",
> +                          "Row A", "Row B", "Row C", "Row D", "NMI button",
> +                          "poweroff", "reset";
> +    };
> +
> +  - |
> +    gpio-controller@1400 {
> +        compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
> +        reg = <0x1400 0x18>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +
> +        line-b-hog {
> +            gpio-hog;
> +            gpios = <6 0>;
> +            input;
> +            line-name = "foo-bar-gpio";
> +        };
> +    };

-- 
Regards,

Laurent Pinchart
