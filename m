From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/7] dt-bindings: clk: at91: add an I2S
	mux clock
Date: Thu, 31 May 2018 09:20:57 -0500
Message-ID: <CAL_JsqJ=T0p17hHg6=obtydt7T-yrAeOr7C2XAEnDFQ-c0b5XQ@mail.gmail.com>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
 <1527251668-31396-2-git-send-email-codrin.ciubotariu@microchip.com>
 <20180531005827.GA17203@rob-hp-laptop>
 <4f2e6e6a-df3a-b645-093c-b4467b3aa843@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 9600B267923
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 16:21:20 +0200 (CEST)
Received: from mail-qk0-f178.google.com (mail-qk0-f178.google.com
 [209.85.220.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 499A8208B1
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 14:21:19 +0000 (UTC)
Received: by mail-qk0-f178.google.com with SMTP id q70-v6so8680606qke.1
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 07:21:19 -0700 (PDT)
In-Reply-To: <4f2e6e6a-df3a-b645-093c-b4467b3aa843@microchip.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Boris Brezillon <boris.brezillon@bootlin.com>, Mark Brown <broonie@kernel.org>, Cristian.Birsan@microchip.com, linux-clk <linux-clk@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 31, 2018 at 5:25 AM, Codrin Ciubotariu
<codrin.ciubotariu@microchip.com> wrote:
> On 31.05.2018 03:58, Rob Herring wrote:
>>
>> On Fri, May 25, 2018 at 03:34:22PM +0300, Codrin Ciubotariu wrote:
>>>
>>> The I2S mux clock can be used to select the I2S input clock. The
>>> available parents are the peripheral and the generated clocks.
>>>
>>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>>> ---
>>>   .../devicetree/bindings/clock/at91-clock.txt       | 34
>>> ++++++++++++++++++++++
>>>   1 file changed, 34 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt
>>> b/Documentation/devicetree/bindings/clock/at91-clock.txt
>>> index 51c259a..1c46b3c 100644
>>> --- a/Documentation/devicetree/bindings/clock/at91-clock.txt
>>> +++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
>>> @@ -90,6 +90,8 @@ Required properties:
>>>         "atmel,sama5d2-clk-audio-pll-pmc"
>>>                 at91 audio pll output on AUDIOPLLCLK that feeds the PMC
>>>                 and can be used by peripheral clock or generic clock
>>> +       "atmel,sama5d2-clk-i2s-mux":
>>> +               at91 I2S clock source selection
>>
>>
>> Is this boolean or takes some values. If latter, what are valid values?
>
>
> This is the compatible string of the clock driver.

Ah, now I remember. AT91 uses fine grained clock nodes in DT. Is there
still a plan to fix this?

>>>     Required properties for SCKC node:
>>>   - reg : defines the IO memory reserved for the SCKC.
>>> @@ -507,3 +509,35 @@ For example:
>>>                         atmel,clk-output-range = <0 83000000>;
>>>                 };
>>>         };
>>> +
>>> +Required properties for I2S mux clocks:
>>> +- #size-cells : shall be 0 (reg is used to encode I2S bus id).
>>> +- #address-cells : shall be 1 (reg is used to encode I2S bus id).
>>> +- name: device tree node describing a specific mux clock.
>>> +       * #clock-cells : from common clock binding; shall be set to 0.
>>> +       * clocks : shall be the mux clock parent phandles; shall be 2
>>> phandles:
>>> +         peripheral and generated clock; the first phandle shall belong
>>> to the
>>> +         peripheral clock and the second one shall belong to the
>>> generated
>>> +         clock; "clock-indices" property can be user to specify
>>> +         the correct order.
>>> +       * reg: I2S bus id of the corresponding mux clock.
>>> +         e.g. reg = <0>; for i2s0, reg = <1>; for i2s1
>>> +
>>> +For example:
>>> +       i2s_clkmux {
>>
>>
>> What is this a child of?
>
>
> It is a child of PMC node, since both parent clocks are generated by PMC.
>
>>
>>> +               compatible = "atmel,sama5d2-clk-i2s-mux";
>>> +               #address-cells = <1>;
>>> +               #size-cells = <0>;
>>
>>
>> How do you address this block? My guess is you don't because it is just
>> part of some other block and you are just creating this node to
>> instantiate a driver. Just make the node for the actual h/w block a
>> clock provider and define the clock ids (0 and 1).
>
>
> This block is not addressed, but its children are. The register we access in
> this driver is not part of other block. It's a SFR register, accessed
> through syscon and it has nothing to do with the I2S IP (see SAMA5D2 DS,
> page 1256, fig. 44-1: I2SC Block Diagram) that is the consumer of this
> clock. Adding a clock-id property in the I2S node would be just like v3 of
> this series, with the difference that we use clock-id instead of alias id to
> set the clock parent, which is not how you suggested back then.

I wasn't suggesting a clock-id property, but a clock specifier (i.e.
make #clock-cells 1).

But AT91 clocks are all a mess, so I don't know what to tell you.

Rob
