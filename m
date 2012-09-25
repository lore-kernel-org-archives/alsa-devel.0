From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Tue, 25 Sep 2012 11:00:33 -0600
Message-ID: <5061E331.2000303@wwwdotorg.org>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C9496.1050307@wwwdotorg.org>
 <20120922152840.GM4495@opensource.wolfsonmicro.com>
 <505E80AD.9050000@wwwdotorg.org>
 <CACRpkdbewb0SVYJoT9O4PAajFWny+YOcmf2CLUKL1NzxGWoa5A@mail.gmail.com>
 <20120924101757.GC21375@opensource.wolfsonmicro.com>
 <CACRpkdZKL62n02maO7CJ4Q1mNFW+=nTFOF1CWcs3b1Od3mGBbg@mail.gmail.com>
 <20120925111146.GC4428@opensource.wolfsonmicro.com> <50619467.3040203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 7270126173C
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 19:00:38 +0200 (CEST)
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
Cc: Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09/25/2012 05:24 AM, Peter Ujfalusi wrote:
> On 09/25/2012 02:11 PM, Mark Brown wrote:
>> On Mon, Sep 24, 2012 at 04:37:23PM +0200, Linus Walleij wrote:
>>> On Mon, Sep 24, 2012 at 12:17 PM, Mark Brown
>>
>>>> Well, the problem here is that people keep wanting to add one shot
>>>> pinctrl calls in drivers which clearly suggests that it ought to be
>>>> factored out.
>>
>>> OK so can we find some suitable middle ground here?
>>
>>> Something like drivers could add some boolean flag to
>>> "opt-in" for the core to handle this or so?
>>
>> Well, I don't know if we need to - it sounds like the platforms that are
>> running around adding these pinctrl calls to all the drivers are doing
>> it wrong and should be fixed.
> 
> In the scope of audio...
> I guess it is one thing to use the pinctrl framework to configure the mux for
> the pins (which was the original idea of the patch). This should be taken care
> in some centralized place, I agree.
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
> But again, what to do with the cases when this is not needed (the pinctrl part
> for the devices)?

Maybe it can be opt-in, like pm_runtime support at all, e.g. a driver
that supports it can:

pm_runtime_enable_pinctrl(dev, pinctrl_state_name);

where if pinctrl_state_name==NULL, it uses PINCTRL_STATE_IDLE. (Making
this a parameter would allow for devices that use a more complex set of
states where the default state names may not be appropriate). Perhaps we
could phase that in if/when needed, by introducing
pm_runtime_enable_pinctrl(dev) first, then adding
pm_runtime_enable_pinctrl_state(dev, state) later?

Of course, I suppose that only really addresses the case where the
IP/driver itself knows if/when to enable this feature - if an I2S IP
block is used in 10 different SoCs, and runtime pinctrl is only useful
on 5 of them, how does it know when to make that call?
