From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MIDI timing question
Date: Thu, 28 Aug 2003 17:56:04 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0308281647430.14119-100000@studcom.urz.uni-halle.de>
References: <NDBBLGIKBJENLAMOLFHGKEAEDBAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <NDBBLGIKBJENLAMOLFHGKEAEDBAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:
>    Does anyone have a simple page I could read with an explanation about how
> one would go about transmitting a given number of MIDI events at a known
> tempo using the Alsa MIDI services?

You'd use the sequencer. There isn't an easy HOWTO that I'd know of.

To send some events at a specific time:
- open the sequencer
- create your own (source) port
- create a queue
- set the queue's tempo
- send some events through the queue, and start it

To open the sequencer, call snd_seq_open.
(You can get your client number with snd_seq_client_id.)

	snd_seq_t seq;
	snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, 0);

To create a port, allocate a port info object with
snd_seq_port_info_alloca, set port parameters with
snd_seq_port_info_set_xxx, and call snd_seq_create_port.
Or simply call snd_seq_create_simple_port.

	int port;
	port = snd_seq_create_simple_port(seq, "my port",
		SND_SEQ_PORT_CAP_READ | SND_SEQ_POR_CAP_WRITE,
		SND_SEQ_PORT_TYPE_APPLICATION);

To create a queue, allocate a queue info object with
snd_seq_queue_info_alloca, set queue parameters with
snd_seq_queue_info_set_xxx, and call snd_seq_create_queue.
Or simply call snd_seq_alloc_queue.

	int queue;
	queue = snd_seq_alloc_queue(seq);

To set the queue's tempo, allocate a queue tempo object with
snd_seq_queue_tempo_alloca, set tempo parameters with
snd_seq_queue_tempo_set_xxx, and call snd_seq_set_queue_tempo.

	snd_seq_queue_tempo_t *tempo;
	snd_seq_queue_tempo_alloca(&tempo);
	snd_seq_queue_tempo_set_ppq(tempo, 4); /* ??? */
	snd_seq_queue_tempo_set_tempo(tempo, 92);
	snd_seq_set_queue_tempo(seq, queue, tempo);

To send an event though the queue, allocate an event structure (just
for a change, you can use a local snd_seq_event_t variable), call
snd_seq_ev_clear, call snd_seq_ev_set_dest, call
snd_seq_ev_schedule_tick, and specify the actual event you want to
send (probably with snd_seq_ev_set_note). Then call
snd_seq_event_output, and snd_seq_drain_output after you've sent all
events.

	snd_seq_event_t ev;
	snd_seq_ev_clear(&ev);
	snd_seq_ev_set_dest(&ev, 64, 0); /* 64:0 */
	snd_seq_ev_schedule_tick(&ev, queue, 0, 4); /* starts at 4 ticks */
	snd_seq_ev_set_note(&ev, 0, 60, 127, 8); /* length 8 ticks */
	snd_seq_event_output(seq, &ev);

	snd_seq_ev_schedule_tick(&ev, queue, 0, 12);
	snd_seq_ev_set_note(&ev, 0, 67, 127, 8);
	snd_seq_event_output(seq, &ev);

	snd_seq_drain_output(seq);

To start a queue, call snd_seq_start_queue and snd_seq_drain_output.

	snd_seq_start_queue(seq, queue, NULL);
	snd_seq_drain_output(seq);

	/* wait until the notes are played before exiting */


This is off the top of my head, so I'll have to check if this works
myself ... ;-)


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
