From: "M. Gagnon" <fire_void@hotmail.com>
Subject: Re: Development Question
Date: Sun, 18 Mar 2007 14:08:10 -0400
Message-ID: <BAY120-F25C7398C33AE2729557D689C770@phx.gbl>
References: <45FD148C.4020305@joow.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45FD148C.4020305@joow.be>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Okay, i tried with the docs. This is what i came up with, however i can't 
seem to be able to play anything more than the first event, like time was 
not moving, Perhaps i've missed something simple to make the time start?

I have pretty much followed everything that's there 
http://www.alsa-project.org/alsa-doc/alsa-lib/seq.html
but no luck

What i am missing here? I guess it's something simple but i can't find

Thanks a lot for the support!

/*
all:
	g++ midi_receiver.cpp -o AlsaNoteTest -lasound
*/

#include <stdio.h>
#include <alsa/asoundlib.h>
#include <vector>
#include <iostream>
#include <unistd.h>

// --------- declaration -------------
namespace AlsaNotePlayer
{
void  findDevices ();
void  openDevice (int client, int port);
void  closeDevice ();
void noteOn_seq(int channel, int note, int velocity, int tick);
void noteOff_seq(int channel, int note, int velocity, int tick);
void play();
void setTempo(int tempo);
}

// -------- definition ----------------

