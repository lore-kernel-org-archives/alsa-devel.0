From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: troubles programming with the sequencer
Date: Mon, 26 Jan 2004 14:52:59 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401261447190.24795-100000@studcom.urz.uni-halle.de>
References: <20040123190532.1f335a80.brix82@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040123190532.1f335a80.brix82@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brix <brix82@libero.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Brix wrote:
> My code doesn't return any error, i just can't hear anything. If i
> do it via the RawMIDI API, it works fine (but it's, bleahh,
> horrible to use).
>
> I thought it was because i didn't assign any path/instrument to
> the midi channels,

The default instrument is 0 (grand piano).

> so i tried to set them via RawMIDI, but it still doesn't work.

You can send program change messages with the sequencer, too.

> void set_chan_instr( int chan, int instrument ) {
>   int ch = 0xC0 + chan;
>   snd_rawmidi_write(handle_out, &ch, 1);

This does not work on big-endian machines, use char for ch.

>   // now we try to set up channel 0 via RawMIDI
>   snd_rawmidi_open( NULL, &handle_out, "hw:0,1", 0)
>   // ok, let's assign instrument #4
>   set_chan_instr( 0, 4 );

If the rawmidi device is already opened, it may not be possible for
the sequencer to open it, too.  Call snd_rawmidi_close, or leave this
code out altogether.

>   // let's play! (we hope..)
>   snd_seq_event_output(seq, &ev);
>   snd_seq_drain_output(seq);
>   snd_seq_start_queue(seq, queue, NULL);
>   snd_seq_drain_output(seq);
>
>   return 0;
> }

Directly after starting the queue, the program exists, and the queue
gets destroyed.  Try snd_seq_sync_output.


HTH
Clemens




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
