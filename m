From: Henning Thielemann <schlepptop@henning-thielemann.de>
Subject: Re: sending a sequencer event to a delayed queue
Date: Sun, 11 Mar 2012 16:41:31 +0100
Message-ID: <4F5CC7AB.3030300@henning-thielemann.de>
References: <alpine.DEB.2.00.1203101859280.16157@anubis.informatik.uni-halle.de>
	<4F5BBECF.8020506@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_+rhGPBTKoD9Ay8gEZaPciA)"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
	[141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id 8D03C243A7
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 16:42:47 +0100 (CET)
In-reply-to: <4F5BBECF.8020506@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Boundary_(ID_+rhGPBTKoD9Ay8gEZaPciA)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

Clemens Ladisch schrieb:
> Henning Thielemann wrote:
>> Unfortunately the ALSA doc does not say, what happens if I send an event
>> to a queue that is not running.
> 
> Exactly the same as with a running queue: the event stays in the client's
> output buffer if its scheduled time has not yet been reached.
> 
>> I expected that the event is being delivered once the queue is started.
>> But it seems that instead the event is dropped.
> 
> Perhaps it was delivered too early?

I have attached a C program that demonstrates the effect: I start the
"player" queue with one second delay and immediately send a message with
a timestamp 0 that is meant to be the local time of the "player" queue.
I expected that this event is delivered when the player queue starts,
that is, one second after program start. But actually it is played
immediately. If I choose a time larger than 0, say 1ns or 1s, then the
event is not delivered at all.

I use output_direct, but the effect is the same if I use output and drain.

--Boundary_(ID_+rhGPBTKoD9Ay8gEZaPciA)
Content-type: text/x-c++src; name=send-note-delayed.c
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=send-note-delayed.c

#include <alsa/asoundlib.h>
#include <time.h>

void connect (snd_seq_t *seq, int port, const char* dest_name) {
  snd_seq_addr_t addr;
  snd_seq_parse_address(seq, &addr, dest_name);
  snd_seq_connect_to(seq, port, addr.client, addr.port);
  printf("connect to %s: %d:%d\n", dest_name, addr.client, addr.port);
}

int main () {
  snd_seq_t *seq;
  snd_seq_event_t ev;
  snd_seq_ev_clear(&ev);

  snd_seq_open(&seq, "default", SND_SEQ_OPEN_OUTPUT, 0);
  int port = snd_seq_create_simple_port(seq, "out",
                 SND_SEQ_PORT_CAP_WRITE|SND_SEQ_PORT_CAP_SUBS_WRITE,
                 SND_SEQ_PORT_TYPE_MIDI_GENERIC);

  connect (seq, port, "aseqdump");
  connect (seq, port, "TiMidity");

  int control = snd_seq_alloc_queue(seq);
  int player = snd_seq_alloc_queue(seq);

  /* start controller queue */
  snd_seq_control_queue(seq, control, SND_SEQ_EVENT_START, 0, NULL);
  snd_seq_drain_output(seq);

  /* start player queue after one second using controller queue for timing */
  const int absolute = 0;
  snd_seq_real_time_t rtime;
  rtime.tv_sec = 1;
  rtime.tv_nsec = 0;
  snd_seq_ev_schedule_real(&ev, control, absolute, &rtime);
  snd_seq_control_queue(seq, player, SND_SEQ_EVENT_START, 0, &ev);
  snd_seq_drain_output(seq);

  snd_seq_ev_set_source(&ev, port);
  snd_seq_ev_set_subs(&ev);

  /* send note-on to player queue with local time 0 */
  /* this is played too early,
     if you increase the time, then the note is not played at all. */
  rtime.tv_sec = 0;
  rtime.tv_nsec = 0;
  snd_seq_ev_schedule_real(&ev, player, absolute, &rtime);
  snd_seq_ev_set_noteon(&ev, 0, 60, 64);
  snd_seq_event_output_direct(seq, &ev);

  /* send note-off to player queue with local time 1 */
  /* this event is dropped */
  rtime.tv_sec = 1;
  rtime.tv_nsec = 0;
  snd_seq_ev_schedule_real(&ev, player, absolute, &rtime);
  snd_seq_ev_set_noteoff(&ev, 0, 60, 64);
  snd_seq_event_output_direct(seq, &ev);

  snd_seq_sync_output_queue(seq);

  /* make sure that we do not destroy pending messages */
  sleep(3);

  snd_seq_free_queue(seq, control);
  snd_seq_free_queue(seq, player);
  snd_seq_delete_simple_port(seq, port);
  snd_seq_close(seq);

  return 0;
}

--Boundary_(ID_+rhGPBTKoD9Ay8gEZaPciA)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary_(ID_+rhGPBTKoD9Ay8gEZaPciA)--
