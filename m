From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: dmix plugin
Date: Sun, 16 Feb 2003 19:00:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4FD1BB.41317D80@libero.it>
References: <Pine.LNX.4.44.0302161418120.1060-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp4.cp.tin.it (vsmtp4.tin.it [212.216.176.224])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA04169
	for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2003 19:03:52 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Thu, 13 Feb 2003, Abramo Bagnara wrote:
> 
> > Jaroslav Kysela wrote:
> > >
> > > Hi all,
> > >
> > >         a next step to get the lowlatency sharing of exclusive PCM devices
> > > is in ALSA CVS - the dmix (direct mixing) plugin..
> > >         How it works? Basically, the playback in driver runs forewer
> > > without any xrun detection. The ring buffer (only just played areas) is
> > > also silenced in each interrupt. Then we have multiple clients and a
> > > process (server) which passes the file descriptor of playback devices to
> > > them. The server also takes care about freeing of used shm memory and
> > > semaphore.
> > >         The big step forward is that we share one mmaped ring buffer
> > > accross many processes and each process can add samples into it without
> > > any process<->kernel swaps. Also, each processes are independant, thus
> > > failing of one doesn't break others. It's not multithreaded, we don't need
> > > this mechanism.
> >
> > Good work, Jaroslav!
> >
> > I'd like to understand how you've thought to solve:
> > a) contemporary access to same sample
> > b) sum overflow (now I'm unable to remember the technical term)
> >
> > For a) I can imagine some effective tricks (xadd or
> > store/sum/check/retry or period size mutex), but I really don't see what
> > you'll invent for b) ;-)
> 
> a) yes, we need look for the most effective locking scheme for sample
>    updates; at first glance, the instruction which does add+saturation
>    doesn't exist for i386 (MMX offers saturation, but it operates only
>    with mmx registers)

	old = *dst;
again:
	new = old + *src;
	if (new > 0x7fff)
		new = 0x7fff;
	else if (new < -0x8000)
		new = -0x8000;
	old1 = cmpxchg(dst, old, new);
	if (unlikely(old != old1)) {
		old = old1;
		goto again;
	}

might be a good approach on most architectures

> b) sum overflow: we can lower volume of samples before sum; I think that
>    hardware works in this way, too

Here I don't understand you. Suppose we have 3 samples to mix:
a = 0x7500
b = 0x7400
c = 0x8300

If you do a + b + c (in this order) you obtain:
d=0
d += a -> 7500
d += b -> 0xe900 -> 0x7fff
d += c -> 0x02ff

while the correct result is 0x6c00. You see?

> I don't hear any audiable problems on my UP machine with current scheme
> which doesn't take care about a) nor b). I tried six simultaneous streams.

It's hard to detect sound quality mixing six random sound sources ;-)

> > One thing I'm definitely sure is that this is the *perfect* approach for
> > pcm_share (at least now I don't see any drawbacks).
> 
> Yes, my next goal is to move common code for such plugins to separate file
> and create share and capture-tee (any idea for better name?) plugins.

pcm_snoop of course ;-)

Take in account in the design to use it for both capture and playback
(i.e. pcm_snoop is always capture of course, but the snooped pcm
direction may be both).

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
