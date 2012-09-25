From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Tue, 25 Sep 2012 13:43:21 +0200
Message-ID: <CACRpkdaqQoh+MUjMqjPuPZLzdjyv7Z9p8YsQuZy7Rd75ZnRUBA@mail.gmail.com>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C9496.1050307@wwwdotorg.org>
 <20120922152840.GM4495@opensource.wolfsonmicro.com>
 <505E80AD.9050000@wwwdotorg.org>
 <CACRpkdbewb0SVYJoT9O4PAajFWny+YOcmf2CLUKL1NzxGWoa5A@mail.gmail.com>
 <20120924101757.GC21375@opensource.wolfsonmicro.com>
 <CACRpkdZKL62n02maO7CJ4Q1mNFW+=nTFOF1CWcs3b1Od3mGBbg@mail.gmail.com>
 <20120925111146.GC4428@opensource.wolfsonmicro.com>
 <50619467.3040203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id DF8342615FE
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 13:43:21 +0200 (CEST)
Received: by vbbfn1 with SMTP id fn1so6739726vbb.38
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 04:43:21 -0700 (PDT)
In-Reply-To: <50619467.3040203@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

NOTE: can someone relay me the original patch in this thread or
cross-post it to linux-kernel since that is where it obviously
needs to be discussed? I'm not on alsa-devel... (OK I will subscribe...)

On Tue, Sep 25, 2012 at 1:24 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> But the pinctrl could be used to change the mux runtime. For example in OMAP
> for most of the audio related pins we need to select MODE0 mux configuration
> in order to route the signal to the pin. However the same pin can be
> configured to SAFE_MODE which disconnects the pin from outside.
> During audio activity we obviously need to configure these pins to MODE0 but
> when there is not activity we could set them to SAFE_MODE which could result
> some power savings (preventing leakage, etc).
>
> For this to work it would be ideal to use the pm_runtime as a centralized
> place to handle clocks, pinctrl, etc...

So this is exactly what we are doing for the ux500 and implementing in most
of the AMBA devs.

We even have standard names for it in the pinctrl subsystem - the modes
named "default" and "sleep" or maybe "idle" if you also have a separate
"sleep" state apart from the relaxed state.
(include/linux/pinctrl/pinctrl-state.h).

So we go into "default" when the device is in use and relax it by going
into "sleep" whenever we can.

> But again, what to do with the cases when this is not needed (the pinctrl part
> for the devices)?

This is too unspecific for me, sorry... are you thinking about Stephen's
preference to do this using hogs or of systems not using pinctrl at all?
(They should be safe since not configuring pinctrl means it gets stubbed out.)

Yours,
Linus Walleij
