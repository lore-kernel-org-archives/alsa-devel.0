From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: record on new Powerbooks?
Date: Wed, 29 Oct 2003 19:30:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310291930.24534.bergtroll@gmx.li>
References: <200310291903.02798.bergtroll@gmx.li> <s5had7jzz8g.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5had7jzz8g.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Mittwoch, 29. Oktober 2003 19:15 wurde geschrieben:
> At Wed, 29 Oct 2003 19:03:02 +0100,
>
> Niklas Werner wrote:
> > Hi all,
> >
> > I can't get the internal mic or recording from either usb or line-in
> > to work on a new Powerbook 15" (Aluminium).
> > The driver works (detects a "snapper"), but only for playback (and
> > DRC and bass/treble).
>
> the capture on snapper may not work.  the code was added at the time i
> had time to touch a powerbook for an hour and found that the capture
> DMA exists.  but, apparently, some codec (preamp?) initialization
> would be needed
errm, I found out, it sort of works... (playing with freqtweak)
well: the record level is sort of controlled with the master fader: 
sometimes the gain is reduced, sometimes there's just static noise 
(strange that). 
All in all it does not seem to be predictably controllable.
> perhaps one can see more detailed information in drawin.
>
maybe the darwin-sources help...
>
> Takashi

Niklas



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
