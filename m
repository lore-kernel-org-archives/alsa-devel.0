From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Tue, 7 Sep 2004 15:40:04 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409071538390.14771@linux.local>
References: <200408310852.i7V8qSKk023731@www4.pobox.sk>
 <Pine.LNX.4.58.0408311131310.1762@pnote.perex-int.cz>
 <20040906204559.GA4584@sunrise.pg.gda.pl> <Pine.LNX.4.58.0409071050020.1723@linux.local>
 <20040907103408.GB4584@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 458DC25E
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 15:41:31 +0200 (MEST)
In-Reply-To: <20040907103408.GB4584@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Sep 2004, Adam Tla/lka wrote:

> On Tue, Sep 07, 2004 at 11:05:05AM +0200, Jaroslav Kysela wrote:
> > On Mon, 6 Sep 2004, Adam Tla/lka wrote:
> > There is always a drift between system and card's timing.
> ALSA appl/hw_ptr calculated position is also not exact ;-).
> If I know system time and card hw_ptr it is enough to calculate desired
> position and correct time drift. 

I don't know exactly what you want to solve. If you have another master 
timer, then you must sync with it, of course.

> > err < 0 -> error code
> > err == 0 -> no action (appl_ptr was unchanged in case when you're already 
> > behind hw_ptr)
> OK, but in case of delay < 0 if I then do err = snd_pcm_forward(pcm, -delay)
> I will get err < 0 (probably from rate plugin). So what should I do to recover
> from this situaction?
> 
> > > Also what is the meaning of snd_pcm_available > alsa.buffer_size?
> > You're too late, so you need to fill (or better skip via forward) some 
> > more samples to synchronize appl_ptr.
> Forward generates an error, so how to calculate correct appl_ptr
> now and recover from error?

The forward should work for the dmix plugin. Could you send me a little 
code which shows the error?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
