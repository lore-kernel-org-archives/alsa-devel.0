From: stef <stef@hardco.de>
Subject: Re: Alsa MIDI device description extension proposal.
Date: Sun, 24 Mar 2002 13:08:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3C9DC1D5.F93E2DCB@hardco.de>
References: <20020322221629.57fa7159.coding@reduz.com.ar>
		<3C9D1F46.EDBA5BF0@hardco.de> <20020323221416.64d0ed46.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Juan Linietsky <coding@reduz.com.ar>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Juan Linietsky wrote:
> 
> On Sun, 24 Mar 2002 01:35:18 +0100
> stef <stef@hardco.de> wrote:
> 
> > Nice idea, this could work for some preset synthesizers.
> > But it doesn't have to be part of Alsa.
> 
> some preset synthetizers? not really. It would perfectly
> work for any soundcard with internal synth (sound blaster awe,
> sblive, others?), alsa sequencer client programs (iiwusynth,
> timidity, saturno, others), and any external synth with either
> presets OR NOT. This is a BIG range of midi ports which could be used.

> > For example i could write a midi driver for my
> > Waldorf Microwave. It opens all HW midi port(s), sends sysex
> > to detect/find the synth, loads all patch names from the unit
> > and creates extra Alsa midi ports for each voice.
> > If the unit is in multi mode, it will create the ports
> > 'Micowave 1'..'Microwave 4'.
> 
> Yes, so whats the problem with it? you can still get patch names.
> Also, you're forgeting that 99.99% of the people wont do the approach
> you are doing, so it wont be as annoying to write patch definitions.

No problem with this, except that i don't think it should be
implemented in Alsa.

> > Midi communications to these ports will be routed to the
> > corresponding hw port and channel except a special
> > sysex, which allows the sequencer application to
> > get the patch list and to set a patch.
> 
> i dont understand this, coud you please explain this better?

The driver (not part of Alsa but an application which uses
Alsa) sits in between the hardware midi port and offers
other midi ports to sequencer applications. The sequencer
simply uses the driver's midi port instead of the real
synth/soundcard hardware port.

'Patch list request' and 'set patch' sysex sent from the
sequencer app to the synth gets captured and answered
by the driver.

> > Of course it would be nice to have a generic synth driver,
> > which reads patch names from a file as you did describe,
> > but this should not be part of Alsa.
> 
> This _has_ to be part of alsa. I'm not just talking about a standard
> way of doing patch definitions, i'm talking about a standard way of polling for patch information. This has to be managed by drivers/modules transparently for the user. Think about someone writing with soundfonts using the sblive, sbawe, iiwusynth or timidity.  There is no patch definition file there, but there is patch names, bank info which the driver DOES KNOW about. But there is no way to retrieve this info from it.
> Or think about using saturno, the alsa client dx7 emulator, which works by loading the dx7 sysex patches/banks. it does know about patches an names, but yet again the sequencing app has no way to retrieve this info. Now think this for all kind of drivers/sequecer clients that have this problem, and think how much programmer and user time can be saved if alsa can just have library calls for polling this?
> Also I think this shouldnt be done with sysex calls, first because of the extreme annoyance of parsing, and second and mainly, because if the driver is only a bridge between an external device or a sequencer client, it has no right to interfere the communication between both capturing and sending propertary sysex messages that would ALSO slow down and mess the communication.

- sysex is made for such jobs.
- it's not slow because the sysex never hits a midi cable
- it's totally ok if the driver captures and sends its own sysex,
  because it's SYStem EXclusive for the driver. It even
  is allowed to filter its own sysex from going to the
  real synth, because it can be sure that the synth(s) will
  ignore it.

> And from what i know It's not more work for the library developing,
> A driver is not supposed to be forced to answer that IO call, if
> the driver doesnt support it, will just return an error in the
> call, and alsa lib will take care of that.

Right. If you're using sysex you have to wait for the driver to
respond. Timeout some milliseconds. And you have to deal with
sysex.

No problem for me, but as you sait, i'm one of the 0,001% of
Alsa users which use external synths.

Stef(an).

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
