From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: Re: Tascam US-224/428 MMC?
Date: Wed, 21 Jul 2004 15:23:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407211523.13099.annabellesgarden@yahoo.de>
References: <33466.195.245.190.93.1089901175.squirrel@195.245.190.93> <20040720180512.GA527@tuba.home> <1861.195.245.190.93.1090402661.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1861.195.245.190.93.1090402661.squirrel@195.245.190.93>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Mittwoch 21 Juli 2004 11:37 schrieb Rui Nuno Capela:
> Martin, everybody,
>
> >> I remember some time ago, while fighting to get some LEDs lighten up
> >> on my us224 from linux, it was then referred that us428control would
> >> possibly act as a MMC proxy or something like to it.
> >>
> >> Then I was wondering if I could get my us224 to act like a "real"
> >> control surface with some linux DAW (i.e. ardour :), being able to
> >> effectively use the transport buttons, the jog wheeel, etc.
> >>
> >> Are you guys having any luck with this issue? I'm assuming that us224
> >> is the lil'sister of us428, and I'm guessing that the command control
> >> protocol is quite the same. Am I right?
> >
> > comparing some log-files of usbsnoopy (or any similar program) should
> > solveit. But I, too, believe that 224/428 are nearly the same on a high
> > level.
>
> My idea is all about having a modified us428control that would filter and
> translate the us224 control protocol into and from standard MMC. My doubts
> goes if this protocol is identical or at least compatible on the us428.
>
> You may check it from the official manual:
> http://www.tascam.com/products/US-224/pdf/us224_manual.pdf, Appendix B.
>
> I've already confirmed that it's actually understood on current
> us428control from alsa-tools. My proposal goes to extending it to:
>
> - listen on alsa_seq input port, for MMC messages:
> all incoming MMC messages are filtered and translated to equivalent
> us224/us428 control protocol messages, which are handled internally as
> usual.
>
> - tap on alsa_seq output port, for us224/us428 control protocol messages:
> outgoing us224/us428 control protocol messages are mapped to equivalent
> MMC messages, whenever applicable, which are queued out as appropriate.

If I understand correctly, you would implement a program for that?
I'd suggest to just patch us428controls class Cus428Midi instead:
Make Cus428Midi a virtual Baseclass and make two Children of that:
class Cus428MidiTascam : public Cus428Midi {
// reuse what is currently in Cus428Midi, talcing "Tascam dialect"
}

class Cus428MidiMMC : public Cus428Midi {
// Talk "MMC dialect"
}

Standard should be MMC.
Maybe only use Cus428MidiTascam, if us428control is started with a special 
commandline parameter. There is no linux app capable to talk that Tascam 
dialect, no?
I'm not shure, wether its possible to reasonably map all the knobs like MUTE 
and SELECT to MMC, so maybe its more apropriate to talk a mixed dialect?
Or create two Sequencerports for Output/Input each, that is 4 ports?
Out MMC for Transport-Buttons
In MMC for Transport-Buttons Lights
Out Tascam for Other-Buttons/Sliders
In Tascam for Other Lights.

Anyhow, the listening/In Part from Applicatioon to us428control is completly 
missing up to now.

best,
Karsten


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
