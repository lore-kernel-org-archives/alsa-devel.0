From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Why do I get broken pipe on write to a pcm in   
 statePREPARED?
Date: Tue, 17 Sep 2002 10:12:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D86E3ED.5C06BCB1@libero.it>
References: <Pine.LNX.4.33.0209131137140.521-100000@pnote.perex-int.cz> <s5h4rcqtdoy.wl@alsa2.suse.de> <3D863177.51DB8C79@libero.it> <200209162014.g8GKEc014124@d1o87.telia.com>
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
To: Anders Torger <torger@ludd.luth.se>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Anders Torger wrote:
> 
> On Monday 16 September 2002 21.31, you wrote:
> > I think that the best behaviour is the current and it's also the
> > simplest to describe and to understand: poll/select never blocks when
> > there is nothing to wait.
> >
> > ... and in PREPARED state definitely there's nothing to wait from
> > sound card.
> 
> I don't agree. To a beginner which has never seen a unix system before,
> this might be the case. For anyone that has programmed with file
> descriptors before, this behaviour appears broken, and is therefore
> harder to understand.
> 
> Also, as we have noted, there is no real use for the current behaviour
> (at least no-one has said what it is), while there is use for the
> proper work-as-all-other-file-descriptors behaviour.
> 
> * It behaves as programmers expect it to behave
> * It simplifies multi-threaded programming

Please use technical argumentations: pseudo statistical and subjective
ones does not worth a lot.

> "If the sound card output buffer is full of data, and it is not
> running, what would happen if you poll that file descriptor for writing"
> 
> 1) it will block, because it is not ready for writing
> 2) it would not block, because it would then block forever

2 is better because the programmer can know the reason of failure.
With 1 the programmer will not receive enough info to detect it (also
using a timeout)

> "If you write to a non-blocking sound card output file descriptor, but
> the buffer is full, and the sound card is not running, what will then
> happen?"
> 
> 1) it will return with errno set to EAGAIN, because it is not ready for
>    writing
> 2) it will return with errno set to EPIPE, because there is a buffer
>    overflow

2 is better because EAGAIN would be returned also if buffer is
*temporarily* full.
Consider also that "retry again later" is definitely a misleading hint.

> In conclusion, I advice you to change the behaviour to what we as
> programmers expect, and sometimes program for. I would very much
> appriciate it, and I'm sure others will as well

Please understand that it's very hard to satisfy everybody and I'm not
sure it's a worthy goal.

That apart, I'm very interested to hear further technical reason to
change current behaviour.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
