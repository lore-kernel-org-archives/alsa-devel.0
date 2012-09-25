From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Tue, 25 Sep 2012 13:56:13 +0200
Message-ID: <CACRpkdb3yA9Ued8nv59K+ct4BKmn2k53QXB16qTzQ21t2nvrhA@mail.gmail.com>
References: <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C9496.1050307@wwwdotorg.org>
 <20120922152840.GM4495@opensource.wolfsonmicro.com>
 <505E80AD.9050000@wwwdotorg.org>
 <CACRpkdbewb0SVYJoT9O4PAajFWny+YOcmf2CLUKL1NzxGWoa5A@mail.gmail.com>
 <20120924101757.GC21375@opensource.wolfsonmicro.com>
 <CACRpkdZKL62n02maO7CJ4Q1mNFW+=nTFOF1CWcs3b1Od3mGBbg@mail.gmail.com>
 <20120925111146.GC4428@opensource.wolfsonmicro.com>
 <50619467.3040203@ti.com>
 <20120925114352.GE4428@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DCE92616E7
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 13:56:14 +0200 (CEST)
Received: by vbbfn1 with SMTP id fn1so6750317vbb.38
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 04:56:13 -0700 (PDT)
In-Reply-To: <20120925114352.GE4428@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 25, 2012 at 1:43 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Sep 25, 2012 at 02:24:23PM +0300, Peter Ujfalusi wrote:
>>
>> For this to work it would be ideal to use the pm_runtime as a centralized
>> place to handle clocks, pinctrl, etc...
>> But again, what to do with the cases when this is not needed (the pinctrl part
>> for the devices)?
>
> It's also not massively clear to me that generic pm_runtime code is a
> good place to put all this stuff - it's too coarse grained for a lot of
> things.

I tend to agree. If you think of things like the clock handling in
drivers/base/power/clock_ops.c that shmobile is relying upon.
This is just not working with our platforms because different
drivers need different semantics.

In ux500 drivers we use *specific* (as opposed to generic) runtime PM
code to e.g. get some hysteresis before a drivers clock and pins
(etc) are put to sleep. Pure driver business.

So these are runtime suspend/resume calls in the driver itself.

>  Devices that can be wake sources are an example here, if they
> are doing that then turning them completely off may break functionality
> but you can still turn some of the device (possibly a varying selection
> depending on usage) off.  For simple cases it works well and it'd be
> good to have it but you end up back into ignoring errors...

Our ux500 "sleep" state on the pins will put them into the apropriate
wakeup mode where applicable. Since this may vary across boards
it's even machine-specific.

Configuring wakeup sources when going to a state named "sleep"
seems intuitive to me atleast.

Then we have this (currently unused) "idle" state, which is intended
as a power-saving state without going to sleep. So this is for the
case when the system needs to be relaxed on power but not
yet put to sleep. On some systems and for some drivers this
state and the "sleep" state will likely be the same, but I'm
just philosophizing here.

These are just defined as strings in
include/linux/pinctrl/pinctrl-state.h
with some kind of semantics.

The pinctrl handle can be moved into any state at any time,
it's not like it's a state machine or something, so the subsystems
and drivers need to know what they are doing.

Yours,
Linus Walleij
