From: Jan Depner <eviltwin69@cableone.net>
Subject: Re: Please add snd-ice1712 problem to "Known bugs" page
Date: 10 Sep 2003 15:31:50 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1063225911.8197.1.camel@eviltwin>
References: <1630-86930@sneakemail.com>
	<20030909173727.GA20549@willow.seitz.com>  <2226-33676@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2226-33676@sneakemail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sam <4l8uie002@sneakemail.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I get that "overdriven" sound using the Digital Mixer instead of PCM Out
1 and 2.  On the subject of xruns, which IRQ did you end up with???

Jan

On Tue, 2003-09-09 at 22:59, Sam wrote:
> On Tue, 2003-09-09 at 10:37, Ross Vandegrift wrote:
> > This is a feature!
> > 
> > envy24control does a much better job than just three settings - the volume
> > sliders in the Analog Volume tab lets you set it to any values, not just
> > three pre-chosen values.  Then, of course, you can mix different routes
> > with the sliders next to the level meters.  Between these, the volume
> > with ALSA is far more flexible than with Windows.  It just takes a bit
> > to get used to it.
> 
> Oh, oh...  oh!  I see!
> 
> I was feeling the sinking "I'm getting 90% of functionality with Linux
> because hardware companies don't see the light yet, sigh" and now it's
> been replaced with the less frequent feeling of "the Linux version does
> it better.  Yeah!"
> 
> Cool, thanks for setting me straight.  I brought down the analog signal
> to 110 (from 127) and it has improved the problem significantly, though
> not solved it completely.  I chose 110 by doing A/B comparisons with my
> DVD player to try to match the volume.  Unfortunately, there's still a
> slight buzzing/clicking sometimes with the Delta 44 that I don't hear
> from my Pioneer DVD player playing the same music, and it cost me less
> than the Delta 44.  :-(  I also don't hear the problem using the same
> source file through a Logitech DAC.
> 
> On Tue, 2003-09-09 at 00:44, Jaroslav Kysela wrote: 
> > I think that your problems are probably caused by underruns (system does
> > not deliver samples to the DMA buffer for your card in time). The analog
> > levels can be changed using alsamixer or envy24control (use analog
> > section). The driver fully supports your hardware and yes, it is difficult
> > to make reliable sound output for the ICE1712 chip with the standard linux
> > kernels. Look for lowlatency patches.
> 
> Thanks for the suggestion; I've already tried both low latency and
> preemptible kernel patches.
> 
> I noticed that the sound card was sharing an interrupt with three other
> devices, so I swapped PCI cards around until the sound card got its own
> IRQ.  This didn't help.
> 
> The problem is subtle enough that if this were (for example) a Creative
> Labs sound card, I'd dismiss it.  It's the fact that I was trying to
> purchase my last sound card (get that part of my life "handled", like
> the guy in Fight Club with his sofa) that's causing me to be bothered by
> this.
> 
> Though I'm no expert I'm guessing that because it's so subtle it's not a
> driver problem.  Perhaps when I get a paycheck again I'll play roulette
> and try a different high-end sound card.
> 
> Thanks for your help and suggestions (and for writing these great
> drivers).
> 
> Sam
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
