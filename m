From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [Realtek ALC260] Can't enable SPDIF out
Date: Tue, 5 Sep 2006 12:51:02 +0930 (CST)
Message-ID: <200609050321.k853L2l2031398@auster.physics.adelaide.edu.au>
References: <44F8760D.8090404@p54A1ACFB.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44F8760D.8090404@p54A1ACFB.dip0.t-ipconnect.de> from "Andreas
	Hartmann" at Sep 01, 2006 08:03:57 PM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: alsa-devel@lists.sourceforge.net, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Andreas

> alsamixer or kmix do have a switch for S/PDIF. You can switch it on or off
> - the output is always analog.

That switch I think only enables SPDIF at the chip level.  It would not
change any signal routing done outside the chip.

> > With the ALC260 chip the digital output is totally separate to the analog
> > DAC.  If, for example, you were tryiung to test SPDIF by sending audio data
> > to the same pcm interface as you use to get analog audio output there's no
> > way SPDIF will work.
> 
> Ok - but I have just one pcm interface (in alsamixer and kmix) - nothing
> more. Therefore, there seems to be one pcm interface missing.

I don't think the digital output will give you a second PCM control in
alsamixer; I think that's a software control created by alsa for analog 
channels.

> > This might be something worth looking into if you haven't already.  When
> > testing SPDIF output make sure you're sending to the pcm interface
> > associated with the SPDIF (digital) output.
> 
> Could it be possible, that there is just one pcm interface, which can be
> switched to the one (analog) or other (S/PDIF) format?

The "pcm" control in alsamixer is not necessarily the same as the "pcm"
interfaces I've been talking about.  Sorry for any confusion I've caused - I
forgot about the alsamixer control labelled "pcm".  By pcm interface I'm
referring to the "hw:0"/"hw:1"/"default"/"spdif"/etc designators one can use
when specifying the output device for things like aplay.

> Now, I tested with aplay.
> 
> andreas@notebook1:~> aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: Intel [HDA Intel], device 0: ALC260 Analog [ALC260 Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: Intel [HDA Intel], device 1: ALC260 Digital [ALC260 Digital]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0

This is interesting.  Those on the list more knowledgeable than I might
be able to correct me here, but I would interpret this to mean that
"device 0" (ie: hw:0) is your analog output while device 1 (ie: hw:1)
sends direct to the SPDIF channel on the ALC260.

> If I'm using aplay -D default, the output is analog. If I'm using -D
> iec958 or spdif, there isn't any output. Btw.: using -D spdif or iec958
> switches on the spdif switch in the mixer.

Right, so my interpretation of that is that in terms of the software,
the "-D spdif" is probably doing the right thing in that the data is being
sent to the SPDIF portion of the chip.  The fact that no SPDIF bitstream
appears probably has something to do with external switching employed
by your laptop which ALSA currently doesn't know about.

How are you testing for the existance of an SPDIF bitstream by the way?

> > ... Given past experience with Acer laptops, it would not surprise me to
> > find that your laptop uses one of the GPIO controls to switch SPDIF
> > output to the output jack.  For this reason I would start with the GPIO
> > controls.
> 
> What is GPIO controls? And what is "capture" (I can see two capture
> controls in alsamixer or kmix).

"Capture" refers to recording signals from audio sources (a microphone
for example).  A "capture" device is one used to record from.

GPIO stands for "General Purpose Input Output".  GPIO lines are additional
uncommitted digital I/O lines provided on some chips by some manufacturers.
The idea is that sometimes a system integrator might might a handful of
additional digital control lines, and having these available from (in this
case) the audio codec can save the hassle of having to arrange additional
circuitry to provide them.

The ALC260 chip provides 4 such lines.  In many situations they (such as in
my laptop) they are unused.  However, that doesn't mean they aren't used in
other cases.  For instance, there is an Acer laptop using the ALC260 chip
which uses GPIO0 to turn on the amplifier used for the (from memory)
internal speakers and/or external headphone jack.

You mentioned in a later email:
> They must ensure, that the S/PDIF signal doesn't collide with the output
> of the analog amplifier (if they have an own). I saw in the datasheet for
> the ACL260 chip, that there is a verb with the function SET_EAPD_ENABLE
> (-> extern amplifier power down). Maybe, this should be called before
> starting SPDIF out (if it's not already done).

I doubt there would be a need to disable any amplifier before doing SPDIF
since anyone designing these things are extremely unlikely to directly
couple the two outputs together.  Instead they would at the very least be
isolated with a resistor and this would allow a (potentially attenuated)
digital signal to pass in all cases.  Anything's possible though.  Far more
likely is that they have a signal switch in place between the ALC260's
analog/digital output pins and the external jack.  There is a very high
likelihood that this switch is controlled by one of the GPIO lines.  This
would explain why you get nothing when using the spdif device argument to
aplay.  We need to work out how to control that signal switch.

You also mentioned:
> Maybe, there is a special jack plug needed? I'm using a standard stereo
> jack plug.

Highly unlikely - I suspect the socket is a standard mini-jack and that it's
switched as described previously.

You also mentioned the devices being opened by aplay with different aplay
"-D" settings.  These seem to confirm that device 1 is the digital output
and device 0 is the analog output.  What we need to work out is precisely
how one switches the digital output to the headphone jack.  My money's on
one of the GPIO lines.

I didn't get a chance to look into this in greater detail over the weekend.
However, given the extra information now provided I'll see about doing up
a small test patch to test the GPIO theory.  If that turns out to work
we can look into doing a permanent fix.

Regards
  jonathan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
