From: Liam Girdwood <lrg@ti.com>
Subject: Re: soc-dsp questions
Date: Mon, 13 Jun 2011 19:01:01 +0100
Message-ID: <4DF6505D.9000402@ti.com>
References: <BANLkTi=jmoZOvxe=29Et=C6YYHrFZ58evw@mail.gmail.com>	<1303810865.3332.57.camel@odin>	<20110426101848.GA23812@sirena.org.uk>	<4DF1C08F.90306@codeaurora.org>	<20110610094226.GA26436@opensource.wolfsonmicro.com>	<4DF2C2BD.6050505@codeaurora.org>	<20110611114806.GD2738@opensource.wolfsonmicro.com>
	<4DF5982C.6070705@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 01F7B243BE
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 20:01:10 +0200 (CEST)
In-Reply-To: <4DF5982C.6070705@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "waiw@codeaurora.org" <waiw@codeaurora.org>, pl bossart <bossart.nospam@gmail.com>, "asishb@codeaurora.org" <asishb@codeaurora.org>, "jaywang@codeaurora.org" <jaywang@codeaurora.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 13/06/11 05:55, Patrick Lai wrote:
>>> Are you referring to fixup function in the machine driver? It works for
>>> hardware parameter that is fixed per machine. For example, regardless
>>> sample rate of front-ends that are routed to same back-end,
>>> back-end sample rate is fixed to 48KHz. I am already taking advantage
>>> of the hook.
>>
>> Yes.  Since it's code it *could* do conditional things based on some
>> setting if it needs to.
>>
> Yes, I don't see any better way unless propagating knowledge of 
> front-end/back-end all the way to user-space. I plan on adding 
> enumeration of
> channel mode in machine driver which sets variable read by the fix up
> function. So, CPU and CODEC drivers do not need to provide enumeration
> of channel modes. However, same control would have to be added to every
> machine driver.

Ok, sounds like this may be useful code for other DSPs too.

Fwiw, OMAP4 fixups are based on physical BE DAI so we always use the same config for each BE DAI atm, but flexibility would be good.

Liam 
