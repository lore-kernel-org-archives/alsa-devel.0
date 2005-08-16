From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: proper suspend / resume for PCM streams
Date: Tue, 16 Aug 2005 13:33:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0508161328050.9566@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0508152139420.9682@tm8103.perex-int.cz>
 <s5h8xz2xiiz.wl%tiwai@suse.de> <Pine.LNX.4.61.0508161254410.9566@tm8103.perex-int.cz>
 <s5h64u6xhpc.wl%tiwai@suse.de> <Pine.LNX.4.61.0508161315320.9566@tm8103.perex-int.cz>
 <s5h4q9qxgw4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 466F81FB
	for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2005 13:33:59 +0200 (MEST)
In-Reply-To: <s5h4q9qxgw4.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 16 Aug 2005, Takashi Iwai wrote:

> > Yes, but they don't have set the INFO_RESUME flag, thus the midlevel
> > returns an error code for the resule ioctl...
> 
> That's the very problem.  We can't see whether the device suppose PM
> or not from this level.  So, from the app level, it can't see whether
> the PM is possible or not.

It's not a problem. If the driver does not support resume, the SUSPENDED 
PCM state never occurs. Thus the -ESTRPIPE error code won't be ever seen 
with an application.

> > It's not about error handling, it's about PCM state handling.
> > As I said, we may add some helper functions to handle these states in some 
> > default way (like aplay does) and rest of applications will do the state 
> > handling itself.
> 
> Well, what's the difference of error handling and PCM state handling?
> 
> The point in my last post is that both mean the same for almost all
> cases.  I.e. when snd_pcm_readx/writex() (or avail & mmap) receives
> -EXXX, do the standard error handling.  Nothing else is required.

Okay, the error code carries the state information, but the point is 
that the application should do necessary things in this stage like:

1) try recovery from resume and continue (standard players)
2) stop the stream and tell to the user that he/she is stupid to do such 
   things for live performance (for example JACK will do it ;-))

The point is that the application must decide what to do with this state.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
