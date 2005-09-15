From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Re: hda-intel/ALC260: crackly playback and DC offset on recording
Date: Thu, 15 Sep 2005 10:21:22 +0930 (CST)
Message-ID: <200509150051.j8F0pMoP010292@auster.physics.adelaide.edu.au>
References: <s5hoe6xfhcj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoe6xfhcj.wl%tiwai@suse.de> from "Takashi Iwai" at Sep 13, 2005 11:27:08 AM
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
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > > Also, try another value of position_fix.  Currently,
> > > 
> > > 0 = auto        check the value and correct with fifo size if needed
> > >                 if the value is over a fifo size, turns to posbuf mode
> > > 1 = none        use a register value as it is
> > > 2 = posbuf      use a position-buffer
> > > 3 = fifo        always correct with the fifo size (corresponds to 0 in
> > >                 the earlier version)
> > 
> > I also did this.  Values of 1, 2 and 3 all appeared to result in clean audio
> > output from both aplay (native ALSA API) and wavplay (OSS emulation).  Only
> > the default setting caused the skips when OSS emulation was in use.
> > 
> > I enabled ALSA's debugging options including verbose printk.  However, no
> > hda-intel DMA messages (as contained in this revised patch) were written to
> > the log at all which was odd.  I did see other printd()/printdd() messages
> > associated with hda-intel (prepare calls etc) so the debug code was
> > definitely compiled in.
> 
> snd_printd() appears only when compiled with CONFIG_SND_DEBUG=yes.
> snd_printdd() when CONFIG_SND_DEBUG_DETECT=yes.
> They correspond to --with-debug=full and --with-debug=detect in the
> case of alsa-driver's configure script option.

Yep, noted.  When I was testing the above both CONFIG_SND_DEBUG and
CONFIG_SND_DEBUG_DETECT were set to "yes" in config.h.

I'll doublecheck this again tonight since I think it a bit odd that
1, 2 and 3 all seemed to work while 0 didn't.

Regards
  jonathan


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
