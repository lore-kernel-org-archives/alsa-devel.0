From: Christian Henz <chrhenz@gmx.de>
Subject: Re: ALSA sample rate conversion and general	performance improvements.
Date: Wed, 29 Mar 2006 19:31:29 +0200
Message-ID: <20060329173129.GA27846@homer>
References: <4429C5A4.7@superbug.co.uk> <s5hirpx6256.wl%tiwai@suse.de> <442A5B80.3010706@superbug.co.uk> <1143643959.3402.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1143643959.3402.47.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 29, 2006 at 09:52:39AM -0500, Paul Davis wrote:
> On Wed, 2006-03-29 at 11:03 +0100, James Courtier-Dutton wrote:
> > Takashi Iwai wrote:
> > > At Wed, 29 Mar 2006 00:24:20 +0100,
> > > James Courtier-Dutton wrote:
> > >   
> > >> Hi,
> > >>
> > >> I have had some conversations with various people regarding some general
> > >> problems some audio developers have with the current ALSA sound model.
> 
> Hi James. Not me by any chance? :)
> 
> > >> What about doing the following?:
> > >> We implement a general timer in the alsa core based on something like
> > >> gettimeofday(). I.e A high resolution timer.
> > >> Each time a period interrupt happens, the current hw pointer is read,
> > >> and recorded along with the current value of the timer.
> > >> This could be used a bit like NTP to correct the generally timer rate.
> > >> This gives us a general high resolution timer corrected to mirror the
> > >> PCM clock on the sound card.
> 
> to correct something said later, this should be done using a DLL, not a
> PLL. subtle but significant difference.
> 
> > >> Then, from this high resolution timer, we could derive any rate
> > >> interrupt we need for really excellent sample rate conversion, and sub
> > >> sample accurate DAC/ADC positioning.
> > >> One could then read the DAC/ADC positioning really quickly by just
> > >> reading the high resolution timer, instead of accessing IO Ports on the
> > >> sound card hardware.
> > >> This would also be a fairly minor change, as none of the current kernel
> > >> sound card hw drivers would need changing. We would just have to
> > >> slightly modify the period_elapsed callback to do a gettimeofday() call
> > >> as well as it's current hw_pointer read.
> 
> i think its more than a minor change. the real benefit of this model
> (which in my eyes correctly emulates the CoreAudio HAL) is that *if* you
> have a schedulable high res timer (which linux, appallingly, still does
> not have; we'll accept HZ=1000 for now, i guess), you don't need the
>

Hmm, I though that we DO have schedulable high res timers
now with the recent hrtimers merge? At least thats what I 
got from watching the video of the talk on RT patches at 
FOSDEM (http://free-electrons.com/community/videos/conferences).
I might have to watch it again to see if that only applied to
the -rt patch...


cheers,
Christian


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
