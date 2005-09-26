From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Midi Out help
Date: Mon, 26 Sep 2005 11:11:59 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509260959360.13755-100000@studcom.urz.uni-halle.de>
References: <BAY13-F10379A920748A144124373EE890@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0FEA5171
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 11:12:01 +0200 (MEST)
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
To: Radu Olaru <iq9@hotmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Radu Olaru wrote:
> I'm trying to send Midi messages to another Alsa program, a synth actually.
> Well, I cannot hear any sound from the synth if I'm sending messages using
> the program below.
>
> snd_seq_open(&rezultat,"default",SND_SEQ_OPEN_INPUT,0)

You cannot send (write) events if you've opened the sequencer for
input only.  Use _DUPLEX here.

> snd_seq_create_simple_port(...SND_SEQ_PORT_CAP_READ | SND_SEQ_PORT_CAP_SUBS_READ...)

These flags are OK.  As the owner, your program is allowed to write to
this port even if the write flags aren't set.

> 	snd_seq_ev_set_subs(&midiEvent);

I hope you did connect your program to the synth.

> 	snd_seq_free_event(&midiEvent);

Don't call this for static variables.  This function was intended for
events that had been dynamically allocated by snd_seq_read(), but it
isn't needed even in that case.


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
