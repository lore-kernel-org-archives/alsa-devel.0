From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Thu, 9 Sep 2004 17:14:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409091657460.4150@server.perex-int.cz>
References: <200408310852.i7V8qSKk023731@www4.pobox.sk>
 <Pine.LNX.4.58.0408311131310.1762@pnote.perex-int.cz>
 <20040906204559.GA4584@sunrise.pg.gda.pl> <Pine.LNX.4.58.0409071050020.1723@linux.local>
 <20040909055206.GD4584@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2E8A52B7
	for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2004 17:14:30 +0200 (MEST)
In-Reply-To: <20040909055206.GD4584@sunrise.pg.gda.pl>
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

On Thu, 9 Sep 2004, Adam Tla/lka wrote:

> On Tue, Sep 07, 2004 at 11:05:05AM +0200, Jaroslav Kysela wrote:
> > We need the intelligent mmap transport for additional functionality 
> > (conversions, resampling etc.). I think it's the proper way and nobody 
> > (except OSS emulation) has the useability problem. You can still move 
> > backwards (although it is problematic when you have a mixing on the path).
> OK, that's correct if you need this for plugins in ALSA lib, but from
> app point of view it should be as simple as possible. An app working in

You've not showed me a solution. Tell me about API which meets this:

1) additional processing
2) minimal overhead for direct hardware accesses
3) consistent API for everything

Actually, ALSA PCM API meets all these points.

You chose only one example (the case when the whole ring buffer should be
accessible for immediate events), and you may implement it using current 
ALSA API as:

a) I don't care, I want to use only raw hw:X,Y access, thus setup
   stream transfer without xrun checking, use mmap_begin and do ugly 
   things with the ring buffer contents ===> your code will be totaly
   unsuported by us, because you don't follow official API
b) I care about a support, but only hw:X,Y devices does matter for me --> 
   use mmap_begin/mmap_commit/avail_update/forward/rewind functions.
   Very small overhead with appl_ptr management will be added on
   the alsa-lib side in this case. The overhead is totaly negligible.
c) I care and want to be compatible with all plugins: In this case, use 
   double buffer scheme - you can have a ring buffer for immediate events 
   and use FIFO to push samples to alsa-lib using all standard functions 
   mentioned in b) - without needing to use forward and backward calls 
   which are not implemented in some cases or may add large amount of 
   unwanted processing. Of course, you will double probably the latency.

Your suggested API is like a hell. You don't know, what was changed in the
ring buffer, thus additional processing is imposible. Please, think about 
it.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