int main()
{
AlsaNotePlayer::findDevices();
AlsaNotePlayer::openDevice(128, 0); // replace by your ports as needed

AlsaNotePlayer::setTempo(60);

int time=0;
int duration = 200;

AlsaNotePlayer::noteOn_seq(1, 60, 127, time);
time += duration;
AlsaNotePlayer::noteOff_seq(1, 60, 0, time);

AlsaNotePlayer::noteOn_seq(1, 62, 127, time);
time += duration;
AlsaNotePlayer::noteOff_seq(1, 62, 0, time);

AlsaNotePlayer::noteOn_seq(1, 60, 127, time);
time += duration;
AlsaNotePlayer::noteOff_seq(1, 60, 0, time);

AlsaNotePlayer::noteOn_seq(1, 59, 127, time);
time += duration;
AlsaNotePlayer::noteOff_seq(1, 59, 0, time);

AlsaNotePlayer::play();
usleep(999999999);

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
  client = client_arg;
  port = port_arg;
  name = (char*)name_arg;
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

void noteOn_seq(int channel, int note, int velocity, int tick)
{
	snd_seq_event_t event;

	snd_seq_ev_clear(&event);

	event.queue  = MidiContext.queue;
	event.source = MidiContext.address;

	snd_seq_ev_set_subs(&event);
	snd_seq_ev_set_source(&event, MidiContext.port);
	//snd_seq_ev_set_direct(&event);
	snd_seq_ev_set_noteon(&event, channel, note, velocity);
	snd_seq_ev_schedule_tick(&event, MidiContext.queue, 0, tick );

	snd_seq_event_output(MidiContext.sequencer, &event);

       std::cout << "pending events size: " << 
snd_seq_event_output_pending(MidiContext.sequencer) << std::endl;
}

void noteOff_seq(int channel, int note, int velocity, int tick)
{
	snd_seq_event_t event;
	snd_seq_ev_clear(&event);

	event.queue  = MidiContext.queue;
	event.source = MidiContext.address;

	snd_seq_ev_set_subs(&event);
	//snd_seq_ev_set_direct(&event);
	snd_seq_ev_set_noteoff(&event, channel, note, velocity);
        snd_seq_ev_schedule_tick(&event, channel, 0 /*absolute*/, tick );

	snd_seq_event_output(MidiContext.sequencer, &event);

       std::cout << "pending events size: " << 
snd_seq_event_output_pending(MidiContext.sequencer) << std::endl;
}


void play()
{
        snd_seq_start_queue(MidiContext.sequencer, MidiContext.queue, 0);

        int output = snd_seq_drain_output(MidiContext.sequencer);

	if(output == 0) std::cout << "all events drained" << std::endl;
	else if(output > 0) std::cout << output << "bytes remaining" << std::endl;
	else if(output < 0)
	{
		 fprintf (stderr, "Error: (%s)\n", snd_strerror (output));
	}
}

void findDevices()
{
	snd_seq_client_info_t* clientInfo;

	if (snd_seq_open(&MidiContext.sequencer, "default", SND_SEQ_OPEN_OUTPUT, 0) 
< 0)
	{
		return;
	}

	snd_seq_client_info_alloca(&clientInfo);
	snd_seq_client_info_set_client(clientInfo, -1);

	// iterate through clients
	while (snd_seq_query_next_client(MidiContext.sequencer, clientInfo) >= 0)
	{
		snd_seq_port_info_t* pinfo;

		snd_seq_port_info_alloca(&pinfo);
		snd_seq_port_info_set_client(pinfo, 
snd_seq_client_info_get_client(clientInfo));
		snd_seq_port_info_set_port(pinfo, -1);

		// and now through ports
		while (snd_seq_query_next_port(MidiContext.sequencer, pinfo) >= 0)
		{
			unsigned int capability = snd_seq_port_info_get_capability(pinfo);

			if ((capability & SND_SEQ_PORT_CAP_SUBS_WRITE) == 0)
			{
				continue;
			}

			int client  = (snd_seq_port_info_get_addr(pinfo))->client;
			int port    = (snd_seq_port_info_get_addr(pinfo))->port;

			std::cout << client << ":" << port << " --> " << 
snd_seq_port_info_get_name(pinfo) << std::endl;
			devices.push_back( MidiDevice(client, port, 
snd_seq_port_info_get_name(pinfo)) );

		}

	}

	if (snd_seq_set_client_name(MidiContext.sequencer, "Aria") < 0)
	{
		return;
	}

	MidiContext.address.port = 
snd_seq_create_simple_port(MidiContext.sequencer, "Aria Port 0", 
SND_SEQ_PORT_CAP_SUBS_WRITE, SND_SEQ_PORT_TYPE_APPLICATION);
	MidiContext.address.client = snd_seq_client_id (MidiContext.sequencer);
	MidiContext.queue = snd_seq_alloc_queue (MidiContext.sequencer);

	snd_seq_set_client_pool_output (MidiContext.sequencer, 1024);
}

void setTempo(int tempo_arg)
{
// argument is not yet considered
        snd_seq_queue_tempo_t *tempo;
        snd_seq_queue_tempo_alloca(&tempo);
        snd_seq_queue_tempo_set_tempo(tempo, 1000000); // 60 BPM
        snd_seq_queue_tempo_set_ppq(tempo, 48); // 48 PPQ
        snd_seq_set_queue_tempo(MidiContext.sequencer, MidiContext.queue, 
tempo);
}

void openDevice(int client, int port)
{
	address.client = client;
	address.port = port;

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


}



>From: Pieter Palmers <pieterp@joow.be>
>To: "M. Gagnon" <fire_void@hotmail.com>
>CC: alsa-devel@lists.sourceforge.net
>Subject: Re: [Alsa-devel] Development Question
>Date: Sun, 18 Mar 2007 11:29:32 +0100
>
>M. Gagnon wrote:
>>This is interesting, Pieter, however my app already has the knowledge of 
>>notes and events, the only reason i had midi bytes was because i converted 
>>the events into bytes because then i could make them play using a single 
>>function on mac.
>>
>>Apparently on Linux/Alsa it's not this way, so i should probably learn how 
>>to put a serie of events in a sequence and then play it. The most recent 
>>sample of this i found was dated '2002' and didn't work, and my own 
>>attempts with the documentation didn't either.
>>
>>I am already able to send events directly. Where can i find recent 
>>infomation on how to schedule them in a queue and play them after?
>I found the doxygen docs that come with alsa-devel sufficient.
>
>What you have to do is convert your own 'events' into ALSA seq events, and 
>then use the snd_seq_event_output function. Things as timestamps etc... are 
>properties of ALSA seq events, and can be set using snd_seq_event_* 
>functions.
>
>
>Pieter
>
>PS: One tricky thing if you use multiple ports is that the port an event 
>should be sent to is also a property of the event.
>

_________________________________________________________________
Windows Live Spaces: partagez vos photos avec vos amis! 
http://spaces.live.com/?mkt=fr-ca


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
