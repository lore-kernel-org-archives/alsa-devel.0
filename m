From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: Digital sound card conventions
Date: Mon, 6 Jan 2003 18:21:41 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301061818380.551-100000@pnote.perex-int.cz>
References: <200301061620.h06GKb2a014804@spider.tela.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA03633
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 18:24:37 +0100
In-Reply-To: <200301061620.h06GKb2a014804@spider.tela.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Anders Torger <torger@ludd.luth.se>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 6 Jan 2003, Paul Davis wrote:

> >> this seems wrong to me. what should fail is an attempt to set the
> >> sample rate unless the hardware is its own clock Master. if no attempt
> >> is made to set it, then the application gets whatever the hardware is
> >> running at, whether that is externally controlled or some h/w specific
> >> default. 
> >
> >I think that it's wrong when application receives stream with another
> >parameters than requested. 
> 
> how would that happen?
> 
> if it asks for a specific rate via hw_params, it will either get it,
> or fail.  if it doesn't ask for a specific rate, it will get whatever
> the h/w is using (some default and/or the value set by an external clock).
> 
> >			    Imagine that you're doing a software sample
> >rate conversion and we really need to know the exact rate for this job.
> 
> you can get it by just asking the device what rate its using, or by
> knowing that your hw_params request completed successfully.

Ok, we speak about same things. It's ok when hw_params request returns an 
error code when rate doesn't match.

> >1) offer all available sample rates in open() or reduce them as suggested
> >   by Anders
> >2) in trigger(START)
> >   - check if current sample rate match with hw_params - if not - fail
> >3) in interrupt callback
> >   - same job as trigger does
> 
> what about checking in read/write operations, in case the external
> clock has changed?

Yes, the check might be in copy/silence/pointer callbacks, too.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
