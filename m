From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: More detailed Acer (Intel HDA)
Date: Wed, 22 Mar 2006 11:11:08 +1030 (CST)
Message-ID: <200603220041.k2M0f8uA011967@auster.physics.adelaide.edu.au>
References: <441E50A6.3030100@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <441E50A6.3030100@akl.lt> from "Rimas Kudelis" at Mar 20, 2006 08:50:14 AM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rimas Kudelis <rq@akl.lt>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi again.

> > That thread is too long.  Please describe briefly exactly what the
> > unexpected behavior is and how you think it should work and file an ALSA
> > bug report.
> 
> That thread was started long before the acer model was actually added to
> hda-intel driver. Everything that I find unexpected is written in the
> exact post I linked to.

Ah, found it now.  That "=3D" thing caused the forum website to do something
odd.  Anyway, having now read the forum post most of my comments in my
previous posting still stand.  In short, the driver and the hardware appear
to be operating pretty much as expected.

Running through that post:

> For [Headphone Jack Mode]
> ->Mic 50 bias or Mic 80 bias: you can not select them at all. They apear 
>   in the drop down list but when you try to select one it changes 
>   automatically to "Line in" option.

This is most likely due to the hardware limitation of the ALC260 chip I 
mentioned in my earlier post.  If either NID 0x0f or 0x10 is the pin 
widget used for the headphone jack on these laptops then the mic modes
are not activated by the hardware when selected.  This is not mentioned
in the datasheet.

The driver checks for the success of the mode setting and if it doesn't
work it will revert to a mode which does.  If the user selected a "mic"
mode then presumedly they want to record something, so "line-in" is the 
next best alterative that the hardware supports.

> ->"Line in": it doesn't work. In fact it can't work since you haven't got 
>   a "Headphone" option in Input source.

"Line in" would work if the input source for the Acer model included the
headphone jack as an option.  However, one would have to test it with a
source which did not require a bias voltage since as already explained
this pin widget can't provide one.  A CD player or something like that 
would have to be used.

Adding a "headphone" option to the input sources for the acer model will
probably have to wait until I've got my patch in order which adds the
ability to have different input source lists for different ADCs.  The
datasheet shows that NIDs 0x0f and 0x10 feed different inputs on the
different ADCs.  To avoid confusion, we need the ability to define separate
input source lists for different ADCs.  I shall endevour to get this patch
in order by early next week.

> ->"Line out" or "Headphone out": work ok but without any difference on 
>   their output level (1 volt RMS).

Based on the test method described it seems the output voltage was measured
across an unloaded jack.  If so then I would not expect any difference
between the "line out" and "headphone" modes since the difference comes
about due to the impedence presented by the load.  If this was measured with
a 22 ohm resistor connected across the jack I expect one will find a
substancial level difference.

> For [Line Jack Mode]
> ->"Mic 50 bias" or "Mic 80 bias" or "Line in": work ok when you plug a 
>   line signal without any difference on their recording level. Plugging a 
>   mic here only records background noise.

For a line-level signal the "mic" and "line" modes won't make a great deal
of difference, although the noise level is likely to be higher with the "mic"
mode.  The presence of the bias voltage might also have some interesting
interactions with the output circuitry of some devices.

As to the mic, I can't explain that.  I'm guessing it was one of those cheap
so-called "computer" mics.  If so, "Line in" mode will certainly not work
since these mics require a bias voltage in order to function.  You will
indeed record only background noise.  One (or both) of the "mic" modes
should work though, and people have certainly reported mics working in these
modes when using the "Acer" model.  I wonder whether things were perhaps not
set up correctly for recording?  In addition to selecting the this input as
the input source for "Capture" (not "Capture 1" since most recording
programs don't allow one to select the ADC if there's more than one, and
default to the first one), one also has to enable "Capture" by finding it in
the Capture section of alsamixer, highlighting "Capture" and pressing
<space>.

