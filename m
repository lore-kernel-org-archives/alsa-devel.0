From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Tue, 7 Sep 2004 12:34:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907103408.GB4584@sunrise.pg.gda.pl>
References: <200408310852.i7V8qSKk023731@www4.pobox.sk> <Pine.LNX.4.58.0408311131310.1762@pnote.perex-int.cz> <20040906204559.GA4584@sunrise.pg.gda.pl> <Pine.LNX.4.58.0409071050020.1723@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 222B3280
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 12:34:25 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409071050020.1723@linux.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 07, 2004 at 11:05:05AM +0200, Jaroslav Kysela wrote:
> On Mon, 6 Sep 2004, Adam Tla/lka wrote:
> There is always a drift between system and card's timing.
ALSA appl/hw_ptr calculated position is also not exact ;-).
If I know system time and card hw_ptr it is enough to calculate desired
position and correct time drift. 

> The appl_ptr is not moved in mmap_begin. The mmap_begin function only 
> returns the actual position to ring buffer based on appl_ptr.
That's right. I do mmap_begin to obtain appl offset in ALSA buffer
and mmap_commit to move the appl pointer so we have no buffer
underrun and appl offset is equal to hw offset (approximately).
Now I can update the ALSA buffer from OSS buffer.

> We need the intelligent mmap transport for additional functionality 
> (conversions, resampling etc.). I think it's the proper way and nobody 
> (except OSS emulation) has the useability problem. You can still move 
> backwards (although it is problematic when you have a mixing on the path).
As I wrote before I use dmix plugin and of course there is a route
plugin on the path so moving backwards not works. I want to mix OSS apps
with ALSA apps so everything could be played simultaniously.
Using ALSA hw:0,0 device for OSS emulation doesn't make any sense for me.

Talking about proper using mmaped mode in games, samplers and other apps
which can generate sound at any time (not exactly - precision is about
1 to several app frames) which of them could you show here?
As I know xmms mmaped mode is broken and I just don't know an app
which uses this mode with success.
I just need a good example.

Also some widely used programs have problems using native ALSA approach.
For example mplayer plays sound a bit too late (in dmix case) which
could be easily observed ("Bruce Almighty"). What is interesting playing
the same data with aoss and OSS calls we have proper A/V sync.
Mplayer's A/V status line shows perfect sync in both cases.
It's mplayers case but shows us that maybe we need a good manual
describing proper use of ALSA api. Not only what particular parameter
means but also how properly set them and how to recover from errors.
With good examples of course ;-).

> err < 0 -> error code
> err == 0 -> no action (appl_ptr was unchanged in case when you're already 
> behind hw_ptr)
OK, but in case of delay < 0 if I then do err = snd_pcm_forward(pcm, -delay)
I will get err < 0 (probably from rate plugin). So what should I do to recover
from this situaction?

> > Also what is the meaning of snd_pcm_available > alsa.buffer_size?
> You're too late, so you need to fill (or better skip via forward) some 
> more samples to synchronize appl_ptr.
Forward generates an error, so how to calculate correct appl_ptr
now and recover from error?

Regards

-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
