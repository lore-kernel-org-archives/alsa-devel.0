From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Sat, 22 Sep 2012 21:23:25 -0600
Message-ID: <505E80AD.9050000@wwwdotorg.org>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C9496.1050307@wwwdotorg.org>
 <20120922152840.GM4495@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B97882615A7
 for <alsa-devel@alsa-project.org>; Sun, 23 Sep 2012 05:23:31 +0200 (CEST)
In-Reply-To: <20120922152840.GM4495@opensource.wolfsonmicro.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 09/22/2012 09:28 AM, Mark Brown wrote:
> On Fri, Sep 21, 2012 at 10:23:50AM -0600, Stephen Warren wrote:
>> On 09/21/2012 07:16 AM, Peter Ujfalusi wrote:
> 
>>> pinctrl_get_select() returns with a pointer to struct pinctrl. If the platform
>>> does not have CONFIG_PINCTRL enabled it will return with NULL.
>>> If no pinctrl has been specified for the device it will return with error
>>> (-ENODEV).
>>> Neither of these cases should be considered as error. We do print out with
>>> dev_info() to notify the developer, but having pinctrl mux should not be
>>> mandatory.
> 
>> Indeed - what about a platform like Tegra which has pinctrl enabled, yet
>> doesn't specify any pinctrl configuration for any device other than the
>> pin controller itself? Do we want to force every device into having to
>> specify an empty pin control configuration? If we take this route, we
>> should really have the driver core or platform bus set up the initial
>> pinctrl state, and I believe that approach was explicitly decided against.
> 
> Well, the other options are for pinctrl to either not return an error in
> the no configuration case or change to a void return type.  The current
> behaviour seems a bit pointless since we can't usefully do anything with
> the errors, we can just factor the error logs into the core and have
> done with it since it's not possible to treat errors as such.

(I'm not 100% sure if everyone agrees on this and I'm not sure if it's
been explicitly stated, so perhaps this is my personal opinion. However,
the more I think about this, the more it makes sense).

I think the errors shouldn't be ignored at all; it's an error for a
driver to explicitly go out and request a pinctrl state if that state is
not defined. In turn, this means that no generic code should be going
out and requesting a pinctrl state on behalf of the driver; it has no
idea if the driver has defined that it needs pinctrl set up for it.

I'll explain this in a slightly different way that will probably make
more sense.

For any pinctrl configuration that is static, that configuration should
be applied one time as the system boots using the "hog" feature of the
pin controller itself, i.e. the pin controller driver should apply that
state during its own probe(). Individual drivers should only ever
request a pinctrl state if they need to dynamically switch between
different states at run-time. This is (a) likely to be fairly rare, and
(b) the need is likely to be defined directly by the kind of protocol
that the driver/HW is implementing.

So in other words, I'd expect to see an almost complete system-wide
"default" pinctrl state defined for the pin controller, and quite
possibly no other drivers with pinctrl states defined at all.

Drivers that might switch between pinctrl states are say
I2C/SPI/MDIO/... bus muxes that use an SoC's pinctrl module to perform
the muxing, or perhaps some kind of high-speed data bus that might need
different pin configuration (say biasing/equalization/... stuff rather
than muxing) based on the runtime-selected bus clock.

Given all this, that probably means that none of your (Peter's) DAI
drivers need to touch pinctrl at all, so this patch isn't needed in any
form?
