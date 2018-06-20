From: Rob Herring <robh+dt@kernel.org>
Subject: Re: ASoC: new ac97 bus and codec clock
Date: Wed, 20 Jun 2018 14:00:45 -0600
Message-ID: <CAL_JsqJJ2Ka=VDEKEJZtbSZTpNEF3e82ujmxCOQ4-_FibF_1yw@mail.gmail.com>
References: <87lgbdqixh.fsf@belgarion.home>
 <20180619150204.GF11230@sirena.org.uk>
 <CAL_JsqLn2t-zFi8xrig_63OD-SBq8d0jZctih38sZ4cAnRoe6g@mail.gmail.com>
 <8736xhqzmn.fsf@belgarion.home>
 <CAL_JsqJbXGLO+xu1NZOiqmrukHKWUySv=0Sk5KDmSTLL7Mt7+Q@mail.gmail.com>
 <87y3f9peyb.fsf@belgarion.home>
 <CAL_JsqKBOdZBuDnRUAcpARP1fFquc7vpcUayYRaJAMSPrhsPdg@mail.gmail.com>
 <87h8lxp7vo.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id C8562266D4C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 22:01:07 +0200 (CEST)
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8C9A720875
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 20:01:06 +0000 (UTC)
Received: by mail-io0-f181.google.com with SMTP id r24-v6so860455ioh.9
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 13:01:06 -0700 (PDT)
In-Reply-To: <87h8lxp7vo.fsf@belgarion.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 20, 2018 at 1:36 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh+dt@kernel.org> writes:
>
>> Does AC97 specify a common programming model? That's were a common
>> compatible is used (though experience has proven things like
>> "generic-ehci" are don't work).
> If regmap is enough "common programming model" then yes. If you think of a
> common layout of AC97 registers and a common dynamics to program them across all
> ac97 controllers, then no, as far as I'm aware it does not.

No, not regmap.

>>> If the purpose for this compatible string is to filter the child nodes which are
>>> only ac97 codecs, so that the ac97 framework can act upon them (ie. acquire the
>>> clock for example), then wm9713 is too specific ... That won't work for another
>>> device with an Analog Devices AD1835 for example.
>
>> Are there ID registers? If so, then just construct a compatible string
>> from them and just find the compatible child node. See USB bindings
>> for an example using VID/PID.
> There is an AC97 ID register, yes, a key as VID/PID is a key for USB.
>
> So my example, where the id is 0x574d4c13, would become :
>
> ac97: sound@40500000 {
>         compatible = "marvell,pxa270-ac97";
>         reg = < 0x40500000 0x1000 >;
>         interrupts = <14>;
>         reset-gpios = <&gpio 95 GPIO_ACTIVE_HIGH>;
>         #sound-dai-cells = <1>;
>         pinctrl-names = "default";
>         pinctrl-0 = < &pinctrl_ac97_default >;
>         clocks = <&clks CLK_AC97>, <&clks CLK_AC97CONF>;
>         clock-names = "AC97CLK", "AC97CONFCLK";
>
>         audio-codec@0 {
>                 reg = <0>; /* Codex index (between 0 and 3) */
>                 compatible = "ac97id574d4c13";
>                 clocks = <&fixed_wm9713_clock>;
>                 clock-names = "ac97_clk";
>         }
> };
>
> Once we have converged on this example, I will post the patches for the binding,
> and the adaptation of the ac97 bus of course. Gives me a better chance to shoot
> in the right direction first :)

The example looks good.

Rob
