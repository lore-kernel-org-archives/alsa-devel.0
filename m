From: Matthias Koenig <list@phasorlab.de>
Subject: Re: Ego Sys, Miditerminal 4140 Driver
Date: Wed, 05 Apr 2006 13:36:50 +0200
Message-ID: <87lkukuuct.fsf@zebra.localdomain>
References: <87psk3ubdc.fsf@zebra.localdomain>
	<20060330170158.GG12081@turing.informatik.uni-halle.de>
	<87sloyfnu6.fsf@zebra.localdomain>
	<20060404161059.GA18884@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060404161059.GA18884@turing.informatik.uni-halle.de> (Clemens
	Ladisch's message of "Tue, 04 Apr 2006 18:10:59 +0200")
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

Clemens Ladisch <clemens@ladisch.de> writes:
>> The separate Midiport will be more flexible, however in this case the driver 
>> will have to parse the Midi message, because the hardware is controlled by 
>> other means.
>
> Then you probably shouldn't use a MIDI port for this.  Wrapping the
> control commands into some invented MIDI SysEx doesn't make sense if
> your driver just throws the wrapper away.

Well, it would make sense if there would be some standard to control
SMPTE via MIDI messages. 
However, I don't want to invent some random MIDI messages for this
purpose (also I'm not in the position to do that).  I did some tests 
with a wrapper port in the driver and used a MIDI Start/Continue/Stop 
and a MTC Full Frame SysEx message to set the time, which works but is 
probably not the desired thing.

> I think using control elements would work just fine.

Ok, I'll use control elements. Two questions:

What will the assigned interface for the controls be?
SNDRV_CTL_ELEM_IFACE_RAWMIDI ?

I see, that there are some standards on the names of the control elements,
however in this case this is not clear to me.
I need the following controls (with my name suggestions):

1. SMPTE switch: toggles generation of timecode
"SMPTE Playback Switch" Boolean
2-5. Setting the time
"SMPTE Time Hours"      Integer
"SMPTE Time Minutes"    Integer
"SMPTE Time Seconds"    Integer
"SMPTE Time Frames"     Integer 
6. Setting framerate
"SMPTE Fps"             Enumerated

Are these names Ok for ALSA?

Regards,
Matthias


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
