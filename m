From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Re: Tascam US-224/428 MMC?
Date: Wed, 21 Jul 2004 15:53:15 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <9170.195.245.190.93.1090421595.squirrel@195.245.190.93>
References: <33466.195.245.190.93.1089901175.squirrel@195.245.190.93>
    <20040720180512.GA527@tuba.home>
    <1861.195.245.190.93.1090402661.squirrel@195.245.190.93>
    <200407211523.13099.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200407211523.13099.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Karsten,
>>
>> My idea is all about having a modified us428control that would filter
>> and translate the us224 control protocol into and from standard MMC.
>> My doubts goes if this protocol is identical or at least compatible
>> on the us428.
>>
>> You may check it from the official manual:
>> http://www.tascam.com/products/US-224/pdf/us224_manual.pdf, Appendix B.
>>
>> I've already confirmed that it's actually understood on current
>> us428control from alsa-tools. My proposal goes to extending it to:
>>
>> - listen on alsa_seq input port, for MMC messages:
>> all incoming MMC messages are filtered and translated to equivalent
>> us224/us428 control protocol messages, which are handled internally as
>> usual.
>>
>> - tap on alsa_seq output port, for us224/us428 control protocol
>> messages: outgoing us224/us428 control protocol messages are mapped to
>> equivalent MMC messages, whenever applicable, which are queued out as
>> appropriate.
>
> If I understand correctly, you would implement a program for that?

Absolutely. But that may be not a complete new program, us428control is on
the radar screen :)


> I'd suggest to just patch us428controls class Cus428Midi instead:
> Make Cus428Midi a virtual Baseclass and make two Children of that:
> class Cus428MidiTascam : public Cus428Midi {
> // reuse what is currently in Cus428Midi, talcing "Tascam dialect"
> }
>
> class Cus428MidiMMC : public Cus428Midi {
> // Talk "MMC dialect"
> }
>
> Standard should be MMC.
> Maybe only use Cus428MidiTascam, if us428control is started with a special
> commandline parameter. There is no linux app capable to talk that Tascam
> dialect, no?

That's what I was asking for, but I think we shall go the us428control
route, after all it's launched by default when we plug the thing in, isn't
it?


> I'm not shure, wether its possible to reasonably map all the knobs like
> MUTE and SELECT to MMC, so maybe its more apropriate to talk a mixed
> dialect?

I was thinking on only the transport buttons and the jog wheel, for a
start. At least are those the ones that can map directly to MMC. The
fundamental idea is that us428control sends MMC outgoing messages to
applications, probably as an optional feature.

The other way around is about listening to incoming MMC messages from
applications, translate them to Tascam's control protocol and affect the
proper transport knob LEDs. That's it.


> Or create two Sequencerports for Output/Input each, that is 4 ports?
> Out MMC for Transport-Buttons
> In MMC for Transport-Buttons Lights
> Out Tascam for Other-Buttons/Sliders
> In Tascam for Other Lights.
>

Why not just two control ports? One for output, which already's up on
current us428control, another for input, being writable by e.g. a DAW
application. MMC and Tascam control protocol may coexist in the same
alsa_seq wire, don't they? As long the respective MIDI sysex and
controller messages don't clash with each other, which I'm almost sure
they don't.


> Anyhow, the listening/In Part from Applicatioon to us428control is
> completly missing up to now.
>

That's included in my proposal, of course :)

OK. I'll dive into us428control source and see what I'll be cooking in a
day or two.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
