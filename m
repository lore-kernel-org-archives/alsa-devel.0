From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: how to define a 2-index control element?
Date: Wed, 8 May 2002 09:52:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0205080938020.507-100000@pnote.perex-int.cz>
References: <20020508000005.EB5AC59D35D@kerberos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020508000005.EB5AC59D35D@kerberos.suse.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Abramo Bagnara <abramo@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 7 May 2002, Paul Davis wrote:

> >We have well designed control keys (id) and I don't see any reason to
> >change something that's perfectly suitable (without any compromise) for
> >the job.
> 
> the implementation is not well designed for cases of 1500
> controls. perhaps, as jaroslav says, this could be improved. but even
> if that is done, the API forces the user application to do some
> special encoding to generate the index that cannot be inferred from
> the description provided by the API. an application that wants to
> modify the gain for source S to destination D will have to know how to
> encode S and D into the index - it cannot discover this from the API.
> 
> thats a lot worse than just a compromise if you ask me.

If we have agreement that multi-dimensional arrays uses 'unsigned int' 
from index divided to bits:

# of dimensions		bits
2			16
3			10
4			8
5			6

Then we have very clear way for applications to address source S and 
destination D. It doesn't break the current API in any way.

> >We have the sane association one control / one value and just because
> >this card has many controls, you seems to wish to go toward a different
> >(IMO insane and confusing) solution.
> 
> IMHO, the 1:1 association is sane only when there are relatively small
> numbers of controls. It doesn't make any sense to me to 

Sorry Paul, but I don't like optimizations against features. It's not
possible to add notification for values without addresses which you
propose without massive changes inside the midlevel kernel code for 
control API.

> >Consider that independently from how you represent the data this card
> >will ever have many controls (i.e. many values to show/change).
> 
> this isn't true. if we had a MATRIX element type, applications could
> easily say
> 
>      "i don't display matrix elements"
>      "i don't display matrix elements of dimensionality > 2"
>      "i don't display matrix elements when the matrix is larger than N"
> 
> and so forth. the problem with the current system is that if anyone
> makes the mistake of firing up a generic control API program, they
> will see all 1500 controls. i'd like to see you explain that as "sane"
> to the user.
> 
> >I definitely don't see your point, sorry.
> 
> are you claiming that you really designed the control API as it exists
> now to handle situations with this many controls?

Our API is not perfect, of course, but we can map every simple elements 
from kernel-space to user-space with it. You cannot say, that it's problem 
of the kernel<->user communication. Your objections are against visual 
representation which we can solve in the user space in more elegant ways.
There is a lot of work before us in alsa-lib to allow configurable simple 
mixer representations.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
