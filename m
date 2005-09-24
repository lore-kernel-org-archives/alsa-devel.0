From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: Midi Out help
Date: Sat, 24 Sep 2005 12:50:56 +0100
Message-ID: <20050924115056.GC11980@palantir8>
References: <BAY13-F10379A920748A144124373EE890@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mra03.ex.eclipse.net.uk (mra03.ex.eclipse.net.uk [212.104.129.88])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 76820146
	for <alsa-devel@alsa-project.org>; Sat, 24 Sep 2005 13:51:00 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <BAY13-F10379A920748A144124373EE890@phx.gbl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 24, 2005 at 11:20:42AM +0300, Radu Olaru wrote:
> I'm trying to send Midi messages to another Alsa program, a synth actually. 
> Well, I cannot hear any sound from the synth if I'm sending messages using 
> the program below. Please, PLEASE help me. It's verry important.

You're sending messages on an input port, i.e. one that is read-only.
Try creating an output port. One you can write to.

...
> 	snd_seq_create_simple_port(handle,setPortName,SND_SEQ_PORT_CAP_READ | 
> SND_SEQ_PORT_CAP_SUBS_READ,SND_SEQ_PORT_TYPE_MIDI_GENERIC);
...
> 	int        midiPort   = initMidiPort(midiHandle,"Input");

-- 
Martin


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
