From: Rob Herring <robh+dt@kernel.org>
Subject: Re: ASoC: new ac97 bus and codec clock
Date: Tue, 19 Jun 2018 11:56:41 -0600
Message-ID: <CAL_JsqLn2t-zFi8xrig_63OD-SBq8d0jZctih38sZ4cAnRoe6g@mail.gmail.com>
References: <87lgbdqixh.fsf@belgarion.home>
 <20180619150204.GF11230@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 10278266D4C
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 19:57:04 +0200 (CEST)
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com
 [209.85.214.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A1EDD2083D
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 17:57:02 +0000 (UTC)
Received: by mail-it0-f50.google.com with SMTP id 76-v6so1640018itx.4
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 10:57:02 -0700 (PDT)
In-Reply-To: <20180619150204.GF11230@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Frank Rowand <frowand.list@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 19, 2018 at 9:02 AM, Mark Brown <broonie@kernel.org> wrote:
> On Sun, Jun 17, 2018 at 10:03:54PM +0200, Robert Jarzmik wrote:
>
>> The new ac97 is working well in a platform data build. But in the device tree
>> case, there is an issue, triggered by our review in [1].
>
>> The main issue is the lack of one clock.
>
>> The device hierarchy is :
>>  - platform device sound@40500000 (the AC97 controller)
>>    \-> ac97 device sound@40500000:0 (the discovered ac97 IP for a wm9713)
>
>> Now the issue is here :
>>  - sound/ac97/bus.c:419, function ac97_get_enable_clk()
>>  - the clk_get() fails
>
>> The sound@40500000:0 device was automatically created by the AC97 bus code, but
>> I don't see any way to provide this device the "ac97_clk" ... How do you think
>> this is supposed to work, and how can my devicetree description provide this
>> clock ?

So the clock is a sideband signal outside the scope of AC97? If so...

> This sounds like a DT question - how do you hook things up using DT to a
> device that will be enumerated from the hardware?  I'm not sure what
> best practice is here, adding Rob and Frank.

Like PCI, USB, SDIO, etc., you need to define an AC97 bus binding
which defines child node structure, compatible formatting (if you can
base compatibles on something like VID/PID), and addressing (reg and
unit-address formats). Then once you define child nodes, you can add
whatever sideband connections you need. The AC97 core should be able
to populate struct device_node if there are any matching child
devices. It gets a bit more complicated if you need to do things like
enable power or de-assert resets to discover the devices. Sounds like
that might be the next person's problem in this case. :)

Rob
