From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Thu, 06 Jun 2013 14:50:32 -0700
Message-ID: <1370555432.2209.55.camel@joe-AO722>
References: <Pine.LNX.4.44L0.1306061654270.878-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 28C47261AEC
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 23:50:34 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1306061654270.878-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-06-06 at 17:28 -0400, Alan Stern wrote:
> The important point is that these files are _drivers_; what matters at
> runtime is the device name.  On systems with more than one sound card
> of the same type, the device name is vital, but even on others it still
> helps a lot.
> 
> What I want to do is make the messages include the device and driver
> names.  Basically this means calling dev_info() and friends instead of
> "snd_printk(KERN_INFO" or pr_info().  As part of the fallout from this
> change, it should no longer be necessary to print the filename or
> module name.  If a driver contains multiple identical messages, they
> can be made non-identical (assuming it really matters; messages like
> "can't allocate memory" usually don't need to be pinned down exactly).  
> Line numbers are even less useful because they can change from one
> kernel version to the next.
> 
> I can't convert the entire sound subsystem at once -- it's way too big.  
> But I can at least do the sound/usb subsystem.  If this means that two
> different logging APIs are used by different sets of sound drivers, so
> be it.
> 
> In theory, this would be more or less independent of the patches posted 
> so far.  In fact, when taken to its logical extreme, _all_ the messages 
> would use dev_*() or some variant.  There wouldn't be any snd_printk(), 
> snd_printd(), pr_info(), ... messages left to worry about.
> 
> I don't expect that to happen any time soon.  Still, I think it makes
> more sense to concentrate on converting the messages below sound/usb
> rather than fiddling around with the existing API, which is inadequate
> anyway since it doesn't include the device.

I agree with that.

It'd be pretty easy to take that large patch that did
snd_printk(fmt, ...) -> snd_dbg(1, fmt, ...) and
convert it to snd_card_dbg(card *, fmt, ...)
whenever a struct snd_card * was available.

snd_card_dbg() would be either a macro or a function
to deference the snd_card * dev and maybe emit
"struct snd_card.shortname" with it too.

Want to start with that?
