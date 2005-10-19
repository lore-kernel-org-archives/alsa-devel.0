From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: Re: timer/sequencer driver issues: pulling my grey hair out
Date: Wed, 19 Oct 2005 08:52:06 +0200
Message-ID: <20051019065206.GA3321@rhlx01.fht-esslingen.de>
References: <20051018210040.GB27858@rhlx01.fht-esslingen.de> <1129692832.8910.51.camel@mindpipe>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1129692832.8910.51.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: andi@lisas.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,


ah, you again, and fast response, too :)

On Tue, Oct 18, 2005 at 11:33:52PM -0400, Lee Revell wrote:
> On Tue, 2005-10-18 at 23:00 +0200, Andreas Mohr wrote:
> > - why is the program configuring a dangerously low sticks value of 1?
> >   Is it due to a remaining misdeclaration of my timer attributes
> > somewhere, or is it because of this program being stupid in its timer
> > parameter choice?
> 
> Sorry, no idea.  The timer API is the one part of ALSA that is still
> quite poorly documented.  Does the timer test utility that comes with
> alsa-lib work?
I cannot confirm that currently. It was no help whatsoever in implementing
this timer, instead I used timidity/pmidi (with a reconfigured snd-seq module,
of course), since that provided some actual acustical feedback.
But I guess it should work now, given that I actually managed to achieve useful
operation yesterday, by adding a down-scale define of 100 which thus downscaled
my 10240000Hz timer to 10240Hz, enough to not cause an IRQ storm anymore and
allow the CPU (1.8GHz Athlon) to keep up with the extreme CPU requirements of
timidity (a scale factor of 50 already caused rather weird sound playback
effects due to CPU overload).

So it's finally working relatively fine, whew.
(BTW, I'm getting 10% hardirq and 5% softirq CPU load when playing that MIDI
song when downscaling by 100)
And that with an INSANELY optimized IRQ handler in my driver, mind you.

I'm planning to add an azt3328 module parameter to adjust this downscale value
manually.

> > - it's a very good idea to get rid of the "stupid" *hidden* sticks
> > bending in snd_emu10k1_timer_start(), right? Preferrably use an
> > intelligent communication instead that makes sure that the program
> > uses an sticks value that won't cause IRQ overload?
> > 
> 
> I just copied this code over from the OSS driver.  I have no reason to
> think it's correct.  All the information we have on the emu10k1's
> interval timer comes from these comment by some anonymous Creative
> engineer in emu10k1.h:
> 
> 263 #define TIMER                   0x1a            /* Timer terminal count register                */
> 264                                                 /* NOTE: After the rate is changed, a maximum   */
> 265                                                 /* of 1024 sample periods should be allowed     */
> 266                                                 /* before the new rate is guaranteed accurate.  */
> 267 #define TIMER_RATE_MASK         0x000003ff      /* Timer interrupt rate in sample periods       */
> 268                                                 /* 0 == 1024 periods, [1..4] are not useful     */
I'm just about 100% certain that this comment is due to the IRQ overload
issues. Or OTOH maybe even the emu10k1 itself doesn't manage to trigger an
IRQ properly with such a fast setting (but I highly doubt that one, it must
simply be a CPU speed issue).

I'm going to polish my driver today and then submit it ASAP.

Andreas Mohr


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
