From: Ted <ted@nowtsfree.freeserve.co.uk>
Subject: Re: Re: unresolved symbols in snd-gus-synth & snd-page-alloc on linux-2.2.27
Date: Thu, 30 Jun 2005 12:05:53 +0100
Message-ID: <20050630110554.3AD5E48DF@marimba.home.net>
References: <s5hd5q45ilb.wl%tiwai@suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 30 Jun 2005 10:56:00 +0200."
             <s5hd5q45ilb.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Ted <ted@nowtsfree.freeserve.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 30 Jun 2005 10:56:00 +0200,
Takashi wrote:
> At Thu, 30 Jun 2005 03:47:42 +0100,
> Ted wrote:
> > I have made a little progress but still not found a fix for Problem 2
> > in my previous message
> >
> > > # insmod snd-ainstr-simple
> > > Using /lib/modules/2.2.27-pre2/misc/snd-ainstr-simple.o
> > > /lib/modules/2.2.27-pre2/misc/snd-ainstr-simple.o: init_module:
> > >         Invalid argument Hint: insmod errors can be caused by incorrect \
> > >         module parameters, including invalid IO or IRQ parameters
> >
> > When this error occurs, dmesg also reports the following
> >
> > kernel: init_module: mod->ex_table_* invalid.
>
> Sorry, no idea yet.
> ainstr_simple.c has a quite simple module init, so I don't see what's
> going wrong, at least at module init...

Thanks for quick reply. I've tried comparing the build of similar
small modules to snd-ainstr-simple, such as snd-ainstr-gf1, which
does appear to load correctly, but I have not noticed anything yet.

Ted.
-- 
Ted <ted@nowtsfree.freeserve.co.uk>
   http://www.nowtsfree.freeserve.co.uk


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
