From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Tue, 04 Jun 2013 12:45:34 -0700
Message-ID: <1370375134.2385.64.camel@joe-AO722>
References: <Pine.LNX.4.44L0.1306041519531.1093-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 84B2B2651A0
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 21:45:36 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1306041519531.1093-100000@iolanthe.rowland.org>
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

On Tue, 2013-06-04 at 15:32 -0400, Alan Stern wrote:
> Similarly, snd_printdd() can be translated to a macro that expands to 
> dev_dbg when CONFIG_SND_VERBOSE_DEBUG is enabled, and to nothing 
> otherwise.
> 
> Does this seem reasonable?

A somewhat common convention is to use

	prefix_dbg(level, fmt, ...)

where level is either a numeric value or bitmask,
and also is either a #define or a MODULE_PARAM

today sound/misc.c has:

------------------------------------------

#ifdef CONFIG_SND_DEBUG

#ifdef CONFIG_SND_DEBUG_VERBOSE
#define DEFAULT_DEBUG_LEVEL	2
#else
#define DEFAULT_DEBUG_LEVEL	1
#endif

static int debug = DEFAULT_DEBUG_LEVEL;
module_param(debug, int, 0644);
MODULE_PARM_DESC(debug, "Debug level (0 = disable)");

#endif /* CONFIG_SND_DEBUG */

------------------------------------------

I suggest converting all the remaining

snd_printd(...) to snd_dbg(1, ...)
and
snd_printdd(...) to snd_dbg(2, ...)

so that debug module param control can be used for
all these and if the DEFAULT_DEBUG_LEVEL isn't
high enough, the various snd_dbg(2, ...) can be
completely optimized away if appropriate.
