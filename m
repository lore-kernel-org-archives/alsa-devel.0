From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: dmix plugin
Date: Thu, 13 Feb 2003 14:10:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4B992F.BFDE3E41@libero.it>
References: <Pine.LNX.4.44.0302121015420.14550-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from igor.opun.it (host206-120.pool80181.interbusiness.it [80.181.120.206])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA28127
	for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2003 14:10:39 +0100
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
> Hi all,
> 
>         a next step to get the lowlatency sharing of exclusive PCM devices
> is in ALSA CVS - the dmix (direct mixing) plugin..
>         How it works? Basically, the playback in driver runs forewer
> without any xrun detection. The ring buffer (only just played areas) is
> also silenced in each interrupt. Then we have multiple clients and a
> process (server) which passes the file descriptor of playback devices to
> them. The server also takes care about freeing of used shm memory and
> semaphore.
>         The big step forward is that we share one mmaped ring buffer
> accross many processes and each process can add samples into it without
> any process<->kernel swaps. Also, each processes are independant, thus
> failing of one doesn't break others. It's not multithreaded, we don't need
> this mechanism.

Good work, Jaroslav!

I'd like to understand how you've thought to solve:
a) contemporary access to same sample
b) sum overflow (now I'm unable to remember the technical term)

For a) I can imagine some effective tricks (xadd or
store/sum/check/retry or period size mutex), but I really don't see what
you'll invent for b) ;-)

Without this correctness concerns this approach is very much efficient
(compared to server based one), I wonder only if this will be true also
when correctness will be taken in account. BTW someone knows how much is
relevant the audible impact of this lack of correctness?

One thing I'm definitely sure is that this is the *perfect* approach for
pcm_share (at least now I don't see any drawbacks).

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
