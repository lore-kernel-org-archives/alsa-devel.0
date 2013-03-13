From: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Subject: Re: [Alsa-user] Master volume control
Date: Wed, 13 Mar 2013 13:17:00 -0700
Message-ID: <E7C08FBDE6B748B29CE67CB33629E12A@PAULD>
References: <B3AC1EE66F1142FF99DDC145B8669DDD@PAULD>
 <512F0AF5.3050502@googlemail.com> <DB754736B2E5480F987C1DE8E330AC7C@PAULD>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net
 (elasmtp-kukur.atl.sa.earthlink.net [209.86.89.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BB84265E28
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 21:17:13 +0100 (CET)
Received: from [76.173.239.98] (helo=PAULD)
 by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4.67)
 (envelope-from <pderocco@ix.netcom.com>) id 1UFs6o-0004Jm-71
 for alsa-devel@alsa-project.org; Wed, 13 Mar 2013 16:17:10 -0400
In-Reply-To: <DB754736B2E5480F987C1DE8E330AC7C@PAULD>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Alsa-devel' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

More on this.

My synth app, running on a dual-core Atom, has two sound generation threads,
running at a "nice" value of -20, and a normal control thread running at
nice 0. The control thread is what calls snd_ctl_elem_write when I move the
volume slider. My sound threads normally consume less than 50% of their
respective CPUs, but when I move the volume slider, I get underruns.

If I run "top -H" in a terminal window, I see three other processes that
suddenly consume gobs of CPU time as I change the volume.

	name            nice    CPU%
	pulseaudio      -11      19
	threaded-ml       0      14
	indicator-sound   0      11

If instead of using my synth's volume slider, I open alsamixer in another
terminal window, I don't see the same CPU usage, but I now attribute that to
the fact that the keyboard is issuing volume changes at a much slower rate
than my slider, which is read in a 200Hz loop. In fact, when I use
alsamixer, and ramp the volume up and down, every now and then I do get an
underrun. So it apparently won't matter whether I use snd_ctl_elem_write or
snd_mixer_selem_set_playback_volume.

So what I'd like to know is why the hell does changing the volume every 5ms
suck up 44% of one CPU core? I get the feeling that the above processes
aren't integral to ALSA, and may go away when I move my app to a pure
embedded system, as opposed to Ubuntu. Is that the case? Am I chasing
phantoms? Since I'm not doing _anything_ related to sound on this machine,
other than developing my synth app (I don't even need a terminal beep), is
there any way I can uninstall the things that are hogging the CPU, like
pulseaudio?

-- 

Ciao,               Paul D. DeRocco
Paul                mailto:pderocco@ix.netcom.com 
