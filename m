From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Ego Sys, Miditerminal 4140 Driver
Date: Tue, 04 Apr 2006 18:10:59 +0200
Message-ID: <20060404161059.GA18884@turing.informatik.uni-halle.de>
References: <87psk3ubdc.fsf@zebra.localdomain>
 <20060330170158.GG12081@turing.informatik.uni-halle.de>
 <87sloyfnu6.fsf@zebra.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <87sloyfnu6.fsf@zebra.localdomain>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matthias Koenig <list@phasorlab.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Matthias Koenig wrote:
> Clemens Ladisch <clemens@ladisch.de> writes:
> > Matthias K??nig wrote:
> >> There is still some work to do, the SMPTE timecode generation will
> >> need some kind of control for start/stop of timecode generation and
> >> setting the time (timecode generation is done by hardware). I'm not
> >> yet sure how to do this; can this be done by ALSA control elements
> >> or do I have to create a hwdep device, which would use ioctl?
> >
> > Most devices implement this as a separate control MIDI port for vendor-
> > specific SysEx messages, where "implements" means that the hardware does
> > it this way.
> 
> Thanks for this hint. The Windows driver of my device uses a dispatch control
> routine (the analogon to ioctl) for this purpose. So I thought this should
> be done evtl. by a hwdep device.
> The separate Midiport will be more flexible, however in this case the driver 
> will have to parse the Midi message, because the hardware is controlled by 
> other means.

Then you probably shouldn't use a MIDI port for this.  Wrapping the
control commands into some invented MIDI SysEx doesn't make sense if
your driver just throws the wrapper away.

I think using control elements would work just fine.


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
