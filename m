From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Thu, 06 Jun 2013 13:59:10 -0700
Message-ID: <1370552350.2209.41.camel@joe-AO722>
References: <Pine.LNX.4.44L0.1306061636520.878-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 78A25261ABB
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 22:59:13 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1306061636520.878-100000@iolanthe.rowland.org>
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

On Thu, 2013-06-06 at 16:42 -0400, Alan Stern wrote:
> On Tue, 4 Jun 2013, Joe Perches wrote:
> 
> > On Tue, 2013-06-04 at 16:54 -0400, Alan Stern wrote:
> > > I don't see how DEFAULT_DEBUG_LEVEL can be used to optimize away
> > > anything.  The user can always change the value of the "debug" module
> > > parameter while the system is running.  The only valid opportunity for
> > > optimization would be if CONFIG_SND_DEBUG was disabled; then all these 
> > > messages would disappear.
> > 
> > Not really.
> > 
> > Think of CONFIG_SND_DEBUG as a level. (0, 1, 2)
> > or maybe think of it as CONFIG_SND_DEBUG_VERBOSITY.
> > 
> > There could still be ability to have CONFIG_SND_DEBUG
> > limit the compiled-in messages to those below the
> > #define value and still then have runtime control over
> > which ones are displayed.
> 
> How useful really is it to be able to limit the amount of debugging
> messages at runtime?  Does anybody ever actually adjust the "debug"  
> module parameter?

When it's a bitmask, yes.
It then becomes similar to ethtool.

> In my opinion, this is not worth the extra space required.  Virtually 
> all the benefit of different debugging levels can be obtained by 
> defining different symbols at compile time, such as CONFIG_SND_DEBUG 
> and CONFIG_SND_VERBOSE_DEBUG.

I think the whole verbosity thing should be done at runtime
via pr_debug and classifications by type via bitmasks at
compile-time instead of the silliness of something like
CONFIG_SND_DEBUG_VERBOSITY.

> Does anybody really need a third level?

Hard to say.  There are several additional "private"
debugging level controls for sound/...
