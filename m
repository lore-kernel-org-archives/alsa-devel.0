From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Why do I get broken pipe on write to a pcm in
 statePREPARED?
Date: Sat, 05 Oct 2002 09:45:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D9E9886.7E668776@libero.it>
References: <3D98769A000FAA05@ims5a.libero.it> (added by postmaster@libero.it)
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Takashi Iwai <tiwai@suse.de>, Anders Torger <torger@ludd.luth.se>, Jaroslav Kysela <perex@suse.cz>, Tim Goetze <tim@quitte.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> 
>  [ abramo: please forward to alsa-devel@lists.sourceforge.net. thanks. ]
> 
> >I'm strongly convinced that to have poll waiting for something that
> >cannot happens is a big mistake (also as an optional behaviour).
> 
> there are several, perhaps even lots, of other device drivers in the
> linux kernel that do this.

Some examples please.

> >That apart I'm sure that to make a change in actual behaviour between
> >rcX and 1.0 is a professional suicide. However it's _your_ professional
> >suicide so... ;-)))
> 
> not *one* person on alsa-devel has described software that would be
> broken by this change.

You'll hear the screams *after* the change has been done and not before.
This is what happens all the times and I'm sure you understand why.

> given that jaroslav is already changing the API between rcX and rcZ,
> this doesn't seem like much of a problem, anyway.

This is not true as far as I can tell. Jaroslav has made the changes an
option selectable at compile time. Consider also that he made a change
that break the compilation, while the case we are discussing is more
severe: the application still compiles but we'd have a different
behaviour.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
