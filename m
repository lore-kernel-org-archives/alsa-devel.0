From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Why do I get broken pipe on write to a pcm in  
 statePREPARED?
Date: Tue, 17 Sep 2002 10:21:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D86E602.E1466721@libero.it>
References: <Pine.LNX.4.21.0209162345440.584-100000@summer.quitte>
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
To: Tim Goetze <tim@quitte.de>
Cc: Abramo Bagnara <abbagnara@racine.ra.it>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Tim Goetze wrote:
> 
> Abramo Bagnara wrote:
> 
> >> >I think that the best behaviour is the current and it's also the
> >> >simplest to describe and to understand: poll/select never blocks when
> >> >there is nothing to wait.
> >> >
> >> >... and in PREPARED state definitely there's nothing to wait from sound
> >> >card.
> >>
> >> you know that linux supports multi-threading, don't you?
> >
> >Oh, yes... and easy message passing between threads too.
> >
> >You get the point now?
> >
> >The usual rule of thumb is: "don't make in kernel space what is feasible
> >in user space"
> 
> if you really believed in this rule, i'd expect you to start work on
> moving the sequencer out of ring 0 asap. ;)
> 
> let's imagine:
> 
> * a single-threaded app. if the coder omits starting the stream before
> poll, he'll quickly find out that nothing is played/recorded, and that
> poll will hit the timeout, and consequently revise his code logic.

It would be definitely not easy for the app. to detect *why* poll is
blocking and it'd needs time. I think it would be a bad solution.

> 
> * a multi-threaded app. it is *very* convenient not to do the 'easy'
> message passing for starting/stopping streams in many, many
> applications. all you have to do in the 'engine' thread is poll and
> process. i wonder if you can imagine how much easier things get when
> things work this way.

This argument might be applied to every message passing need between
threads. Do we want to change an useful semantic to have just another
way to do an already easy task? I don't believe so.

> i mean, alsa is great, but why do you have to make it a pita to code
> for?

I suppose you're exaggerating the thing to support your arguments, don't
you ;-)

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
