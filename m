From: "M. Gagnon" <fire_void@hotmail.com>
Subject: Re: Development Question
Date: Tue, 20 Mar 2007 21:02:10 -0400
Message-ID: <BAY120-F386297B6AF9B18238982EC9C740@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc1-s10.bay0.hotmail.com (bay0-omc1-s10.bay0.hotmail.com
	[65.54.246.82]) by alsa0.perex.cz (Postfix) with ESMTP id CE4AC2433B
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2007 02:02:16 +0100 (CET)
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


> > >What is the output of the program?
> >
> > pending events size: 28
> > pending events size: 56
> > pending events size: 84
> > ...
> > BEFORE DRAIN: pending events size: 476
> > AFTER DRAIN: pending events size: 0
>
>Looks OK.  In theory, all events should be sent somewhere.
>
>Please run aseqdump and send the events to its port.  What does it
>output?
>

% aseqdump
Waiting for data at port 128:0. Press Ctrl+C to end.
Source_ Event_________________ Ch _Data__
  0:1   Port subscribed           129:0 -> 128:0
129:0   Note on                 2  60 127
  0:1   Port unsubscribed         129:0 -> 128:0

Seems like only one event gets sent - just like what i hear.

>Run "cat /proc/asound/seq/queues" and
>"cat /proc/asound/seq/timer".
>

% cat /proc/asound/seq/queues
queue 0: [Queue-0]
owned by client    : 128
lock status        : Locked
queued time events : 0
queued tick events : 0
timer state        : Running
timer PPQ          : 96
current tempo      : 500000
current BPM        : 120
current time       : 1.536000000 s
current tick       : 294

queue 1: [Queue-1]
owned by client    : 129
lock status        : Locked
queued time events : 0
queued tick events : 0
timer state        : Running
timer PPQ          : 48
current tempo      : 1000000
current BPM        : 60
current time       : 1.488000000 s
current tick       : 71

% cat /proc/asound/seq/timer
Timer for queue 0 : system timer
  Period time : 0.004000000
  Skew : 65536 / 65536
Timer for queue 1 : system timer
  Period time : 0.004000000
  Skew : 65536 / 65536

thanks for your help

just as reminder (so the output can be interpreted) this is my latest code
/*
all:
	g++ midi_receiver.cpp -o AlsaNoteTest -lasound
*/

#include <stdio.h>
#include <alsa/asoundlib.h>
#include "midi_receiver.h"
#include <vector>
#include <iostream>
#include <unistd.h>
#include <pthread.h>

pthread_t thread1;
char *message1 =3D "Thread 1";
int  iret1;

void *play_func( void *ptr )
{
     AlsaNotePlayer::play();
}

int main()
{
AlsaNotePlayer::findDevices();
AlsaNotePlayer::openDevice(128, 0);

AlsaNotePlayer::setTempo(60, 48);

int time=3D0;
int duration =3D 50;

AlsaNotePlayer::noteOn_seq(1, 60, 127, time);
time +=3D duration;
AlsaNotePlayer::noteOff_seq(1, 60, 0, time);

AlsaNotePlayer::noteOn_seq(1, 62, 127, time);
time +=3D duration;
AlsaNotePlayer::noteOff_seq(1, 62, 0, time);

AlsaNotePlayer::noteOn_seq(1, 60, 127, time);
time +=3D duration;
AlsaNotePlayer::noteOff_seq(1, 60, 0, time);

AlsaNotePlayer::noteOn_seq(1, 59, 127, time);
time +=3D duration;
AlsaNotePlayer::noteOff_seq(1, 59, 0, time);

// ----------
AlsaNotePlayer::noteOn_seq(1, 63, 127, time);
time +=3D duration;
AlsaNotePlayer::noteOff_seq(1, 63, 0, time);

AlsaNotePlayer::noteOn_seq(1, 65, 127, time);
time +=3D duration;
AlsaNotePlayer::noteOff_seq(1, 65, 0, time);

AlsaNotePlayer::noteOn_seq(1, 63, 127, time);
time +=3D duration;
AlsaNotePlayer::noteOff_seq(1, 63, 0, time);

AlsaNotePlayer::noteOn_seq(1, 61, 127, time);
time +=3D duration;
AlsaNotePlayer::noteOff_seq(1, 61, 0, time);


iret1 =3D pthread_create( &thread1, NULL, play_func, (void*) message1);
pthread_join( thread1, NULL);

while(1)
{
usleep(10000);
}

}

