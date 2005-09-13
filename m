From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Re: hda-intel/ALC260: crackly playback and DC offset on recording
Date: Tue, 13 Sep 2005 10:07:59 +0930 (CST)
Message-ID: <200509130037.j8D0bx7c005970@auster.physics.adelaide.edu.au>
References: <s5h7jdqsgbs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jdqsgbs.wl%tiwai@suse.de> from "Takashi Iwai" at Sep 09, 2005 12:09:27 PM
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

Hi Takashi

> > > Anyway, I added the check of DMA position in the latest CVS code
> > > yesterday.  Please give a shot with the latest CVS version.
> > 
> > I did this overnight.  The CVS snapshot was taken on 7 Sept 2005 at around
> > 1600 local time (UT+0930).  I tried it both with and without the
> > position_fixed module parameter.
> > 
> > Without the position_fixed module parameter, playback via aplay was crackly.
> > This is new - aplay playback under 1.0.10rc1 without the position_fixed
> > parameter was fine.  Playback via wavplay (OSS interface) was however *much*
> > worse than it used to be.  Whereas under 1.0.10rc1 it would simply be
> > crackly, under the CVS snapshot large chunks of audio were being skipped.  I
> > didn't have a change to quantify it, but it seemed to me that perhaps every
> > second block of data was being skipped.
> 
> Interesting.  Then the DMA position is somewhat weird.
> 
> > Next I retried with the position_fixed=1 parameter.  Both aplay (native alsa)
> > and wavplay (oss emulation) produced clean signal in this case, so the
> > position_fixed=1 has not changed in the CVS snapshot compared to 1.0.10rc1.
> 
> No, it's not changed.  The only position_fix=0 (default value) is
> changed.  On CVS, the DMA position is compared with the expected value
> and corrected only if necessary.

Ok, that explains why the non-default case behaved the same as it always has.

> Anyway, the below is another fix.  Now the DMA position check is done
> with every position_fix value, but the corrected only with
> position_fix=0.  Compile with debug option, so that you can see debug
> messages.
> :
> RCS file: /home/iwai/cvs/alsa/alsa-kernel/pci/hda/hda_intel.c,v
> retrieving revision 1.24
> :

This I did.  This new patch (which I applied against my 7 Sept CVS snapshot)
seems to have removed the crackles from the aplay test case.  However, the
OSS playback via wavplay was unchanged - large blocks of audio were skipped
on a regular basis.

> Also, try another value of position_fix.  Currently,
> 
> 0 = auto        check the value and correct with fifo size if needed
>                 if the value is over a fifo size, turns to posbuf mode
> 1 = none        use a register value as it is
> 2 = posbuf      use a position-buffer
> 3 = fifo        always correct with the fifo size (corresponds to 0 in
>                 the earlier version)

I also did this.  Values of 1, 2 and 3 all appeared to result in clean audio
output from both aplay (native ALSA API) and wavplay (OSS emulation).  Only
the default setting caused the skips when OSS emulation was in use.

I enabled ALSA's debugging options including verbose printk.  However, no
hda-intel DMA messages (as contained in this revised patch) were written to
the log at all which was odd.  I did see other printd()/printdd() messages
associated with hda-intel (prepare calls etc) so the debug code was
definitely compiled in.

Regards
  jonathan


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
