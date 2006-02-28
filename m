From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] Add support for Acer TravelMate and similar laptops
Date: Wed, 1 Mar 2006 09:52:50 +1030 (CST)
Message-ID: <200602282322.k1SNMobk019048@auster.physics.adelaide.edu.au>
References: <44049F25.2070904@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <44049F25.2070904@akl.lt> from "Rimas Kudelis" at Feb 28, 2006 09:06:13 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net, Paulo Matias <syscoder@gmail.com>, Rimas Kudelis <rq@akl.lt>
List-Id: alsa-devel@alsa-project.org

Hi Rimas

> I'm testing the CVS driver now. The Acer model works well. That's cool.

Excellent news.  Thanks for confirming.

> 1) the CD and Beep controls seem like not doing anything, even after
> playing with GPIO pins. If a few more Acer owners confirm this (Paolo?),
> I guess these should be removed (or even better, commented out in the
> code - in order for someone motivated to fix them).

The beep is unlikely to do anything until someone implements a beep
generator driver somewhere.  I've left the control in there because it does
no harm and might provide the incentive for someone to do so.  The "beep"
control refers to the volume delivered by an on-board beep generator on the
ALC260.  Currently that generator isn't used by ALSA or any other driver and
so that mixer control won't do anything.

I'm not actually sure how one might make use of the beep generator.  If the
system wants to "beep" that's usually initiated from way outside ALSA. 
Precisely how to make that part of the kernel talk to ALSA will need to be
worked out, if it's deemed important enough by someone.

> Also, the CD can be removed from the input sources list if nobody reports
> CD capture as working.

That is true, but it's probaby wise to wait to see what reports come in
first.

> I'm not trully sure about how Audio CD playing should work in general. Do
> I understand it correctly by assuming that the CPU doesn't need to be
> involved in Audio CD playing?

Ordinarily that is correct, yes.

> My assumption was that the CD drive simply redirects the bits on the disk
> to the soundcard, but i was apearantly oversimplifying things.

Normally the CD drive would deliver an analog audio signal to the sound
card, not a digital bitstream.

> Maybe the CD drive itself needs some more "weight" to support this (i.e.,
> some sort of an internal decoder), and maybe the drive that is present in
> Acer (Slimtype DVDRW SOSW-833S) simply doesn't support audio CD hardware
> decoding, and expects software to handle this task? That would probably be
> reasonable for a slim notebook CD/DVD drive.

The "CD" input on the ALC260 is an analog input.  It expects the CD drive to
do all the audio decoding and present an ordinary stereo signal to this pin. 
If when playing a CD and enabling the "CD" control you get no audio that
strongly suggests that there is no audio signal running to that pin.
However, if there is no analog connection to the ALC260 one does wonder
precisely how these systems are expected to play CDs.  The only option 
left would be for software to read the raw CD bitstream (which isn't a straight
audio bitstream), decode it and then send the resulting audio bitstream to
the DAC.  Given that CD drives are more than capable of doing all this it would
surprise me if this were the case.

One thing worth checking though - have you tested *all* ALC260 inputs with
the CD playing?  Maybe Acer connect the CD audio to some other ALC260 pin.

> 2) Capture. It actually works. The noise I referred to previously seems to
> be because of a looping sound or something else, I'm not sure. The thing
> is that the capturing from Capture channel works even when its volume is
> set to zero (or it's simply "muted" in Gnome mixer). All it needs is to be
> selected for capture. So when I set its volume to low enough, the noise
> disappears, and I can actually record my tapping.

The capture gain, when set to minimum, seems to be about unity.  So long as
your signal is of reasonable strength you will not need to increase the
capture control much at all.  As you increase it, especially as it gets
close to the maximum, you will get an increase in noise due to the high
gains being done by the input amplifiers and the relatively noisy electrical
environment they are in.

> The recording quality is terrible though. but I'm not sure if it's because
> I tapped the notebook instead of speaking, or if something is wrong with
> the model.

If this is the internal microphone then I'd say it's because it's an
internal microphone.  Those things in my experience are of very low quality
- even compared to the ADCs in the ALC260. :)

> Also, I don't quite understand why I can record sound with
> zero volume. Jonathan, does recording work smoothly for you?

Absolutely.  I've done several 4 track recordings now and everything works
well.  See above for why recording works with the control set at minimum. 
The point to note is that the control's minimum is not actually "zero
volume" (ie: a gain of minus infinity); rather it represents a gain of maybe
-10 dB or -20 dB, at least on my laptop.  It's also likely that Acer has put
their own amplifier chip between the mic and the ALC260, in which case the
ALC260's control minimum might well represent a higher gain than in my
laptop (and your comments do tend to suggest that this is the case).

