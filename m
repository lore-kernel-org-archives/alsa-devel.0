From: "Radu Olaru" <iq9@hotmail.com>
Subject: Midi Out help
Date: Sat, 24 Sep 2005 11:20:42 +0300
Message-ID: <BAY13-F10379A920748A144124373EE890@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hotmail.com (bay13-f10.bay13.hotmail.com [64.4.31.10])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 29A1E10F
	for <alsa-devel@alsa-project.org>; Sat, 24 Sep 2005 10:20:44 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm trying to send Midi messages to another Alsa program, a synth actually. 
Well, I cannot hear any sound from the synth if I'm sending messages using 
the program below. Please, PLEASE help me. It's verry important.

#include <alsa/asoundlib.h>
#include <stdio.h>

snd_seq_t* initClient(char* setClientName)
{
	snd_seq_t*	rezultat = NULL;

	if (snd_seq_open(&rezultat,"default",SND_SEQ_OPEN_INPUT,0) != 0) return 
NULL;
	snd_seq_set_client_name(rezultat,setClientName);

	return rezultat;
}
int initMidiPort(snd_seq_t* handle,char* setPortName)
{
	return snd_seq_create_simple_port(handle,setPortName,SND_SEQ_PORT_CAP_READ 
| SND_SEQ_PORT_CAP_SUBS_READ,SND_SEQ_PORT_TYPE_MIDI_GENERIC);
}

void sendMidiMessage(snd_seq_t* handle,int port)
{
	snd_seq_event_t midiEvent;

	snd_seq_ev_clear(&midiEvent);
	snd_seq_ev_set_source(&midiEvent,port);
	snd_seq_ev_set_subs(&midiEvent);
	snd_seq_ev_set_direct(&midiEvent);

	snd_seq_ev_set_noteon(&midiEvent,1,64,100);

//	midiEvent.type = SND_SEQ_EVENT_NOTEON;
//	midiEvent.data.note.channel = 1;  	// midich
//	midiEvent.data.note.note = 64; 		// nk
//	midiEvent.data.note.velocity = 100;	// (int) vel;
//	midiEvent.data.note.duration = 30;

	snd_seq_event_output(handle,&midiEvent);
	snd_seq_drain_output(handle);

	snd_seq_free_event(&midiEvent);
}

int main()
{
	snd_seq_t* midiHandle = initClient("My Client");
	int        midiPort   = initMidiPort(midiHandle,"Input");

	printf("Apasati o tasta pentru a emite un mesaj MIDI");getchar();
	for (int i = 0;i<100;i++) sendMidiMessage(midiHandle,midiPort);
	printf("Apasati o tasta pentru a iesi din program");getchar();

	if (midiHandle) snd_seq_close(midiHandle);
	return 0;
}

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