namespace AlsaNotePlayer
{

class MidiDevice
{

public:

int client, port;
char* name;

MidiDevice(int client_arg, int port_arg, const char* name_arg)
{
  client =3D client_arg;
  port =3D port_arg;
  name =3D (char*)name_arg;
}

};

std::vector<MidiDevice> devices;

struct MidiContext
{
		snd_seq_t* sequencer;
		int queue;
		snd_seq_addr_t address;
		int port;
		snd_seq_port_subscribe_t *subs;
};

struct MidiContext MidiContext;
snd_seq_addr_t address;

void findDevices()
{
	snd_seq_client_info_t* clientInfo;

	if (snd_seq_open(&MidiContext.sequencer, "default", SND_SEQ_OPEN_OUTPUT, 0=
) =

< 0)
	{
		return;
	}

	snd_seq_client_info_alloca(&clientInfo);
	snd_seq_client_info_set_client(clientInfo, -1);

	// iterate through clients
	while (snd_seq_query_next_client(MidiContext.sequencer, clientInfo) >=3D 0)
	{
		snd_seq_port_info_t* pinfo;

		snd_seq_port_info_alloca(&pinfo);
		snd_seq_port_info_set_client(pinfo, =

snd_seq_client_info_get_client(clientInfo));
		snd_seq_port_info_set_port(pinfo, -1);

		// and now through ports
		while (snd_seq_query_next_port(MidiContext.sequencer, pinfo) >=3D 0)
		{
			unsigned int capability =3D snd_seq_port_info_get_capability(pinfo);

			if ((capability & SND_SEQ_PORT_CAP_SUBS_WRITE) =3D=3D 0)
			{
				continue;
			}

			int client  =3D (snd_seq_port_info_get_addr(pinfo))->client;
			int port    =3D (snd_seq_port_info_get_addr(pinfo))->port;

			std::cout << client << ":" << port << " --> " << =

snd_seq_port_info_get_name(pinfo) << std::endl;
			devices.push_back( MidiDevice(client, port, =

snd_seq_port_info_get_name(pinfo)) );

		}

	}

	if (snd_seq_set_client_name(MidiContext.sequencer, "Aria") < 0)
	{
		return;
	}

	//MidiContext.address.port =3D =

snd_seq_create_simple_port(MidiContext.sequencer, "Aria Port 0", =

SND_SEQ_PORT_CAP_SUBS_WRITE, SND_SEQ_PORT_TYPE_APPLICATION);
MidiContext.address.port =3D  =

snd_seq_create_simple_port(MidiContext.sequencer, "Aria Port 0",
					 SND_SEQ_PORT_CAP_WRITE |
					 SND_SEQ_PORT_CAP_SUBS_WRITE |
					 SND_SEQ_PORT_CAP_READ,
					 SND_SEQ_PORT_TYPE_APPLICATION);
					 //SND_SEQ_PORT_TYPE_MIDI_GENERIC);

	MidiContext.address.client =3D snd_seq_client_id (MidiContext.sequencer);
	MidiContext.queue =3D snd_seq_alloc_queue (MidiContext.sequencer);

	snd_seq_set_client_pool_output (MidiContext.sequencer, 1024);
}

void setTempo(int tempo_arg, int resolution)
{
// argument is not yet considered
        snd_seq_queue_tempo_t *tempo;
        snd_seq_queue_tempo_alloca(&tempo);
       // snd_seq_queue_tempo_set_tempo(tempo, 1000000); // 60 BPM
       // snd_seq_queue_tempo_set_ppq(tempo, 48); // 48 PPQ
	snd_seq_queue_tempo_set_ppq(tempo, resolution);
	snd_seq_queue_tempo_set_tempo(tempo, 60*1000000/tempo_arg);
        snd_seq_set_queue_tempo(MidiContext.sequencer, MidiContext.queue, =

tempo);
}

void openDevice(int client, int port)
{
	address.client =3D client;
	address.port =3D port;

	snd_seq_port_subscribe_alloca(&MidiContext.subs);

	snd_seq_port_subscribe_set_sender(MidiContext.subs, &MidiContext.address);
	snd_seq_port_subscribe_set_dest(MidiContext.subs, &address);

	snd_seq_subscribe_port(MidiContext.sequencer, MidiContext.subs);
}

void closeDevice()
{
	snd_seq_port_subscribe_alloca(&MidiContext.subs);
	snd_seq_port_subscribe_set_sender(MidiContext.subs, &MidiContext.address);
	snd_seq_port_subscribe_set_dest(MidiContext.subs, &address);

	if (snd_seq_unsubscribe_port(MidiContext.sequencer, MidiContext.subs) < 0)
	{
		return;
	}
	//snd_seq_port_subscribe_free(MidiContext.subs);
}




//*************************************************************************=
***********//
//************************************MIDI =

EVENTS*************************************//
//*************************************************************************=
***********//

void noteOn_seq(int channel, int note, int velocity, int tick)
{
	snd_seq_event_t event;

	snd_seq_ev_clear(&event);

	event.queue  =3D MidiContext.queue;
	event.source =3D MidiContext.address;

	snd_seq_ev_set_subs(&event);
	snd_seq_ev_set_source(&event, MidiContext.port);
	snd_seq_ev_set_noteon(&event, channel, note, velocity);
	snd_seq_ev_schedule_tick(&event, MidiContext.queue, 0, tick );

	snd_seq_event_output(MidiContext.sequencer, &event);

       std::cout << "pending events size: " << =

snd_seq_event_output_pending(MidiContext.sequencer) << std::endl;
}

void noteOff_seq(int channel, int note, int velocity, int tick)
{
	snd_seq_event_t event;
	snd_seq_ev_clear(&event);

	event.queue  =3D MidiContext.queue;
	event.source =3D MidiContext.address;

	snd_seq_ev_set_subs(&event);
	snd_seq_ev_set_noteoff(&event, channel, note, velocity);
        snd_seq_ev_schedule_tick(&event, MidiContext.queue, 0 /*absolute*/, =

tick );

	snd_seq_event_output(MidiContext.sequencer, &event);

       std::cout << "pending events size: " << =

snd_seq_event_output_pending(MidiContext.sequencer) << std::endl;
}


void play()
{
        snd_seq_start_queue(MidiContext.sequencer, MidiContext.queue, 0);

       std::cout << "BEFORE DRAIN: pending events size: " << =

snd_seq_event_output_pending(MidiContext.sequencer) << std::endl;
        int output =3D snd_seq_drain_output(MidiContext.sequencer);
       std::cout << "AFTER DRAIN: pending events size: " << =

snd_seq_event_output_pending(MidiContext.sequencer) << std::endl;

	if(output =3D=3D 0) std::cout << "all events drained" << std::endl;
	if(output > 0) std::cout << output << "bytes remaining" << std::endl;
	if(output < 0)
	{
		 fprintf (stderr, "Error: (%s)\n", snd_strerror (output));
		 //std::cout << "error" << std::endl;
	}
}


}

_________________________________________________________________
Ne perdez pas de temps dans les files d=92attente=85 magasinez en ligne.  =

http://magasiner.sympatico.msn.ca
