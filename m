From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Fri, 7 Jun 2013 10:40:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306071035130.1366-100000@iolanthe.rowland.org>
References: <1370552350.2209.41.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id 9DCEC265710
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 16:40:41 +0200 (CEST)
In-Reply-To: <1370552350.2209.41.camel@joe-AO722>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 6 Jun 2013, Joe Perches wrote:

> > How useful really is it to be able to limit the amount of debugging
> > messages at runtime?  Does anybody ever actually adjust the "debug"  
> > module parameter?
> 
> When it's a bitmask, yes.
> It then becomes similar to ethtool.

But it isn't a bitmask; it's just a level.  From 
sound/core/misc.c:__snd_printk():

#ifdef CONFIG_SND_DEBUG
	if (debug < level)
		return;
#endif

Since I have no intention of making it a bitmask at the moment, I will
presume your answer really means "No".

> > In my opinion, this is not worth the extra space required.  Virtually 
> > all the benefit of different debugging levels can be obtained by 
> > defining different symbols at compile time, such as CONFIG_SND_DEBUG 
> > and CONFIG_SND_VERBOSE_DEBUG.
> 
> I think the whole verbosity thing should be done at runtime
> via pr_debug and classifications by type via bitmasks at
> compile-time instead of the silliness of something like
> CONFIG_SND_DEBUG_VERBOSITY.

The appeal of this approach is understandable.  But it is a whole 
different project from the conversion I'm considering for now.

> > Does anybody really need a third level?
> 
> Hard to say.  There are several additional "private"
> debugging level controls for sound/...

Then they can remain private.  Takashi asked me not to change the 
existing Kconfig options, and I won't.

Alan Stern
