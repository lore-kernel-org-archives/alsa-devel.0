From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: how to define a 2-index control element?
Date: Mon, 06 May 2002 21:11:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CD6D54D.F1D32575@alsa-project.org>
References: <Pine.LNX.4.33.0205051747360.509-100000@pnote.perex-int.cz>
		<200205060131.g461VDD16008@post2.fast.net>
		<s5hhellmqjk.wl@alsa2.suse.de>
		<3CD674C2.2358ECE0@alsa-project.org> <s5hg015mo8k.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp2.libero.it (smtp2.libero.it [193.70.192.52])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA02079
	for <alsa-devel@alsa-project.org>; Mon, 6 May 2002 21:11:43 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <pbd@op.net>, Jaroslav Kysela <perex@suse.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> so far, we have no way to distinguish the matrix elements from
> others.  imagine you implement all 1400+ elements as singletons.
> what happens if you run alsamixer on that?
> obviously showing all of them should be avoided.

Already now alsamixer does not show all the controls. What's the
problem?

> 
> > Your question is: how to represent the info that a set of elements may
> > (should) be organized in a matrix?
> >
> > We have already discussed that some time ago (about topology stuff,
> > etc., do you remember?) and we decided to keep out this mess from kernel
> > space.
> 
> yes.
> please note that my proposal is based on the current implementation.
> basically the matrix elements are mapped as 1:1 using a linear index
> just like others.  i proposed MATRIX_ELEM not to mix up it with other
> normal controls.  the mapping is done actually in alsa-lib.
> 
> > We decided to have (if needed) card specific alsa-lib code to handle all
> > that.
> 
> ok, the problems are
> 
> - showing all matrix elements on GUI as normal elements is
>   nonsense  -  there must be some flag to distinguish the matrix
>   elements from others even if we implement the matrix on a linear
>   array.
> 
> - we have no info to define the size of indices.
>   without this info, the general mapping code cannot be implemented on
>   the alsa-lib.

Card specific code may solve all that easily.

We need to separate in our minds the _basic_ hardware access and
layout/display consideration. Kernel is for the former, libraries and
applications for the latter.

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
