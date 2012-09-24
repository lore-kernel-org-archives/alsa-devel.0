From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Mon, 24 Sep 2012 10:34:50 +0200
Message-ID: <CACRpkdZ=_qm-g-LDth8m43Cug4LoMsD3FuvTiiyQgP=chGTAUw@mail.gmail.com>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C9496.1050307@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A50FA261631
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 10:34:50 +0200 (CEST)
Received: by wibhq4 with SMTP id hq4so3448034wib.2
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 01:34:50 -0700 (PDT)
In-Reply-To: <505C9496.1050307@wwwdotorg.org>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 21, 2012 at 6:23 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 09/21/2012 07:16 AM, Peter Ujfalusi wrote:
>>
>> pinctrl_get_select() returns with a pointer to struct pinctrl. If the platform
>> does not have CONFIG_PINCTRL enabled it will return with NULL.
>> If no pinctrl has been specified for the device it will return with error
>> (-ENODEV).
>> Neither of these cases should be considered as error. We do print out with
>> dev_info() to notify the developer, but having pinctrl mux should not be
>> mandatory.
>
> Indeed - what about a platform like Tegra which has pinctrl enabled, yet
> doesn't specify any pinctrl configuration for any device other than the
> pin controller itself?

It would be fixed by calling pinctrl_provide_dummies() right?

Not that it's elegant or anything ...

What it all boils down to in the end (IMO) is whether a centralized or
decentralized approach to the control handles should be used. The same
problem will arise with runtime PM I think.

For example the shmobile will get and gate all it's clocks in a
centralized fashion in
drivers/base/power/clock_ops.c,
and this doesn't work with all other systems so in other drivers
you find clk_prepare/enable/disable/unprepare distributed in the
drivers.

(I think someone could attempt to do the same thing with regulators
with the same centralization failure, we know regulator voltages
need to be switched at runtime, take an SD card and centralized
regulators breaks apart immediately.)

Some time I thought the level of centralization may be dependent on
actual hardware architecture, that the centralized approach would
work for some. I'm not so sure anymore...

For advanced pin configuration, where we (in ux500) need to switch
pins from default to sleep state at runtime to save power, it doesn't
work do do it with hogs, we need to distribute it, because the pinctrl
driver doesn't know when the UART wants to go to sleep (which is
not always the same as when the system as a whole wants to
sleep, incidentally) so in this case the decentralized approach is
the only thing that works. We are now merging the same approach
to our SPI driver, and plan to continue with I2C etc. We really want
to relax the pins for these blocks between individual transfers,
sometimes with delayed autosuspend via runtime PM to avoid
jittering.

I don't know if this helps anything for this ASoC case though :-/

Yours,
Linus Walleij