> 3) I couldn't find any settings dialog in Gnome Sound Recorder, it only
> allows me to run the Gnome mixer in which I can enable the capture
> sources. May I suppose it can record from both ADC's simultaneously, if
> these are enabled?

Based on my understanding of Gnome Sound Recorder (having never used it) I
don't think so.  Without any settings dialogs I would assume it will record
from the first PCM interface on the first ALSA card it finds (conceptually
"pcm0" if you like).  Even if both capture sources are unmuted (which is all
the alsamixer mute/"enable" control does), software must explicitly open the
second PCM device if it wishes to record from it.  The default would clearly
be not to do this since soundcards can't be assumed to have two PCM capture
devices.

If you wanted to record both ADCs into the same 2 channel sound file, the
recording software itself would have to open both PCMs and do the averaging
itself.  Similarly, to record the second ADC the software must open the
second ADC.

The only other way to record more than one source at once is to use the
"mixer" as the recording source (available only to the ADC with NID 0x5). 
Currently this is not one of the capture sources available in the Fujitsu
model because it adds extra noise to the recordings and I have no use for
recording a mix of different sources in this way.  If I want to record a mix
of signals I'll use an external mixer since it's more flexible and has lower
noise.

Adding the mixer as an input source will require the implementation of
support for different capture lists for different ADCs.  If there is
interest in having this support I'll look into adding this over the next
week or so - let me know.

> Also, after I enable Capture 1 solely, I only record silence.

Yep, because "capture" ("capture 0" if you like) is effectively muted in
this condition and that is all your recorder is probably recording - see
above.  The alsamixer "enable" control for the capture channels is
effectively only a "mute".  It doesn't set up routing to pcm0 and pcm1 as
seen by applications.

If you want to experiment with the second capture source, grab a small
recording applet which allows you to specify the recording device.  Offhand
I can't give any recommendations beyond "batchrec" which I wrote (and use)
myself.  This is an OSS program, so the device to open if you want the
second ADC is /dev/adsp (assuming ALSA's OSS emulation modules are loaded).
You can pick the program up from

  http://www.physics.adelaide.edu.au/~jwoithe/batchrec-1.2.0.tgz

if you're interested.  It's text-mode only.

> Furthermore, setting second input source to Line on module load (that's
> what I tried to do with the acer model) doesn't work for some reason:
> initially, both input sources are still being set to "Mic".

I'm not quite sure I understand what you mean.  Do you mean that you set the
input source to "Line", unload the module and then reload it?  If so then
the behaviour you see is probably correct.  On reload controls are generally
reset to some default.  If you want to restore settings, take a look at
alsactl.  If this isn't the issue please let me know more details.

> Plus, the last line in the informational box of AlsaMixer v1.0.9a:
> > Card: HDA Intel
> > Chip: Realtek ALC260
> > View:  Playback  Capture [All]
> > Item: Input Source 1 1
> makes me worry.

This is interesting; I can't reproduce this on my laptop.  However, I'll
have another go with CVS now that everything's been merged though and let
you know.  What are the corresponding lines for the "Capture" channel?

> Concluding all this, I think if noone (Paolo?) reports Capture 1 as
> working, It may probably just as well be removed (I guess this means using
> alc260_adc_nids instead of alc260_dual_adc_nids on Acers).

I think you'll find that "Capture 1" is working - it's just that none of
your recording software is capable of using it.

> 4) After toggling SPDIF playback/capture in test model a few times, I
> got the following error in dmesg:
> > [4300161.577000] ALSA
> > /usr/src/alsa-cvs/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:515:
> > hda_intel: azx_get_response timeout, switching to single_cmd mode...

Interesting.  You're not running a kernel with Ingo's realtime preemption
patches, are you?

> Furthermore, the SPDIF controls aren't available in Gnome mixer.

I can't really comment - I don't use Gnome mixer.  I'm surprised though;
if they show in alsamixer I would have expected other mixer apps to see them
(unless of course those mixer apps are incomplete).

> I suppose these controls will need debugging from someone with a real
> SPDIF channel handy.

Yep, indeed.  They still shouldn't give that error though since the SPDIF
interface is still present on the ALC260 even if it doesn't have an outside
connection.  I'll look into this too.

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
