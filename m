From: stef <stef@hardco.de>
Subject: Re: Alsa MIDI device description extension proposal.
Date: Sun, 24 Mar 2002 13:22:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3C9DC4FD.3932B4A0@hardco.de>
References: <20020322221629.57fa7159.coding@reduz.com.ar>
		<3C9D1F46.EDBA5BF0@hardco.de>
		<20020323221416.64d0ed46.coding@reduz.com.ar>
		<20020323223959.2c3dd215.coding@reduz.com.ar> <20020323231402.6834fe98.coding@reduz.com.ar>
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
To: Juan Linietsky <coding@reduz.com.ar>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Juan Linietsky wrote:
> 
> Oh, and you know what, I was so concentrated in my hate for
> sysex ;) that i just noticed that i forgot to write the most
> obvious point about why sysex is a no-go.
> 
> And this is basically, that what you propose would work like this:
> 
> sysex call to poll for bank description -> Midi Out
> and later
> Midi In <- patch listing
> 
> And this has a fatal flaw, which is basically, what i said in
> my first, mail... Midi is a 1-way protocol. Thus considering
> this, remember that not all deviecs have In/Out , in fact many
> of them are either midi IN only, and midi OUT only. Think
> about the sblive/awe synth, alsa sequencer clients, etc,
> are MIDI OUT ONLY, so it's not possible in any way to retrieve
> information from them via sysex.

No problem. If the connection to the hardware is IN only,
the driver can retrieve the patch list from a file.

The sysex discussion was about the connection
synth driver <-> sequencer app. So the port the driver
creates (and the seqencer uses) has to be bidirectional.

You don't have to retrieve sysex from the soundcard but from the
driver. There could be a 'generic' driver which answers
sysex requests from the sequencer app based on the contents of
a file, and maybe some synth specific drivers, which use
a bidirectional connection to the synth to retrieve patch lists.

The sequencer app doesn't have to deal with that difference.


Stef(an).

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
