From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MIDI timing question
Date: Sat, 30 Aug 2003 14:59:36 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0308301446410.28122-200000@studcom.urz.uni-halle.de>
References: <Pine.HPX.4.33n.0308281647430.14119-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_GYpyjDot/Y34SvM1IE6SWQ)"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.HPX.4.33n.0308281647430.14119-100000@studcom.urz.uni-halle.de>
Content-id: <Pine.HPX.4.33n.0308301448510.28122@studcom.urz.uni-halle.de>
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_GYpyjDot/Y34SvM1IE6SWQ)
Content-id: <Pine.HPX.4.33n.0308301448511.28122@studcom.urz.uni-halle.de>
Content-type: TEXT/PLAIN; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT

I wrote:
> This is off the top of my head, so I'll have to check if this works
> myself ... ;-)

Well, _of course_ I made errors.

> 	snd_seq_queue_tempo_set_tempo(tempo, 92);

The tempo value isn't bpm but the MIDI tempo value, i.e., the number
of microseconds per quarter note. The correct value would be 652174
(60000000 / 92).

> To send an event ...

There is a problem with ALSA's rawmidi ports: ALSA doesn't know if an
event to be sent is the last one, so it opens and closes the MIDI port
for every event sent to it. This isn't good because it resets the port
when closing.

The solution is to make a connection (subscription) to the port, so
that it's opened during the entire execution time of the program:

	snd_seq_connect_to(seq, port, 96, 0);

This will cause all events sent "to the subscribers of our port" to be
routed to port 96:0.

> 	snd_seq_ev_set_dest(&ev, 64, 0); /* 64:0 */

I forgot to set the source port (but our port has number 0 anyway, so
it didn't matter this time).

And now we sent "to all subscribers" instead of "directly to port
96:0":

	snd_seq_ev_set_subs(&ev);
	snd_seq_ev_set_source(&ev, port);

> 	snd_seq_ev_schedule_tick(&ev, queue, 0, 12);
> 	snd_seq_ev_set_note(&ev, 0, 67, 127, 8);

Instead of using the snd_seq_ev_xxx macros, one can use the fields of
the event structure directly:

	ev.time.tick = 12;
	ev.data.note.note = 67;


I have attached a little program which actually works (on my computer,
your destination port probably isn't 96:0).


HTH
Clemens

--Boundary_(ID_GYpyjDot/Y34SvM1IE6SWQ)
Content-id: <Pine.HPX.4.33n.0308301448440.28122@studcom.urz.uni-halle.de>
Content-type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=seqsend.c
Content-transfer-encoding: 7BIT
Content-disposition: ATTACHMENT; FILENAME=seqsend.c
Content-description: 

#include <alsa/asoundlib.h>
#include <unistd.h>

int main()
{
	snd_seq_t* seq;
	int port, queue;
	snd_seq_queue_tempo_t* tempo;
	snd_seq_event_t ev;

	snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, 0);

	port = snd_seq_create_simple_port(seq, "my port",
					  SND_SEQ_PORT_CAP_READ | SND_SEQ_PORT_CAP_WRITE,
					  SND_SEQ_PORT_TYPE_APPLICATION);

	queue = snd_seq_alloc_queue(seq);

	snd_seq_queue_tempo_alloca(&tempo);
	snd_seq_queue_tempo_set_tempo(tempo, 60000000 / 96);
	snd_seq_queue_tempo_set_ppq(tempo, 4);
	snd_seq_set_queue_tempo(seq, queue, tempo);

	snd_seq_connect_to(seq, port, 96, 0);

	snd_seq_start_queue(seq, queue, NULL);
	/*snd_seq_drain_output(seq);*/

	snd_seq_ev_clear(&ev);
	snd_seq_ev_set_subs(&ev);
	snd_seq_ev_set_source(&ev, port);

	snd_seq_ev_schedule_tick(&ev, queue, 0, 4);
	snd_seq_ev_set_note(&ev, 0, 60, 127, 8);
	snd_seq_event_output(seq, &ev);

	ev.time.tick = 12;
	ev.data.note.note = 67;
	snd_seq_event_output(seq, &ev);

	snd_seq_drain_output(seq);

	sleep(4);
	return 0;
}

--Boundary_(ID_GYpyjDot/Y34SvM1IE6SWQ)--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
