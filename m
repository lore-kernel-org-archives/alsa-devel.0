From: Rob Herring <robh+dt@kernel.org>
Subject: Re: ASoC: new ac97 bus and codec clock
Date: Wed, 20 Jun 2018 09:10:49 -0600
Message-ID: <CAL_JsqJbXGLO+xu1NZOiqmrukHKWUySv=0Sk5KDmSTLL7Mt7+Q@mail.gmail.com>
References: <87lgbdqixh.fsf@belgarion.home>
 <20180619150204.GF11230@sirena.org.uk>
 <CAL_JsqLn2t-zFi8xrig_63OD-SBq8d0jZctih38sZ4cAnRoe6g@mail.gmail.com>
 <8736xhqzmn.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B3D0266D4C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 17:11:13 +0200 (CEST)
Received: from mail-io0-f175.google.com (mail-io0-f175.google.com
 [209.85.223.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D21F620883
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 15:11:11 +0000 (UTC)
Received: by mail-io0-f175.google.com with SMTP id d22-v6so39714iof.13
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 08:11:11 -0700 (PDT)
In-Reply-To: <8736xhqzmn.fsf@belgarion.home>
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

On Wed, Jun 20, 2018 at 8:52 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh+dt@kernel.org> writes:
>
>> Like PCI, USB, SDIO, etc., you need to define an AC97 bus binding
>> which defines child node structure, compatible formatting (if you can
>> base compatibles on something like VID/PID), and addressing (reg and
>> unit-address formats). Then once you define child nodes, you can add
>> whatever sideband connections you need. The AC97 core should be able
>> to populate struct device_node if there are any matching child
>> devices.
> Ok, I thing I understand.
>
> So the device-tree will look like :
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
>         wm9713@0 {

audio-codec@0

>                 reg = <0>; /* Codex index (between 0 and 3) */
>                 compatible = "ac97-codec";

This should be something with 'wm9713' in it or if there are ID
registers you can base it on that.

>                 clocks = <&fixed_wm9713_clock>;
>                 clock-names = "ac97_clk";

This is the standard 12MHz clock?

>         }
> };
>
> And the function ac97_codec_add() will :
>  - scan the device-tree ac97 controller childs
>  - match one if its reg equals (in our case wm9713@0)
>  - set codec->dev.of_node to the matched one

Not familiar with that function, but that sounds about right.

Rob