Another possibility is that Acer have included series blocking capacitors
between the ALC260 and the physical jack (this is probably more likely since
the post indicates that recording was successfully done later on).  Such
capacitors would block any bias voltage sent by the ALC260 and thus stop any
condensor microphones from working. This can be easily tested: put a
volt-meter onto the unloaded/undriven jack and observe the output DC voltage
in the three input modes ("mic 50%", "mic 80%" and "line in").  For "line
in" it will be close to 0.  For the other two it should be around 1.65V and
2.64V respectively (assuming the ALC260 is being fed with 3.3V).  If both
mic modes result in very little voltage then that probably confirms that
there's a DC block in place within the laptop which will prevent condensor
mics from working in this jack unless they have provision for their own
power supply.

On reflection this second option is probably more likely.  Acer probably
summised that mics can go into the "mic" jack while line-level sources can
go into the "line in" jack.  As such the "line in" jack has no need of bias
voltages, so they block DC to prevent any bias voltages produced by the
ALC260 from having any interaction with connected sources.

> ->"Line out" and "Headphone out" work ok in stereo with just the same 
>   output level in both cases (1.2 volts).

I suspect the reason the output level doesn't change is the same as for the
"headphone" jack before: either a low impedence load was not in use when the
voltage was measured or the headphones being used to do the loading are of
the high-impedence type.

> For [Mic Jack Mode]
> ->"Mic 50 bias" or "Mic 80 bias" or "Line in": plugging a mic you record 
>   with first and second options just with the same level.With "Line in" 
>   you only record noise. Plugin a line signal you get just the same 
>   recording level in the three cases.

Completely expected on all counts.  In this case the person's mic is happy
with the 50% voltage bias so I would be inclined to use that.  As explained
before, "Line in" mode removes the bias voltage, so condensor-type
microphones will no longer operate.

An interesting question: I wonder whether a stereo line-in source recorded
in mono or stereo via this jack.  Given the next comments (see below) I
suspect the summed left and right signal would have been sent to both input
channels.

> ->"Line out" and "Headphone out" work ok but in mono (only outputs the 
>   mixed two stereo channels to left channel) with just the same output 
>   level in both cases (1.2 volts).

In terms of the output voltage measurement the same comment applies here as
to the other pins.

The presence of the mono signal in the left channel almost certainly
confirms that the jack is actually a mono jack.  This would not be all that
surprising since most jacks labelled "mic" on laptops are in fact mono. 
It's interesting that left and right are mixed; Acer presumedly has
connected the pin widget's left and right channels together, possibly via
low-value isolation resistors.  The rationale for this would be along the
lines I mentioned in my previous post: "most computer-consumer mics are mono,
so let's make the mic jack mono but feed the signal to the ADC's left and
right inputs to avoid confusing the consumer".

A comment on the test method: was the AC voltmeter in use reliable at a
frequency of 440 Hz.  For most voltmeters the AC scale is calibrated to read
RMS of a sine wave at 50 Hz.  Many cheaper models fall off quite badly at
frequencies higher than 100 Hz.  Since a reasonable reading was achieved
it's probably academic, but it's worth considering.

Again from the Ubantu forum post:

> Second Input source does nothing. You only record silence if you select
> only the second Input source.

No mention was made of the recording software used.  However, I suspect this
is because the software cannot be told to use the second ADC as its input
source.  Simply enabling the second ADC in alsamixer will not make it the
default ADC of recording software - this actually only unmutes the input to
the second ADC.  The first ADC is always pcm0c while the second is always
pcm1c.  If the software cannot be told to use pcm1c as its source then it
will never be able to record from the second ADC.  This is most likely the
reason why the second ADC couldn't be recorded from since a vast majority
of the audio recording software doesn't allow the source to be changed.

To test the second ADC, the user must get software which allows the capture
device to be changed, and then they must change the capture device within
that application.  Simply unmuting the second capture device in alsamixer 
is not sufficient.

> After I check everything, i'm willing to write a small patch that removes
> all non-working features (like CD and Beep controls) from the current acer
> model and, maybe, adds one or two that are not currently in.

I'm not entirely sure that there are any missing since the test results in
so far indicate that everything's covered.  There might be a corner case
though.

On these Acer laptops the evidence thus far indicates that there is no audio
connection between the CD drive and the sound card.  Therefore the CD
control could possibly be removed, but ONLY from the "acer" model.  The beep
control could be removed from the "acer" model if you like too; leave it
on the fujitsu model at least for the moment.

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
