From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Tue, 4 Jun 2013 15:32:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306041519531.1093-100000@iolanthe.rowland.org>
References: <s5h61xtx6i5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id 9993B2651A3
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 21:32:04 +0200 (CEST)
In-Reply-To: <s5h61xtx6i5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 4 Jun 2013, Takashi Iwai wrote:

> I wouldn't mind but some might do :)
> 
> So we should clean up the excessive usage of snd_printk() and convert
> them to the standard printk & co at first.

This part is now done (already posted).

The next step involves snd_printd() and snd_printdd().  Although these
are clearly intended to be used for debugging messages -- that's why
the names end in 'd' -- they nevertheless take a KERN_* level
indicator.

This doesn't make much sense.  Are these debugging messages or aren't 
they?  If they are, they should always use KERN_DEBUG.

As I see it, the best thing to do is replace snd_printd() with a
dev_dbg() wrapper and eliminate the level indicators.  This will
require changing all the Makefiles; they will need to have a line
saying

ccflags-$(CONFIG_SND_DEBUG) := -DDEBUG

at the top, because dev_dbg() is defined to do nothing if DEBUG isn't 
defined as a preprocessor symbol.

Similarly, snd_printdd() can be translated to a macro that expands to 
dev_dbg when CONFIG_SND_VERBOSE_DEBUG is enabled, and to nothing 
otherwise.

Does this seem reasonable?

Alan Stern
