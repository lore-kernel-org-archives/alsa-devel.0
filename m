From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: hda-intel/ALC260: mixer control issues
Date: Mon, 5 Sep 2005 09:48:00 +0930 (CST)
Message-ID: <200509050018.j850I0g7003729@auster.physics.adelaide.edu.au>
References: <s5hbr3bvlge.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbr3bvlge.wl%tiwai@suse.de> from "Takashi Iwai" at Sep 02, 2005 12:00:01 PM
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

> > I am currently trying to get ALSA working correctly on a laptop equipped
> > with an ALC260 hda chip (Fujitsu S7020).  It seems to me that the converters
> > themselves are working but the mixer controls are slightly amiss.  Playing
> > something with aplay sends something to the internal speakers, but only
> > if the control labelled "headphone" is turned up.  No signal is sent to
> > the "headphone/line out" jack even if every single mixer control is
> > set to its maximum setting.
> Adjust "Front" mixer.

It made no difference at all.  With every control at maximum there was no
audio coming from the "line out" jack.

> > There is also a "PCM" control which sometimes affects the PCM output level
> > (but I haven't been able to work out the circumstances surrounding the
> > different behaviour yet).  Curiously it's not mutable whereas every other
> > control is.
> This is a software volume control, and no mute switch is provided.
> The others are hardware mixer controls.

Having explored the ALC260 datasheet over the weekend this is now clear.
Thanks.

> > On the input side it seems that no signal gets to the ADC from the
> > mic/line-in jack regardless of what is set as the capture source.  Data is
> > captured though, suggesting a mixer routing issue again.  The signal which
> > is captured is noisy, although I haven't yet determined exactly what it 
> > is - it's clearly unrelated to what's presented at the input jack though.
> Did you raise "Capture" volume and turn on "Capture" switch?

Yes - again there was nothing.

I had the opportunity to sit down over the weekend and work through the
issues.  It turns out that this particular laptop has its sound hardware
wired up in an odd way.  I was able to get the external plugs working but
had to write my own custom ALC260 initialisation verb list to do so.

To cut a long story short, the audio inputs/outputs are connected to the
following ALC260 output pins.

 * Internal speaker: ALC260 "headphone" pin
 * "Stereo line in jack": ALC260 "mic 1" pin
 * "Stereo line out jack": ALC260 "line 1" pin (ie: NOT the "line out" pin)
 * CD audio: ALC260 "CD" pin

The reason I got nothing out of the jack is clear: ALSA configures the
ALC260 "line out" pin as output and the ALC260 "line 1" as input.  However,
in the case of this laptop ALC260 "line 1" is actually the output, with line
level input appearing at the ALC260 "mic 1" pin.  I also found I had to
explicitly unmute selected input/output widgets since the mixer doesn't
control these.

Anyway, with this understanding I was able to get audio in and out of this
laptop.  The question now is: where to from here.  I'd like to get the
revised initialisation verb list into ALSA but it's not clear how this can
be done.  As far as I can tell the ALC260 in this laptop identifies itself
using a generic ID; unless there is some other unique ID we can find there
won't be any way for ALSA to deduce which initialisation verb list is
required.  Perhaps a new module parameter?  Let me know your thoughts.

Regards
  jonathan


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
