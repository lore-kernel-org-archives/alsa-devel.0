From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Thu, 9 Sep 2004 15:28:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040909132850.GF4584@sunrise.pg.gda.pl>
References: <20040909055206.GD4584@sunrise.pg.gda.pl> <200409091259.i89CxpQM019899@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D007E188
	for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2004 15:29:01 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <200409091259.i89CxpQM019899@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 09, 2004 at 08:59:51AM -0400, Paul Davis wrote:
> if you don't "push pointers forward", there is no way for ALSA to
> determine whether there has been an xrun. ALSA can automatically track
> the h/w pointer (most of the time), but if it doesn't know how much
> data the application has written (and where), it cannot compare the
> two values to check for xruns.
I am talking only about mmapped ring buffer mode and it's working model
from apps point off view. Internally ALSA lib could do anything.

> the problem with this approach is that it doesn't take into account
> several possibilities:
> 
> 	a) there is no actual mmap-able buffer; ALSA may be providing
> 	     this via emulation (for certain hardware or certain kinds
> 	     of virtual devices), and therefore needs to know how much
> 	     data you actually wrote.
lib could push its internal pointers through callback functions
so even in case of virtual mmap buffer there should be no problem.

> 	b) the accessible region of the buffer may not be contiguous.
that's too bad - if I have to modify prevoiusly written part how to do
that? Ring buffer should be one part of mem. That's the idea.

> 	c) the h/w pointer may have already wrapped around to the
> 	     start of the buffer because of scheduling delays - your code
> 	     will fail miserably in this case.
In my example hw_ptr means virtual write position which is incremented
by device while playing samples so it is equal to transmitted frames
count from begin of playing. So it wraps after buffer_boundary samples
which is big enough to detect this case. But buffer_boundary is
calculated this way so hw_ptr % buffer_size always gives us hw position
in ring buffer.

> 	d) the "previously written" data may not be physically
> 	     accessible - there are a few audio interfaces that
> 	     are not bus masters, and require the CPU to transfer
> 	     data to them. the "old" part of the buffer will
> 	     never be resent.
In this case mmaped mode should be emulated.

> The simplicity of the OSS approach is appealing, very appealing. But
> it fails to handle some very important situations, and thats why
> ALSA's mmap API is a bit more complex.
So I ask about good working examples of apps using mmapped mode.
Normal music player can use just write and select to play music
because it can decode enough samples ahead. In case of games
you have small timeslice between an event in game and moment of time
when it should be heard. And we have many sound sources mixed
in realtime.

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
