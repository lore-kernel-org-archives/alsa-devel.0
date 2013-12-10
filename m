From: Paul Walmsley <pwalmsley@nvidia.com>
Subject: Re: [PATCH] ALSA: at73c213: clk_round_rate() can return a zero upon
 error
Date: Tue, 10 Dec 2013 11:46:43 -0800
Message-ID: <alpine.DEB.2.02.1312101054570.4127@tamien>
References: <alpine.DEB.2.02.1312091837280.4127@tamien> <s5hzjo9p2ap.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hzjo9p2ap.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jaroslav Kysela <perex@perex.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Dec 2013, Takashi Iwai wrote:

> At Mon, 9 Dec 2013 18:40:48 -0800, Paul Walmsley wrote:
>>
>> Treat both negative and zero return values from clk_round_rate()
>> as errors.  This is needed since subsequent patches will convert
>> clk_round_rate()'s return value to be an unsigned type, rather
>> than a signed type, since some clock sources can generate rates higher
>> than (2^31)-1 Hz.
>
> Is the behavior "returning zero upon error" already in 3.13?  That is,
> should this (and another) patch be taken as a 3.13-fix patch, or it's
> for 3.14?

It depends on the platform.  The Common Clock Framework code returns 0 
upon error right now.  But other clock framework implementations, such as 
the one used by the Atmel AT91 boards, return negative error codes.  And 
looking at the mainline code, it looks like the at73c213 chip is most 
likely to be used on AT91 boards.

So if you want to send this patch for v3.13-rc, it's probably justified,
but it's low-priority.  v3.14 is also fine.

I'll be sending some followup patches to the platform maintainers to 
change the clock framework code to return 0 upon error.  But those can't 
be applied until the drivers are fixed, if we want to avoid regressions in 
error path handling.  So from that point of view, applying these driver 
patches in v3.13-rc would mean there is less delay to getting the platform 
clock framework fixes upstream :-)


- Paul
