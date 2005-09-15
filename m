From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Re: hda-intel/ALC260: crackly playback and DC offset on recording
Date: Fri, 16 Sep 2005 08:59:47 +0930 (CST)
Message-ID: <200509152329.j8FNTlBC007925@auster.physics.adelaide.edu.au>
References: <200509150051.j8F0pMoP010292@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200509150051.j8F0pMoP010292@auster.physics.adelaide.edu.au> from "Jonathan Woithe" at Sep 15, 2005 10:21:22 AM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Takashi Iwai <tiwai@suse.de>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Further to my email yesterday:

> > > > Also, try another value of position_fix.  Currently,
> > > > 
> > > > 0 = auto        check the value and correct with fifo size if needed
> > > >                 if the value is over a fifo size, turns to posbuf mode
> > > > 1 = none        use a register value as it is
> > > > 2 = posbuf      use a position-buffer
> > > > 3 = fifo        always correct with the fifo size (corresponds to 0 in
> > > >                 the earlier version)
> > > 
> > > I also did this.  Values of 1, 2 and 3 all appeared to result in clean audio
> > > output from both aplay (native ALSA API) and wavplay (OSS emulation).  Only
> > > the default setting caused the skips when OSS emulation was in use.
> > > 
> > > I enabled ALSA's debugging options including verbose printk.  However, no
> > > hda-intel DMA messages (as contained in this revised patch) were written to
> > > the log at all which was odd.  I did see other printd()/printdd() messages
> > > associated with hda-intel (prepare calls etc) so the debug code was
> > > definitely compiled in.
> :
> I'll doublecheck this again tonight since I think it a bit odd that
> 1, 2 and 3 all seemed to work while 0 didn't.

FYI I retested this last night with the same results as noted above.

Regards
  jonathan


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
