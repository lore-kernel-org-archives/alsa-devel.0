From: "Gilbux (free)" <gilbux@free.fr>
Subject: Dev: Alsa sequencer problem (Why ???)
Date: Mon, 01 Sep 2008 11:02:49 +0200
Message-ID: <48BBAFB9.9080101@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010401030701010105020409"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g19.free.fr (smtp4-g19.free.fr [212.27.42.30])
	by alsa0.perex.cz (Postfix) with ESMTP id BA4AC244DF
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 11:02:53 +0200 (CEST)
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id ED0853EA0C3
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 11:02:52 +0200 (CEST)
Received: from [82.243.47.202] (alf94-10-82-243-47-202.fbx.proxad.net
	[82.243.47.202])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 42E6F3EA10E
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 11:02:52 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010401030701010105020409
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I am trying to write an alsa sequencer. So I read as I can some of your 
tutorials, and I don't really understand what I am doing wrong, please 
help me.

I want to send scheduled event with the queuing system, but with RTC 
timer the queue doesn't start, and with the other timer the queue start 
but no events are sent.

I have joined to this email a small code, with the same kind of 
functions I am using, and some /proc/asound/seq/* outputs.

Regards,
Gilbux

--------------010401030701010105020409
Content-Type: text/x-csrc;
 name="TestQSchedEv.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="TestQSchedEv.c"

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

#include <alsa/asoundlib.h>

#define __TQSE_SEQNAME		"TestQSchedEv"
#define __TQSE_PORTNAME		"OutputPort"
#define __TQSE_QUEUENAME	"TQSE_Queue"

#define __TQSE_BPM		120
#define __TQSE_PPQ		192

#define __TQSE_ERR_CODE		-3

snd_seq_t		*seqh;
int			seqid, portid, queueid;

void			SetTempo(unsigned int bpm,
				 unsigned int ppq)
{
  snd_seq_queue_tempo_t	*tempo;
  unsigned int		beat_in_microsec
    = (unsigned int) (60000000 / bpm);
  int			err;

  snd_seq_queue_tempo_alloca(&tempo);
  snd_seq_queue_tempo_set_tempo(tempo, beat_in_microsec);
  snd_seq_queue_tempo_set_ppq(tempo, ppq);
  err = snd_seq_set_queue_tempo(seqh, queueid, tempo);
  if (err < 0)
    {
      fprintf(stderr,
	      "SetTempo: snd_seq_set_queue_tempo: %s\n",
	      snd_strerror(err));
      exit(__TQSE_ERR_CODE);
    }
  return;
}

void			StartQueue(void)
{
  int			err;

  snd_seq_start_queue(seqh, queueid, 0);
  err = snd_seq_drain_output(seqh);
  if (err < 0)
    {
      fprintf(stderr,
	      "StartQueue: snd_seq_drain_output: %s\n",
	      snd_strerror(err));
      exit(__TQSE_ERR_CODE);
    }
  return;
}

void			StopQueue(void)
{
  int			err;

  snd_seq_stop_queue(seqh, queueid, 0);
  err = snd_seq_drain_output(seqh);
  if (err < 0)
    {
      fprintf(stderr,
	      "StopQueue: snd_seq_drain_output: %s\n",
	      snd_strerror(err));
      exit(__TQSE_ERR_CODE);
    }
  return;
}

void			SetNoteEv(unsigned char channel,
				  unsigned char note,
				  unsigned int duration,
				  unsigned int ticktime)
{
  /* Trying to set queued note ev scheduled with ticktime. */
  snd_seq_event_t	ev;
  int			err;

  snd_seq_ev_clear(&ev);
  snd_seq_ev_schedule_tick(&ev, queueid, 0, ticktime);
  snd_seq_ev_set_source(&ev, portid);
  snd_seq_ev_set_subs(&ev);
  snd_seq_ev_set_note(&ev, channel, note, 127, duration);
  err = snd_seq_event_output_direct(seqh, &ev);
  if (err < 0)
    {
      fprintf(stderr,
	      "SetNoteEv: snd_seq_event_output_direct: %s\n",
	      snd_strerror(err));
      exit(__TQSE_ERR_CODE);
    }
  return;
}

