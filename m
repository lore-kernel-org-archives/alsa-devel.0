From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: Re: About integer64
Date: Thu, 09 May 2002 15:56:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CDA801B.9A10FE99@alsa-project.org>
References: <200205091339.g49Dd8907029@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >b) if a 32 bit integer is not enough and a float is preferrable:
> >considered that an ieee754 floating point is in the form (1+man)*2^exp
> >what's the problem in converting it in your driver using ffs and some
> >shift?
> 
> if the lkml crew see us using floating point in any form in the
> kernel, we will attract complaints, even if we use integer operations
> to do so. i am firmly convinced of this.

I don't think so: try to fgrep for float in kernel source, you'll find
several place where they're stored (and I suppose for good reason).

Also I've read a recent post from Alan Cox explaining *how* to use
floating point in kernel space. This presuppose that it's not a serious
sin if it's justified.

> >2) why use 64 bit integer
> >
> >Of course if a 64 bit integer is the best way to represent/report the
> >value all is fine, but in this case I doubt that you don't have
> >available the 64th bit for the sign.
> 
> that seems likely to me also. i suspect we have somewhere between 32
> and 64 bits of information.
> 
> i didn't say that i conclusively needed the sign bit - i was noting
> that the current API doesn't make unsigned values possible.

Please specify that then, you know, Jaroslav is faster than the dust to
insert new features, if you make him to believe they're needed ;-)

Better to insert them when and *if* they're needed: maintanance is
easier in this way.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
