From: Juan Linietsky <coding@reduz.com.ar>
Subject: Re: Alsa MIDI device description extension proposal.
Date: Sun, 24 Mar 2002 13:44:35 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020324134435.355b3e4d.coding@reduz.com.ar>
References: <20020322221629.57fa7159.coding@reduz.com.ar>
	<3C9D1F46.EDBA5BF0@hardco.de>
	<20020323221416.64d0ed46.coding@reduz.com.ar>
	<20020323223959.2c3dd215.coding@reduz.com.ar>
	<20020323231402.6834fe98.coding@reduz.com.ar>
	<3C9DC4FD.3932B4A0@hardco.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <3C9DC4FD.3932B4A0@hardco.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 24 Mar 2002 13:22:21 +0100
stef <stef@hardco.de> wrote:

> Juan Linietsky wrote:
> > 
> > Oh, and you know what, I was so concentrated in my hate for
> > sysex ;) that i just noticed that i forgot to write the most
> > obvious point about why sysex is a no-go.
> > 
> > And this is basically, that what you propose would work like this:
> > 
> > sysex call to poll for bank description -> Midi Out
> > and later
> > Midi In <- patch listing
> > 
> > And this has a fatal flaw, which is basically, what i said in
> > my first, mail... Midi is a 1-way protocol. Thus considering
> > this, remember that not all deviecs have In/Out , in fact many
> > of them are either midi IN only, and midi OUT only. Think
> > about the sblive/awe synth, alsa sequencer clients, etc,
> > are MIDI OUT ONLY, so it's not possible in any way to retrieve
> > information from them via sysex.
> 
> No problem. If the connection to the hardware is IN only,
> the driver can retrieve the patch list from a file.
> 
> The sysex discussion was about the connection
> synth driver <-> sequencer app. So the port the driver
> creates (and the seqencer uses) has to be bidirectional.
> 
> You don't have to retrieve sysex from the soundcard but from the
> driver. There could be a 'generic' driver which answers
> sysex requests from the sequencer app based on the contents of
> a file, and maybe some synth specific drivers, which use
> a bidirectional connection to the synth to retrieve patch lists.
> 
> The sequencer app doesn't have to deal with that difference.
> 

Yes, but then again, what i'm saying is that in a lot of cases you dont have that. My main point is that you will have to use a patch definition file ONLY when the driver doesnt support sending you patch names (which happens, as you said, if we're talking about a bridge midi port which connects to external harware). In _other cases_ such as soundcard synths, or software synths running as sequencer client, the driver/app itself is able to give you the patch/bank information directly, so there's no point in reading them from a file. Lets say that you are using a sound blaster live. You go and type:

sfxload mysoundfont.sf2

Which uploads the patches to the soundcard using snd-synth-emu10k1 driver.
the patch names are inside of the .sf2 archive, and are uploaded to the card together with the sampledata. The driver has the patch names and the banks, so, how would you retrieve them? see how nothing except a library call is an option. Sysex will simply not work, because this device is midi out only. A patch definition file would be retarded since not only the driver has all the info, but you can contantly be changing soundfonts every time you're going to compose, so writing a patch defintion file out of a soundfont every time you get one is just very annoying. Not to mention all kind of other sequencer clients. Lets say I'm using rx/saturno (the yamaha dx7 emulator), which connects through sequencer client api. 
It proovides a midi out port for apps, but not midi in. And Lets say I
keep loading hundreds of different d7x patches. Converting them to ALSO patch file definitions is annoynig, and this follows for any existing app and any app to be written. It's just annoying.
So as you see, sequencer client apps proovide a midi out port only. to add support for sysex, both squencer client and squencer app mantainers will be forced to add port reading/writing in the inverse direction only to retrieve patch names, which i think goes beyond the line of annoyance.
And what about those multiplexer boxes that give you 5 midi outs and no midi in? even for external synths.. you wont be able to use the bidi connection to retrieve patch names.

All this could be easily done with just a library call and support for it in the drivers/sequencer client apps. It's much nicer to use for the programmers, much cleaner as implementation, and will allways work whathever the case is. So why not doing a midi library call?
Being that case that we're talking about alsa, i think it's simpler
overall to do it this way, instead of having to resort to sysex, which is a hack to overcome the limitations of a braindead and obsolete protocol such as MIDI is.


      
regards

Juan Linietsky
