From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Tue, 04 Jun 2013 14:19:45 -0700
Message-ID: <1370380785.2385.69.camel@joe-AO722>
References: <Pine.LNX.4.44L0.1306041646240.1093-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B2E92651AE
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 23:19:47 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1306041646240.1093-100000@iolanthe.rowland.org>
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

On Tue, 2013-06-04 at 16:54 -0400, Alan Stern wrote:
> I don't see how DEFAULT_DEBUG_LEVEL can be used to optimize away
> anything.  The user can always change the value of the "debug" module
> parameter while the system is running.  The only valid opportunity for
> optimization would be if CONFIG_SND_DEBUG was disabled; then all these 
> messages would disappear.

Not really.

Think of CONFIG_SND_DEBUG as a level. (0, 1, 2)
or maybe think of it as CONFIG_SND_DEBUG_VERBOSITY.

There could still be ability to have CONFIG_SND_DEBUG
limit the compiled-in messages to those below the
#define value and still then have runtime control over
which ones are displayed.

> You didn't respond to the first point I raised.  Since these messages
> are all meant for debugging, there's no point allowing them to have
> prefixes like KERN_ERR or KERN_INFO.  They should always be printed at
> the KERN_DEBUG level.  Or did you think this was so obviously true that
> it didn't require any comment?

Yes.  My perspective is _all_ debugging messages should
be at KERN_DEBUG.
