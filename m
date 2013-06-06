From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Thu, 6 Jun 2013 16:42:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306061636520.878-100000@iolanthe.rowland.org>
References: <1370380785.2385.69.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id 12012261ABB
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 22:42:43 +0200 (CEST)
In-Reply-To: <1370380785.2385.69.camel@joe-AO722>
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

> On Tue, 2013-06-04 at 16:54 -0400, Alan Stern wrote:
> > I don't see how DEFAULT_DEBUG_LEVEL can be used to optimize away
> > anything.  The user can always change the value of the "debug" module
> > parameter while the system is running.  The only valid opportunity for
> > optimization would be if CONFIG_SND_DEBUG was disabled; then all these 
> > messages would disappear.
> 
> Not really.
> 
> Think of CONFIG_SND_DEBUG as a level. (0, 1, 2)
> or maybe think of it as CONFIG_SND_DEBUG_VERBOSITY.
> 
> There could still be ability to have CONFIG_SND_DEBUG
> limit the compiled-in messages to those below the
> #define value and still then have runtime control over
> which ones are displayed.

How useful really is it to be able to limit the amount of debugging
messages at runtime?  Does anybody ever actually adjust the "debug"  
module parameter?

In my opinion, this is not worth the extra space required.  Virtually 
all the benefit of different debugging levels can be obtained by 
defining different symbols at compile time, such as CONFIG_SND_DEBUG 
and CONFIG_SND_VERBOSE_DEBUG.  That gives you two levels of debugging 
(not counting the "none" setting), which is enough for everything but 
snd_printddd().  Does anybody really need a third level?

Alan Stern
