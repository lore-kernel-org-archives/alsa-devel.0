From: Juan Linietsky <coding@reduz.com.ar>
Subject: Re: Alsa MIDI device description extension proposal.
Date: Sat, 23 Mar 2002 23:14:02 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020323231402.6834fe98.coding@reduz.com.ar>
References: <20020322221629.57fa7159.coding@reduz.com.ar>
	<3C9D1F46.EDBA5BF0@hardco.de>
	<20020323221416.64d0ed46.coding@reduz.com.ar>
	<20020323223959.2c3dd215.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20020323223959.2c3dd215.coding@reduz.com.ar>
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

Oh, and you know what, I was so concentrated in my hate for sysex ;) that i just noticed that i forgot to write the most obvious point about why sysex is a no-go.

And this is basically, that what you propose would work like this:

sysex call to poll for bank description -> Midi Out
and later
Midi In <- patch listing

And this has a fatal flaw, which is basically, what i said in my first, mail... Midi is a 1-way protocol. Thus considering this, remember that 
not all deviecs have In/Out , in fact many of them are either midi IN only, and midi OUT only. Think about the sblive/awe synth, alsa sequencer clients, etc, are MIDI OUT ONLY, so it's not possible in any way to retrieve information from them via sysex.

regards

Juan Linietsky




_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
