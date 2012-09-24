From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Mon, 24 Sep 2012 11:20:16 +0200
Message-ID: <CACRpkdbewb0SVYJoT9O4PAajFWny+YOcmf2CLUKL1NzxGWoa5A@mail.gmail.com>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C9496.1050307@wwwdotorg.org>
 <20120922152840.GM4495@opensource.wolfsonmicro.com>
 <505E80AD.9050000@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D86FB2602F9
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 11:20:16 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so3555507wgb.20
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 02:20:16 -0700 (PDT)
In-Reply-To: <505E80AD.9050000@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 23, 2012 at 5:23 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> I think the errors shouldn't be ignored at all; it's an error for a
> driver to explicitly go out and request a pinctrl state if that state is
> not defined. In turn, this means that no generic code should be going
> out and requesting a pinctrl state on behalf of the driver; it has no
> idea if the driver has defined that it needs pinctrl set up for it.

This makes perfect sense to me, right now atleast.

So the problem with the patch we're discussing is that it's
"too far up" in the framework, and handling pinctrl should be done
somewhere below.

> For any pinctrl configuration that is static, that configuration should
> be applied one time as the system boots using the "hog" feature of the
> pin controller itself,

Agreed. Even in the docs luckily :-)

> i.e. the pin controller driver should apply that
> state during its own probe(). Individual drivers should only ever
> request a pinctrl state if they need to dynamically switch between
> different states at run-time. This is (a) likely to be fairly rare,

The Ux500 smash this completely by having almost no static
configurations at all and needing to switch everything at runtime,
tied in with runtime PM. This is how we save some microamps.

Sorry for this, I'm happy for you if Tegra is simpler to handle for
low-power :-)

> and
> (b) the need is likely to be defined directly by the kind of protocol
> that the driver/HW is implementing.

Yes. This is 100% true. It needs to be close to the driver and
its subsystem. (I don't know if the patch under disussion is at
the right level, seems controversial...)

> So in other words, I'd expect to see an almost complete system-wide
> "default" pinctrl state defined for the pin controller, and quite
> possibly no other drivers with pinctrl states defined at all.

Hehe not for us :-)

Yours,
Linus Walleij
