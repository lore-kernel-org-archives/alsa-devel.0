From: Tim Goetze <tim@quitte.de>
Subject: Re: Question
Date: Wed, 3 Mar 2004 23:18:17 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403032301350.567@autumn>
References: <20040303214409.ZMLB23746.tomts5-srv.bellnexxia.net@sympatico.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040303214409.ZMLB23746.tomts5-srv.bellnexxia.net@sympatico.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jacqueslen@sympatico.ca
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

[jacqueslen@sympatico.ca]

>Hullo, I can't seem to find how to create MIDI channel mode messages
>(like "reset all controllers" or "all notes off"), nor can I find out
>how to create many MIDI meta events (like "text event" or "copyright
>notice" or "sequence name"), I've been able to find out how to create
>some events at
>http://www.alsa-project.org/alsa-doc/alsa-lib/group___seq_middle.html
>, but not very many. Anyone have any ideas?

ad 1: standard MIDI controller specs can be found all over the 'net,
but the best thing is to consult the target device documentation.
if the device receiving the controller event interprets it as an
'omni' event, it will simply ignore the event channel, and so would
you.

to prepare controller event data, i use:

    snd_seq_event_t packet;

    packet.type = SND_SEQ_EVENT_CONTROLLER;
    packet.data.control.channel = channel;
    packet.data.control.param = controller;
    packet.data.control.value = value;

ad 2: afaik, you can't send meta events via the ALSA sequencer. they
only make sense within a MIDI file.

cheers,

tim


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
