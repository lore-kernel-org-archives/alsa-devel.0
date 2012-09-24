From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Mon, 24 Sep 2012 09:41:22 -0600
Message-ID: <50607F22.4070903@wwwdotorg.org>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C9496.1050307@wwwdotorg.org>
 <20120922152840.GM4495@opensource.wolfsonmicro.com>
 <505E80AD.9050000@wwwdotorg.org>
 <CACRpkdbewb0SVYJoT9O4PAajFWny+YOcmf2CLUKL1NzxGWoa5A@mail.gmail.com>
 <20120924101757.GC21375@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B58832615F5
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 17:41:25 +0200 (CEST)
In-Reply-To: <20120924101757.GC21375@opensource.wolfsonmicro.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09/24/2012 04:17 AM, Mark Brown wrote:
> On Mon, Sep 24, 2012 at 11:20:16AM +0200, Linus Walleij wrote:
>> On Sun, Sep 23, 2012 at 5:23 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>>> I think the errors shouldn't be ignored at all; it's an error for a
>>> driver to explicitly go out and request a pinctrl state if that state is
>>> not defined. In turn, this means that no generic code should be going
>>> out and requesting a pinctrl state on behalf of the driver; it has no
>>> idea if the driver has defined that it needs pinctrl set up for it.
> 
>> This makes perfect sense to me, right now atleast.
> 
>> So the problem with the patch we're discussing is that it's
>> "too far up" in the framework, and handling pinctrl should be done
>> somewhere below.
> 
> Well, the problem here is that people keep wanting to add one shot
> pinctrl calls in drivers which clearly suggests that it ought to be
> factored out.
> 
>>> For any pinctrl configuration that is static, that configuration should
>>> be applied one time as the system boots using the "hog" feature of the
>>> pin controller itself,
> 
>> Agreed. Even in the docs luckily :-)
> 
> Which is one way of factoring out, though it doesn't seem to be
> universally applied (and I don't immediately see how it scales when the
> device is used in multiple SoCs some of which need runtime configuration
> and some of which don't).

Anywhere that particular device is used needs to have a pinctrl state
defined. On SoCs that need the pinctrl changed, the pinctrl state would
be populated with meaningful data. On SoCs that don't need pinctrl
changed, the pinctrl state would be empty; essentially a dummy just to
represent the fact that someone thought about the issue and decided
nothing was needed.

But I still find it unlikely that this situation will occur; surely
there's some specific reason directly related to the device itself, or
the protocol it implements, that defines whether it needs dynamic
pinctrl, and hence no matter what SoC that device is inserted into, it
will either need or not-need dynamic pinctrl. Are there any extant
examples to refute this?
