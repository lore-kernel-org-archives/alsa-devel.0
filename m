From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Fri, 10 Sep 2004 09:16:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040910071614.GH4584@sunrise.pg.gda.pl>
References: <200408310852.i7V8qSKk023731@www4.pobox.sk> <Pine.LNX.4.58.0408311131310.1762@pnote.perex-int.cz> <20040906204559.GA4584@sunrise.pg.gda.pl> <Pine.LNX.4.58.0409071050020.1723@linux.local> <20040909055206.GD4584@sunrise.pg.gda.pl> <Pine.LNX.4.58.0409091657460.4150@server.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EE9F927D
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2004 09:17:54 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409091657460.4150@server.perex-int.cz>
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

On Thu, Sep 09, 2004 at 05:14:29PM +0200, Jaroslav Kysela wrote:
> You've not showed me a solution. Tell me about API which meets this:
> 
> 1) additional processing
> 2) minimal overhead for direct hardware accesses
> 3) consistent API for everything
I am telling you only about mmapped mode in which I need constantly
running ring buffer from app point of view. In other modes ALSA API
is good enough and I have no claims. Of course functions like
snd_pcm_delay or snd_pcm_avail_update have sense only in normal
read/write modes. In mmapped mode I need only to now buffer_size,
buffer_boundary and current hw_ptr. All other I can calculate by myself
and update data in place where I want. 

> 
> Actually, ALSA PCM API meets all these points.
Yes, but mmaped mode is different then it seems to be. If I just don't
use it all is perfect. I am waiting for example of good working user app
using this mode.

> 
> You chose only one example (the case when the whole ring buffer should be
> accessible for immediate events), and you may implement it using current 
> ALSA API as:
> 
> a) I don't care, I want to use only raw hw:X,Y access, thus setup
>    stream transfer without xrun checking, use mmap_begin and do ugly 
>    things with the ring buffer contents ===> your code will be totaly
>    unsuported by us, because you don't follow official API
> b) I care about a support, but only hw:X,Y devices does matter for me --> 
>    use mmap_begin/mmap_commit/avail_update/forward/rewind functions.
>    Very small overhead with appl_ptr management will be added on
>    the alsa-lib side in this case. The overhead is totaly negligible.
> c) I care and want to be compatible with all plugins: In this case, use 
>    double buffer scheme - you can have a ring buffer for immediate events 
>    and use FIFO to push samples to alsa-lib using all standard functions 
>    mentioned in b) - without needing to use forward and backward calls 
>    which are not implemented in some cases or may add large amount of 
>    unwanted processing. Of course, you will double probably the latency.
> 
> Your suggested API is like a hell. You don't know, what was changed in the
> ring buffer, thus additional processing is imposible. Please, think about 
> it.
Only the c) is valid for me but latency is important in this mode
and I must modify the ALSA ring buffer (plugin buffer).
I am not talking about ALSA lib API but only OSS emulation
which should be adequate to original OSS behaviour.
Also ALSA API should allow the same functionality then OSS
in mmapped mode (other modes are OK) or better.
Unified API for all modes means that some functionality of mmaped mode
is lost because we must push the appl_pointer forward so snd_pcm_delay
and snd_pcm_avail_update functions could be used in this mode too.
So total unification is not quite good IMHO.

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
