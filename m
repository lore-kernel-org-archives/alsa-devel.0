From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [alsa-devel] [PATCH 1/15] sound/soc/mxs/mxs-saif.c: add missing
 iounmap
Date: Sat, 28 Jan 2012 09:51:46 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1201280950120.2045@hadrien>
References: <7FE21149F4667147B645348EC605788508FBDB@039-SN2MPN1-013.039d.mgd.msft.net> <alpine.DEB.2.02.1201241828480.1779@localhost6.localdomain6> <20120124202203.GD1135@opensource.wolfsonmicro.com> <alpine.DEB.2.02.1201242144580.1998@hadrien>
 <20120126110506.GB2611@pengutronix.de> <alpine.DEB.2.02.1201261220460.1851@localhost6.localdomain6> <20120126112242.GA9401@opensource.wolfsonmicro.com> <alpine.DEB.2.02.1201261439460.1851@localhost6.localdomain6> <20120126135135.GD2611@pengutronix.de>
 <alpine.DEB.2.02.1201261504200.1851@localhost6.localdomain6> <20120128082630.GA2509@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120128082630.GA2509@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dong Aisheng-B29396 <B29396@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 28 Jan 2012, Wolfram Sang wrote:

>>> You can skip checking 'iores', too. I also did that in the example, but
>>> a lot of people seem to miss it.
>>
>> I can try to do that, but it seems a little bit unintuitive.
>> Perhaps it would be easier for people to remember to put in error
>> handling code when they need it if they always have to do it?  If I
>> remove it, there will be one call that has no test and then another
>> call a few lines later that does.
>
> I see your point. I would still like to get rid of the duplicated code
> (then it can't be forgotten as well). Maybe I should have named the
> function something alike devm_check_and_request_and_ioremap()? Then I
> could have also introduced a similar function for requesting irq. Will
> think about this a bit more. Thanks for updating your patch!

Despite believing in my point, error handling code is where people make a 
lot of mistakes.  Getting rid of it seems always to be a good idea.  Maybe 
such checks could be moved into more uses of the result of 
platform_get_resource.

julia
