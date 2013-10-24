From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Is that reasonable to support pinctrl PM in ASoC
	core?
Date: Thu, 24 Oct 2013 15:19:03 +0200
Message-ID: <CACRpkdYi71eKxBeutpjPKc-FzCALKiVpq3WQq07xJKgB-HDyHQ@mail.gmail.com>
References: <20131024110743.GD8385@MrMyself>
 <20131024115224.GD18506@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f180.google.com (mail-ob0-f180.google.com
 [209.85.214.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 59D63260890
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 15:19:05 +0200 (CEST)
Received: by mail-ob0-f180.google.com with SMTP id wo20so2286452obc.11
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 06:19:04 -0700 (PDT)
In-Reply-To: <20131024115224.GD18506@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <b42378@freescale.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 24, 2013 at 1:52 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 24, 2013 at 07:07:43PM +0800, Nicolin Chen wrote:
>
>> And I think this pinctrl PM might be also beneficial to cpu dai drivers
>> since they might have actual pins, and they can hypnotize/wake them up
>> along with runtime PM:
>
> I think you're right that this is a useful and obvious feature but the
> question I have is that since the standard implementation is going to be
> to do the pinctrl calls in lockstep with the runtime PM handling and
> since this is likely to be the same for pretty much any subsystem might
> it be better to add the hooks at the runtime PM level rather than in the
> subsystem?  Or perhaps we should just add them in subsystems and then
> once some reasonable number of subsystems have done this then pull it
> into the PM core?

This makes a lot of sense, the only problem I have traditionally had
with this is that there exist cases where you want to put pinctrl
handles to sleep or idle aside from runtime PM.

For example:

- UARTs disabled from userspace shall have their pins put to
  sleep (see drivers/tty/serial/uart-pl011.c)

- I2C or SPI hosts with no devices connected to them should be
  nailed to sleep. (It's not possible to detect an unused I2C or SPI
  host today, but a feature we should add.)

Maybe the right way to do these is also to use runtime_pm*,
but the thing is that today these things are done also when
CONFIG_PM_RUNTIME is not set. Which is something you
might sometimes want.

Or not? Should we say that unless you have
CONFIG_PM_RUNTIME you don't deserve saving these
microamps anyway?

Yours,
Linus Walleij
