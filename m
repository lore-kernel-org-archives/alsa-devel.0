From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH v2] intel8x0m: wait a bit before warm reset check
Date: Sun, 6 Mar 2011 01:12:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103060105550.6297@swampdragon.chaosbits.net>
References: <1299366106.2470.5.camel@t41.thuisdomein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1299366106.2470.5.camel@t41.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, 6 Mar 2011, Paul Bolle wrote:

> At every resume a laptop I use prints this message (at KERN_ERR level):
>     ALSA sound/pci/intel8x0m.c:904: AC'97 warm reset still in progress? [0x2]
> 
> The thing to note here is that 0x2 corresponds to ICH_AC97COLD. Ie, what
> seems to be happening is that the register involved indicated a warm
> reset for some time (as the ICH_AC97WARM bit was set) but by the time
> the warning is printed, and that same register is checked again, that
> bit is already cleared and only the ICH_AC97COLD bit is still set.
> 
> It turns out a warm reset needs some time to settle, but it is currently
> checked right away. The test therefore fails the first time it is done
> and schedule_timeout_uninterruptible() will be called. Once we return
> from that jiffies is already (far) past end_time on this laptop, so we
> exit the loop, print a warning, and exit the function while the warm
> reset actually succeeded.
> 
> One way to fix this is to call udelay() after writing to the register
> involved. A handful of tests suggests 500 usecs is a safe value. (This
> might punish the "finish cold reset" case, but on this laptop such a
> cold reset apparently never happens, so I can't say for sure.)
> 
> While we're at it drop the extra single tick from end_time, as it looks
> rather silly.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) v1 was called " intel8x0m: schedule timeout before warm reset check".
> 
> 1) A udelay of 250 usecs always failed while 300 usecs always worked. So
> 500 usecs might be a bit cautious.
> 

Wouldn't it be nice to put these notes in a comment in the code so that 
future readers don't have to scratch their heads and wonder where the 
udelay() with some magical constant comes from?

Also, if udelay(300) always worked in your tests, wouldn't udelay(400) be 
more than enough to provide a nice fat safety margin (33% more than 
"always works")? Are there no official documents that specify how long 
this is expected to take that we could base this delay on instead of just 
testing on one system?

-- 
Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
Plain text mails only, please.
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