void			InitSeqPortQueue(void)
{
  /* I try to init the alsa sequencer to just output
     event I don't touch the queue pool output, because
     it seems to have a default size in /proc/asound/seq/queue. */
  int			err;

  err = snd_seq_open(&seqh, "default", SND_SEQ_OPEN_OUTPUT, 0);
  if (err < 0)
    {
      fprintf(stderr, "snd_seq_open: %s\n", snd_strerror(err));
      exit(__TQSE_ERR_CODE);
    }
  err = snd_seq_set_client_name(seqh, __TQSE_SEQNAME);
  if (err < 0)
    {
      fprintf(stderr, "snd_seq_set_client_name: %s\n", snd_strerror(err));
      exit(__TQSE_ERR_CODE);
    }
  seqid = snd_seq_client_id(seqh);
  if (seqid < 0)
    {
      fprintf(stderr, "snd_seq_client_id: %s\n", snd_strerror(seqid));
      exit(__TQSE_ERR_CODE);
    }

  portid = snd_seq_create_simple_port(seqh, __TQSE_PORTNAME,
				      SND_SEQ_PORT_CAP_SUBS_READ	\
				      |SND_SEQ_PORT_CAP_READ, 0);
  if (portid < 0)
    {
      fprintf(stderr, "_Init_GAlsaSeqPort: snd_seq_create_simple_port: %s\n",
	      snd_strerror(portid));
      exit(__TQSE_ERR_CODE);
    }

  queueid = snd_seq_alloc_named_queue(seqh, __TQSE_QUEUENAME);
  if (queueid < 0)
    {
      fprintf(stderr, "_Init_GAlsaSeqQueue: snd_seq_alloc_named_queue: %s\n",
	      snd_strerror(queueid));
      exit(__TQSE_ERR_CODE);
    }
  return;
}

void			CloseSeqPortQueue(void)
{
  int			err;

  err = snd_seq_free_queue(seqh, queueid);
  if (err < 0)
    fprintf(stderr, "snd_seq_free_queue: %s\n", snd_strerror(err));
  err = snd_seq_delete_simple_port(seqh, portid);
  if (err < 0)
    fprintf(stderr, "close client port : %s\n", snd_strerror(err));
  err = snd_seq_close(seqh);
  if (err < 0)
    fprintf(stderr, "close seq client : %s\n", snd_strerror(err));
  return;
}

int			main(void)
{
  unsigned int		i;


  InitSeqPortQueue();
  SetTempo((unsigned int) __TQSE_BPM,
	   (unsigned int) __TQSE_PPQ);

  /* Preparing the queue to send an event every 4 beats */
  for (i = 0; i < 16; i++)
    SetNoteEv(1,
	      60,
	      (4 * __TQSE_PPQ),
	      (i * 16 * __TQSE_PPQ));

  printf("Press Enter to start the queue when all subscribtion are done.\n");
  /* trying to set enough time for event transimission */
  i = (17 * 60 / __TQSE_BPM) + 1;
  fgetc(stdin);
  printf("Starting the queue\n");
  StartQueue();
  sleep(i);
  printf("\nStopping the queue\n");
  StopQueue();

  CloseSeqPortQueue();
  return 0;
}

/* I compiled it with :
   gcc -Wall -g -o TestQSchedEv TestQSchedEv.c -lasound */

--------------010401030701010105020409
Content-Type: text/plain;
 name="outputs.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="outputs.txt"

/proc/asound/seq/* before starting the queue :
Client info
  cur  clients : 2
  peak clients : 3
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
Client 128 : "TestQSchedEv" [User]
  Port   0 : "OutputPort" (R-e-)
  Output pool :
    Pool size          : 500
    Cells in use       : 16
    Peak cells in use  : 16
    Alloc success      : 16
    Alloc failures     : 0
queue 0: [TQSE_Queue]
owned by client    : 128
lock status        : Locked
queued time events : 0
queued tick events : 16
timer state        : Stopped
timer PPQ          : 192
current tempo      : 500000
current BPM        : 120
current time       : 0.000000000 s
current tick       : 0

Timer for queue 0 : RTC timer
  Period time : 0.000000000
  Skew : 65536 / 65536

-----

/proc/asound/seq/* after starting the queue :
Client info
  cur  clients : 2
  peak clients : 3
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
Client 128 : "TestQSchedEv" [User]
  Port   0 : "OutputPort" (R-e-)
  Output pool :
    Pool size          : 500
    Cells in use       : 0
    Peak cells in use  : 16
    Alloc success      : 16
    Alloc failures     : 0
queue 0: [TQSE_Queue]
owned by client    : 128
lock status        : Locked
queued time events : 0
queued tick events : 0
timer state        : Running
timer PPQ          : 192
current tempo      : 500000
current BPM        : 120
current time       : 0.000000000 s
current tick       : 0

Timer for queue 0 : RTC timer
  Period time : 0.000976562
  Skew : 65536 / 65536

--------------010401030701010105020409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010401030701010105020409--
