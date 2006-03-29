From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: ALSA sample rate conversion and general	performance
 improvements.
Date: Wed, 29 Mar 2006 09:52:39 -0500
Message-ID: <1143643959.3402.47.camel@localhost.localdomain>
References: <4429C5A4.7@superbug.co.uk> <s5hirpx6256.wl%tiwai@suse.de>
	<442A5B80.3010706@superbug.co.uk>
Reply-To: paul@linuxaudiosystems.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <442A5B80.3010706@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-29 at 11:03 +0100, James Courtier-Dutton wrote:
> Takashi Iwai wrote:
> > At Wed, 29 Mar 2006 00:24:20 +0100,
> > James Courtier-Dutton wrote:
> >   
> >> Hi,
> >>
> >> I have had some conversations with various people regarding some general
> >> problems some audio developers have with the current ALSA sound model.

Hi James. Not me by any chance? :)

> >> What about doing the following?:
> >> We implement a general timer in the alsa core based on something like
> >> gettimeofday(). I.e A high resolution timer.
> >> Each time a period interrupt happens, the current hw pointer is read,
> >> and recorded along with the current value of the timer.
> >> This could be used a bit like NTP to correct the generally timer rate.
> >> This gives us a general high resolution timer corrected to mirror the
> >> PCM clock on the sound card.

to correct something said later, this should be done using a DLL, not a
PLL. subtle but significant difference.

> >> Then, from this high resolution timer, we could derive any rate
> >> interrupt we need for really excellent sample rate conversion, and sub
> >> sample accurate DAC/ADC positioning.
> >> One could then read the DAC/ADC positioning really quickly by just
> >> reading the high resolution timer, instead of accessing IO Ports on the
> >> sound card hardware.
> >> This would also be a fairly minor change, as none of the current kernel
> >> sound card hw drivers would need changing. We would just have to
> >> slightly modify the period_elapsed callback to do a gettimeofday() call
> >> as well as it's current hw_pointer read.

i think its more than a minor change. the real benefit of this model
(which in my eyes correctly emulates the CoreAudio HAL) is that *if* you
have a schedulable high res timer (which linux, appallingly, still does
not have; we'll accept HZ=1000 for now, i guess), you don't need the
period interrupt to be isochronous/periodic any more - you drive user
space from the high res timer, knowing that you can have a lot of
confidence in your knowledge of where the h/w ptr(s) are. thus, USB and
FW devices, which do not have periodic interrupts driven by a sample
clock, can be used as if they do.

> >> If we then made the correction factor for the high resolution timer
> >> available to user space, user space would then not even need to read the
> >> current hw position, as it could perfectly predict it itself using the
> >> gettimeofday() and correction factor.

precisely.

> >> This would reduce the amount of calls to the read_hw_pointer function in
> >> the low level sound card hardware driver, and therefore improve performance.

the performance gain is small; the functionality gain for USB + FW is
much larger.

> > My idea is to make the system choose arbitrary irq sources, e.g. the
> > period irq, timer irq, etc.  The default is the period irq, or
> > whatever the driver provides.  But, the app or alsa-lib can switch to
> > a suitable one.

as i said above, this is basically what CoreAudio does and it seems to
be a much more flexible model than the current ALSA internals. it also
allows them to do resampling in a more flexible way than ALSA, although
admittedly, they do this in the kernel which ALSA would not.

--p




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
