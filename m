From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: The obsolence of OSS, Was: big smiley
Date: Wed, 25 Feb 2004 15:50:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040225145020.GI8820@sunrise.pg.gda.pl>
References: <20040225133759.GH8820@sunrise.pg.gda.pl> <200402251417.i1PEHsZQ025905@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200402251417.i1PEHsZQ025905@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 25, 2004 at 09:17:54AM -0500, Paul Davis wrote:
> There are only 2 differences associated with running the code you are
> talking about in the kernel:
> 
> 	a) it runs deterministically in interrupt context
> 	b) it avoids a context switch back into user space
It could be more optimized too.

> Linux is designed to make the context switch code very, very fast - if
> it wasn't, then a system like JACK just could not work because it too
> relies on context switches to make things happen.
Next userspace daemon, then alsa-oss lib which could be swapped too.

> The linux kernel community has long seen the kernel as a place to
> avoid putting any functionality that can be provided in user
> space. And the evidence is there that it *can* be provided in user
> space. 
Of course we could done device drivers in userspace too ;-)).
alsa-oss is some kind of virtual device, isn't it?
Maybe we need to change to microkernel approach??

> drivers). When this happens, it becomes apparent just how non-realtime
> friendly most application designs are.
Yes that's true. So some kernel support for time critical apps
should appear - not quite RT.

> You can see exactly the same thing on Windows, where the MME model for
> audio programming tends to produce programs that click and pop,
> whereas those designed around ASIO and similar APIs do not (until
> there is no alternative). 
Agree.

> sigh. of course! because the kernel has no idea that your audio
> application needs to run with real-time priority, and is instead
> treating all apps as if they are normal interactive programs. if you
> tell the kernel that your app needs to run with RT priority (there are
So why I think about some api to tell the kernel that some app nedds CPU
in more deterministic manner. Generally if we could do this by /proc too
like tunnig ALSA for particular programs it would be good for old
proprietary programs which we couldn't improve.
It's not RT but some sheduler modification to treat some programs
specially.


> OSS cannot affect this in any way - its a function of the kernel
> scheduler and not the audio device API.
OK but we could have some kernel RT thread which is doing mixing
or MIDI emulation.

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
