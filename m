From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 19:46:13 +0200
Message-ID: <4E738B65.6080802@metafoo.de>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>	<s5hwrd8jy68.wl%tiwai@suse.de>
	<4E736F9B.6080206@freescale.com> <4E7378E2.9050200@metafoo.de>
	<4E737A89.8090509@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A59010396C
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 19:46:42 +0200 (CEST)
In-Reply-To: <4E737A89.8090509@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 09/16/2011 06:34 PM, Timur Tabi wrote:
> Lars-Peter Clausen wrote:
>> You mentioned in an earlyer mail that you can switch the sysclk rate at
>> runtime. So setting the constraints based on the current sysclk rate won't
>> really work. I think you need some mechanism to specify the supported rates on
>> a per machine driver basis.
> 
> Exactly.  There are some other problems with getting the dynamic sysclk feature
> working.  On the board where this is supported, the same clock is connected to
> adcmclk and dacmclk, so I can't support playback at 48KHz and capture at
> 44.1KHz.  However, there's nothing stopping a customer from creating a board
> that has two independent clocks.
> 
> So in the meantime, I'd really just like the ability to specify in the codec
> driver's .startup function exactly which sample rates are supported (based on
> the current mclk).
> 

You can already do this. Though you'd limit your CODEC driver to the use-case
where only one fixed sysclk is used. This might be a problem if other people
were using the same CODEC and want to use it without this limitation.

>> Machine drivers are currently best placed to set constraints if the
>> clocking is limited.
>
> But how is the machine driver supposed to know what those sample rates are? >
It would need to know how which dividers that codec uses.  That would mean
> that the machine driver has to be hard-codec with information on the
> internals of the codec.

How do you know which sysclk rate to select for a given sample rate, if you
don't know the samples rates the CODEC can produces for a given sysclk rate?

So ideally the CODEC driver would have callback which you could pass a set of
sysclk ranges the machine driver can supply and the CODEC driver would return a
list of sample rates it can support for this sysclk rate range. And then you
could use this updated list in your machine driver to decide which sysclk rate
to select. But I'm not sure if this isn't to over-engineered and hard-coding
this table into the machine driver wouldn't be better.
