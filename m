From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Fixes: Re: intel8x0 has stopped working.
Date: Thu, 5 Feb 2004 12:01:28 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402051154080.1864@pnote.perex-int.cz>
References: <401E8BAE.6010802@superbug.demon.co.uk> <s5hn081uztv.wl@alsa2.suse.de>
 <401EA82D.3060702@superbug.demon.co.uk> <401ED94F.7080407@superbug.demon.co.uk>
 <Pine.LNX.4.58.0402031720190.8251@pnote.perex-int.cz> <40201EFF.9000903@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA24553
	for <alsa-devel@alsa-project.org>; Thu, 5 Feb 2004 12:00:58 +0100
In-Reply-To: <40201EFF.9000903@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Feb 2004, James Courtier-Dutton wrote:

> >>I attach a patch that fixes alsa-lib.
> >>All it does it call snd_pcm_start() just before snd_pcm_wait() and due 
> >>to the if statement just above it, will only happen when the buffer is 
> >>going to be filled, therefore ensuring that even if "start_threshold" is 
> >>set too high, snd_pcm_start() will always be called if the buffer is 
> >>full, or about to become full.
> > 
> > 
> > I don't think that this is a right fix. The programmer must know what is 
> > doing and the manual start is still alternative. You must set 
> > start_threshold to (buffer_size / period_size) * period_size in your case.
> > 
> > 						Jaroslav
> > 
> A don't think this is an application programmer bug. After all your 
> program alsa-lib/test/pcm.c had it set to start_threshold==buffer_size, 
> and you are one of the main alsa developers. So if you thought that was 
> an OK thing to set, why won't other people?

Yes, it was clearly my fault.

> My point is, I don't think setting start_threshold to buffer_size is 
> even "wrong" at all. Some people might want the buffer to be full before 
> it starts, and my patch allows for that.

It's not wrong semantics. I see - it's logical, but I don't want to follow
some rule as some API designers does - control magically some things. I
want that developer which uses our API knows what the library / driver
exactly does.

We have clear conditions when the stream is started. That's it.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
