From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dmix plugin
Date: Sun, 16 Feb 2003 14:27:59 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302161418120.1060-100000@pnote.perex-int.cz>
References: <3E4B992F.BFDE3E41@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA32222
	for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2003 14:28:00 +0100
In-Reply-To: <3E4B992F.BFDE3E41@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 13 Feb 2003, Abramo Bagnara wrote:

> Jaroslav Kysela wrote:
> > 
> > Hi all,
> > 
> >         a next step to get the lowlatency sharing of exclusive PCM devices
> > is in ALSA CVS - the dmix (direct mixing) plugin..
> >         How it works? Basically, the playback in driver runs forewer
> > without any xrun detection. The ring buffer (only just played areas) is
> > also silenced in each interrupt. Then we have multiple clients and a
> > process (server) which passes the file descriptor of playback devices to
> > them. The server also takes care about freeing of used shm memory and
> > semaphore.
> >         The big step forward is that we share one mmaped ring buffer
> > accross many processes and each process can add samples into it without
> > any process<->kernel swaps. Also, each processes are independant, thus
> > failing of one doesn't break others. It's not multithreaded, we don't need
> > this mechanism.
> 
> Good work, Jaroslav!
> 
> I'd like to understand how you've thought to solve:
> a) contemporary access to same sample
> b) sum overflow (now I'm unable to remember the technical term)
> 
> For a) I can imagine some effective tricks (xadd or
> store/sum/check/retry or period size mutex), but I really don't see what
> you'll invent for b) ;-)

a) yes, we need look for the most effective locking scheme for sample 
   updates; at first glance, the instruction which does add+saturation 
   doesn't exist for i386 (MMX offers saturation, but it operates only
   with mmx registers)
b) sum overflow: we can lower volume of samples before sum; I think that
   hardware works in this way, too

> Without this correctness concerns this approach is very much efficient
> (compared to server based one), I wonder only if this will be true also
> when correctness will be taken in account. BTW someone knows how much is
> relevant the audible impact of this lack of correctness?

I don't hear any audiable problems on my UP machine with current scheme 
which doesn't take care about a) nor b). I tried six simultaneous streams.

> One thing I'm definitely sure is that this is the *perfect* approach for
> pcm_share (at least now I don't see any drawbacks).

Yes, my next goal is to move common code for such plugins to separate file 
and create share and capture-tee (any idea for better name?) plugins.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
