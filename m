From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: New PCM API extension
Date: Sun, 23 Feb 2003 19:46:40 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302231909140.1263-100000@pnote.perex-int.cz>
References: <3E57F1D6.6C4D88B1@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA04529
	for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2003 19:46:47 +0100
In-Reply-To: <3E57F1D6.6C4D88B1@libero.it>
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

On Sat, 22 Feb 2003, Abramo Bagnara wrote:

> Jaroslav Kysela wrote:
> > 
> > Hello all,
> > 
> >         I'd like to announce a new PCM API extension. Although it is
> > implemented, it might be changed following the discussion on this list.
> >         I've added the snd_pcm_forward() function. This function is
> > function with opposite meaning to snd_pcm_rewind() - it skips given count
> > of frames (note that in the ring buffer are unchanged, only the r/w
> > pointer is increased). The application has full control on the r/w pointer
> > now. It's useful mainly in the no-xrun mode where the stream runs forever.
> 
> Don't we had already snd_pcm_reset for exactly the same purpose?

Yes and no. You cannot fill the buffer ahead without writting some
samples. I think that it's not bad to offer the full control on appl_ptr.
It doesn't cost us anything and I can imagine some special applications
where the buffer is auto-silenced that they need to write samples into the
specific position. Reset is nice, but you cannot tell the count of frames
to be skipped without filling.

I'm also going to propose next extension: Actually, the appl_ptr managing
routines - snd_pcm_reset(), snd_pcm_rewind(), snd_pcm_forward() always
uses an ioctl for it's operation. I think that it wouldn't be a bad idea
to implement these function in the lightweight variant, too. I mean that
they will operate only with the actual hw_ptr without calling the kernel
code. We have already functions to synchronize the hw_ptr with the
hardware (snd_pcm_delay(), snd_pcm_hwsync()). Because it's late to change
this behaviour in alsa-lib, I propose to create a function 
'snd_pcm_fast_rw_change()' (better name?) which tells the alsa-lib that no 
accurate operation is required. Especially lowlatency applications will 
benefit that we removed more 'user<->kernel' switches.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
