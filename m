From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 5/5] ASoC: add support for the Freescale /
 iVeia P1022 RDK reference board
Date: Wed, 19 Sep 2012 10:17:10 -0500
Message-ID: <5059E1F6.7080804@freescale.com>
References: <1347657278-25295-1-git-send-email-timur@freescale.com>
 <1347657278-25295-5-git-send-email-timur@freescale.com>
 <20120919023259.GB8832@opensource.wolfsonmicro.com>
 <6AE080B68D46FC4BA2D2769E68D765B70805EFB4@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120919031209.GS8832@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 by alsa0.perex.cz (Postfix) with ESMTP id AACD92651FE
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 17:17:31 +0200 (CEST)
In-Reply-To: <20120919031209.GS8832@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> It's adding a new machine driver, that generally means a new binding.

Not for the way I defined the SSI bindings.  All of the information is
stored in the SSI and codec nodes.  That's why I did it that way.  There
is no binding for the machine driver.

> If it's really an identical binding then it ought to at least add a new
> compatible property to the existing binding (and extend the set of
> supported CODECs for that binding).

Here's the device tree:

http://git.kernel.org/?p=linux/kernel/git/galak/powerpc.git;a=blob;f=arch/powerpc/boot/dts/p1022rdk.dts;h=51d82de223f37c12dfbb33906cac89ce551abcd2;hb=34f84b5b5bc83f4fc208cc278f572e6d926f976b

The only thing that's new is a node for the wm8960.  I could create a
binding for that.  I asked you in a previous email about the binding for
that codec, but you never replied.

> Personally given the thing with the interface formats and the fact that
> it's not sharing code with the other bindings for implementation of the
> binding I'd be inclined to just document it as a new binding and use it
> as the model going forwards, leaving the older bindings as legacy.

Again, the only new binding is the codec.

>>>> +	/* Tell the WM8960 to set SYSCLK equal to MCLK input (bypass PLL) */
>>>> +	ret = snd_soc_dai_set_clkdiv(rtd->codec_dai, WM8960_SYSCLKDIV,
>>>> +		WM8960_SYSCLK_MCLK | WM8960_SYSCLK_DIV_1);
>>>> +	if (ret < 0) {
>>>> +		dev_err(dev, "could not set codec driver clock source\n");
>>>> +		return ret;
>>>> +	}
> 
>>> ...we don't appear to use the PLL output anyway so why not just leave it
>>> off?  As this is fixed it's better style to do the setup in late_init()
>>> or the init function for the DAI link.
> 
>> I just copied this code from iVeia BSP.  I'm not really sure what it does.
> 
> You should just be able to drop the call to set_pll(), I expect you'll
> find that all it does is consume extra power.

Ok, I'll try it.  I have no way to measure power consumption, however.

>> I almost never do this, and there are plenty of cases in my existing code 
>> where I don't.  Is this a new policy?
> 
> It's not new, it's always been good practice - if something fails we
> should do as much as possible to tell the user why.

Ok.

>> This is the same code as my other two machine drivers that I've been using 
>> for years.  It's part of the SSI binding.  Do you want me to change the 
>> binding and drop the properties?
> 
> Well, the existing bindings are out there so can't really be changed but
> we should do something better going forwards.

Fair enough.  I created those bindings because, back then, I had no idea
whether they would be needed or not.  Now that I've created three boards
that use the SSI, I see that it's not helpful.  I can fix that.

-- 
Timur Tabi
Linux kernel developer at Freescale
