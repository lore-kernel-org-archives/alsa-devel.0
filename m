From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v8 1/2] ASoC: rt5514: Add devicetree
	bindings for rt5514-spi
Date: Wed, 06 Sep 2017 10:42:25 +0800
Message-ID: <59AF6091.5000204@rock-chips.com>
References: <20170905042500.25656-1-jeffy.chen@rock-chips.com>
 <20170905175532.GA9393@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.133])
 by alsa0.perex.cz (Postfix) with ESMTP id EE8A626734C
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 04:42:41 +0200 (CEST)
In-Reply-To: <20170905175532.GA9393@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Norris <briannorris@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, dianders@chromium.org, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, mka@chromium.org, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

Hi Brian,

On 09/06/2017 01:55 AM, Brian Norris wrote:
>> +This device supports SPI only.
>> >+
>> >+Required properties:
>> >+
>> >+- compatible : "realtek,rt5514".
> You list one string here, but there's 2 in the example. The point of
> this exercise was to document (not just in an Example) the strings
> you're using.
Ok, will do.
>
>> >+
>> >+- reg : The SPI address of the device.
>> >+
>> >+Optional properties:
>> >+
>> >+- interrupt-parent: Should be the phandle for the interrupt controller
>> >+- interrupts: The interrupt number to the cpu. The interrupt specifier format
>> >+	      depends on the interrupt controller.
>> >+
>> >+Example:
>> >+
>> >+codec: rt5514-spi@0 {
>> >+	compatible = "realtek,rt5514", "realtek,rt5514-spi";
>> >+	reg = <0>;
>> >+
>> >+        /* May run faster once verified. */
> Really? That was barely useful in the rk3399-gru DTSI, but it's
> definitely not worth sticking in an example.
>
> Also, you switch between tabs and spaces for indentation. Please be
> consistent. (And as with C code, I think the right answer is tabs?)
Oops, thanks for noticing.
>
>> >+        spi-max-frequency = <10000000>;
>> >+
>> >+        pinctrl-names = "default";
>> >+        pinctrl-0 = <&mic_int>;
>> >+
>> >+        interrupt-parent = <&gpio1>;
>> >+        interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
>> >+        wakeup-source;
>> >+};
>> >diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
>> >index 929ca6756b02..12a8c93a67cc 100644
>> >--- a/Documentation/devicetree/bindings/sound/rt5514.txt
>> >+++ b/Documentation/devicetree/bindings/sound/rt5514.txt
>> >@@ -28,6 +28,6 @@ Pins on the device (for linking into audio routes) for RT5514:
>> >  Example:
>> >
>> >  codec: rt5514@57 {
>> >-	compatible = "realtek,rt5514";
>> >+	compatible = "realtek,rt5514", "realtek,rt5514-i2c";
> Example != Documentation. Please document the string properly.
Ok, will do.
>
> Brian
>
