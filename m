From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Tue, 4 Jun 2013 16:54:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306041646240.1093-100000@iolanthe.rowland.org>
References: <1370375134.2385.64.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id CBDAB261A86
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 22:54:14 +0200 (CEST)
In-Reply-To: <1370375134.2385.64.camel@joe-AO722>
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

On Tue, 4 Jun 2013, Joe Perches wrote:

> A somewhat common convention is to use
> 
> 	prefix_dbg(level, fmt, ...)
> 
> where level is either a numeric value or bitmask,
> and also is either a #define or a MODULE_PARAM
> 
> today sound/misc.c has:
> 
> ------------------------------------------
> 
> #ifdef CONFIG_SND_DEBUG
> 
> #ifdef CONFIG_SND_DEBUG_VERBOSE
> #define DEFAULT_DEBUG_LEVEL	2
> #else
> #define DEFAULT_DEBUG_LEVEL	1
> #endif
> 
> static int debug = DEFAULT_DEBUG_LEVEL;
> module_param(debug, int, 0644);
> MODULE_PARM_DESC(debug, "Debug level (0 = disable)");
> 
> #endif /* CONFIG_SND_DEBUG */

Yes, I have read this part of the code.

> ------------------------------------------
> 
> I suggest converting all the remaining
> 
> snd_printd(...) to snd_dbg(1, ...)
> and
> snd_printdd(...) to snd_dbg(2, ...)
> 
> so that debug module param control can be used for
> all these and if the DEFAULT_DEBUG_LEVEL isn't
> high enough, the various snd_dbg(2, ...) can be
> completely optimized away if appropriate.

I don't see how DEFAULT_DEBUG_LEVEL can be used to optimize away
anything.  The user can always change the value of the "debug" module
parameter while the system is running.  The only valid opportunity for
optimization would be if CONFIG_SND_DEBUG was disabled; then all these 
messages would disappear.

You didn't respond to the first point I raised.  Since these messages
are all meant for debugging, there's no point allowing them to have
prefixes like KERN_ERR or KERN_INFO.  They should always be printed at
the KERN_DEBUG level.  Or did you think this was so obviously true that
it didn't require any comment?

Alan Stern
