From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: One drop-out per xrun?
Date: Thu, 11 Dec 2003 11:47:06 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312111145000.20863@pnote.perex-int.cz>
References: <200312110300.hBB300vq020366@oud.linuxaudiosystems.com>
 <Pine.LNX.4.58.0312110915530.20863@pnote.perex-int.cz>
 <20031211101422.GA28400@bth05w.ABSp.alcatel.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031211101422.GA28400@bth05w.ABSp.alcatel.be>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alfons Adriaensen <fons.adriaensen@alcatel.be>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Dec 2003, Alfons Adriaensen wrote:

> On Thu, Dec 11, 2003 at 09:21:01AM +0100, Jaroslav Kysela wrote:
> 
> > To be 100% correct, in the driver, there is very small window where the 
> > hardware might be in xrun state, but we cannot detect this situation:
> > 
> > 	disable_interrupts();
> > 	pos = get_current_position();
> > 	<--- DMA transfer occured here and position (pos) was
> > 	     on last valid sample -->
> > 	if (xrun(pos))
> > 		do_xrun_handling();
> > 	enable_interrupts();
> 
> I'm involved in the development of an application (sonar) where the
> continuity of the signal is essential, but a few corrupted samples
> every now and then won't do any harm (the S/N ratio is -60 dB anyway). 
> Is it possible in ALSA to make the driver just ignore short xruns,
> and continue without the need to restart ?

Yes, stop_threshold is what you want to set. If this value is equal to 
boundary (sw_params) no xruns are detected. If this value is above ring 
buffer size, then xruns will be detected later.

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
