From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Jackit-devel] One drop-out per xrun?
Date: Thu, 11 Dec 2003 09:21:01 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312110915530.20863@pnote.perex-int.cz>
References: <200312110300.hBB300vq020366@oud.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312110300.hBB300vq020366@oud.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: rcassidy@stanford.edu, jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 10 Dec 2003, Paul Davis wrote:

> >I wanted to check my knowledge of something: does an xrun necessarily
> >correspond to a "drop-out" in the audio stream?  In other words, could
> >you have a drop-out WITHOUT an xrun, or an xrun WITHOUT a drop-out?  Is
> >there a strict one-to-one correspondence between the two?
> 
> a dropout occurs when the h/w playback pointer gets ahead of the data
> already written by the s/w (i.e. repeating data already played). its
> therefore a 1:1 correspondence with an xrun, which is defined in the
> same way.

To be 100% correct, in the driver, there is very small window where the 
hardware might be in xrun state, but we cannot detect this situation:

	disable_interrupts();
	pos = get_current_position();
	<--- DMA transfer occured here and position (pos) was
	     on last valid sample -->
	if (xrun(pos))
		do_xrun_handling();
	enable_interrupts();

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
