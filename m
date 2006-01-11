From: krampenschiesser@freenet.de
Subject: Questions on writing a sequencer
Date: Wed, 11 Jan 2006 22:38:32 +0100
Message-ID: <20060111223832.69dfc5d1.krampenschiesser@freenet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__11_Jan_2006_22_38_32_+0100_h2n=6s9G4sv=Xg85"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mout1.freenet.de (mout1.freenet.de [194.97.50.132])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C919C110
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2006 22:38:43 +0100 (MET)
Received: from [194.97.55.190] (helo=mx6.freenet.de)
	by mout1.freenet.de with esmtpa (Exim 4.61)
	(envelope-from <krampenschiesser@freenet.de>)
	id 1Ewng3-0003TT-CJ
	for alsa-devel@alsa-project.org; Wed, 11 Jan 2006 22:38:43 +0100
Received: from p509064f9.dip.t-dialin.net ([80.144.100.249] helo=scar)
	by mx6.freenet.de with esmtpsa (ID krampenschiesser@freenet.de) (TLSv1:AES256-SHA:256) (Exim 4.61 #21)
	id 1Ewng2-0008FA-6B
	for alsa-devel@alsa-project.org; Wed, 11 Jan 2006 22:38:43 +0100
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

--Signature=_Wed__11_Jan_2006_22_38_32_+0100_h2n=6s9G4sv=Xg85
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__11_Jan_2006_22_38_32_+0100_JEegJfdrV1ni2dIs"


--Multipart=_Wed__11_Jan_2006_22_38_32_+0100_JEegJfdrV1ni2dIs
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,
I tried to write a simple sequencer.
As i read throught the documentation of alsa-lib and the tutorial linked I =
got to know how to open a seq handle, set the tempo, src and dest.
As I read throughtout the tutorials the queues handle their speed themeselv=
es.
But they don't do in my application.
Does someone know why?
I had to use usleep for correct timing oO.
I hope you can help me with this, because it is very important for me.
If you have any really low-feature example or another tutorial not given on=
 www.alsa-project.org please send it.
Here's the source code of my program(which is also attached):
[SOURCE BEGIN]
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <alsa/asoundlib.h>

snd_seq_t *open_seq();
void midi_action(snd_seq_t *seq_handle);

snd_seq_t *open_seq() {

  snd_seq_t *seq_handle;
  int portid;

  if (snd_seq_open(&seq_handle, "default", SND_SEQ_OPEN_OUTPUT, 0) < 0) {
    fprintf(stderr, "Error opening ALSA sequencer.\n");
    exit(1);
  }
  snd_seq_set_client_name(seq_handle, "Aseq Output");
  if ((portid =3D snd_seq_create_simple_port(seq_handle, "Aseq Output",
            SND_SEQ_PORT_CAP_READ|SND_SEQ_PORT_CAP_SUBS_READ,
            SND_SEQ_PORT_TYPE_MIDI_GENERIC)) < 0) {
    fprintf(stderr, "Error creating sequencer port.\n");
    exit(1);
  }
  return(seq_handle);
}

void midi_action(snd_seq_t *seq_handle) {

  snd_seq_event_t *ev;

  do {
    snd_seq_event_input(seq_handle, &ev);
    switch (ev->type) {
      case SND_SEQ_EVENT_CONTROLLER:=20
        fprintf(stderr, "Control event on Channel %2d: %5d       \r",
                ev->data.control.channel, ev->data.control.value);
        break;
      case SND_SEQ_EVENT_PITCHBEND:
        fprintf(stderr, "Pitchbender event on Channel %2d: %5d   \r",=20
                ev->data.control.channel, ev->data.control.value);
        break;
      case SND_SEQ_EVENT_NOTEON:
        fprintf(stderr, "Note On event on Channel %2d: %5d       \r",
                ev->data.control.channel, ev->data.note.note);
        break;       =20
      case SND_SEQ_EVENT_NOTEOFF:=20
        fprintf(stderr, "Note Off event on Channel %2d: %5d      \r",      =
  =20
                ev->data.control.channel, ev->data.note.note);          =20
        break;       =20
    }
    snd_seq_free_event(ev);
  } while (snd_seq_event_input_pending(seq_handle, 0) > 0);
}

int main(int argc, char *argv[]) {

  snd_seq_t *seq_handle;
  int npfd;
  struct pollfd *pfd;
 =20
  seq_handle =3D open_seq();
 =20
  int myqueue =3D snd_seq_alloc_named_queue(seq_handle, "my queue");
=20
  snd_seq_queue_tempo_t *tempo;
  snd_seq_queue_tempo_alloca(&tempo);
  int iTempo =3D (int)(6e7 / ((double)140*(double)96*(double)96);
  snd_seq_queue_tempo_set_tempo(tempo, iTempo); // 60 BPM
  snd_seq_queue_tempo_set_ppq(tempo, 96); // 48 PPQ
  snd_seq_set_queue_tempo(seq_handle, myqueue, tempo);
  snd_seq_queue_tempo_free(tempo);
 =20
  snd_seq_addr_t sender, dest;
  snd_seq_port_subscribe_t *subs;
  sender.client =3D 131;
  sender.port =3D 0;
  dest.client =3D 130;
  dest.port =3D 1;
  snd_seq_port_subscribe_alloca(&subs);
  snd_seq_port_subscribe_set_sender(subs, &sender);
  snd_seq_port_subscribe_set_dest(subs, &dest);
  snd_seq_subscribe_port(seq_handle, subs);

  bool on=3Dfalse;
 =20
  while(true)
  {     =20
  	snd_seq_event_t ev;

        snd_seq_ev_clear(&ev);
        snd_seq_ev_set_source(&ev, sender.port);
        snd_seq_ev_set_subs(&ev);
        snd_seq_ev_schedule_tick(&ev, myqueue, 0, 0);

	if(!on) {
		snd_seq_ev_set_noteon(&ev, 10, 38, 127);
		on=3Dtrue;
	}
	else {
		snd_seq_ev_set_noteoff(&ev, 10, 38, 127);
		on=3Dfalse;
	}

        snd_seq_event_output(seq_handle, &ev);
        snd_seq_drain_output(seq_handle);  // if necessary
	unsigned long fbpm =3D 1000000.0f * ( 60.0f / 140.0f / 2.0f );
	usleep(fbpm);
  }
}

[CODE END]

--=20
Science may someday discover what faith has always known.

--Multipart=_Wed__11_Jan_2006_22_38_32_+0100_JEegJfdrV1ni2dIs
Content-Type: text/x-c++src;
 name="seq.cpp"
Content-Disposition: attachment;
 filename="seq.cpp"
Content-Transfer-Encoding: quoted-printable

/* seqdemo.c by Matthias Nagorni */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <alsa/asoundlib.h>

snd_seq_t *open_seq();
void midi_action(snd_seq_t *seq_handle);

snd_seq_t *open_seq() {

  snd_seq_t *seq_handle;
  int portid;

  if (snd_seq_open(&seq_handle, "default", SND_SEQ_OPEN_OUTPUT, 0) < 0) {
    fprintf(stderr, "Error opening ALSA sequencer.\n");
    exit(1);
  }
  snd_seq_set_client_name(seq_handle, "Aseq Output");
  if ((portid =3D snd_seq_create_simple_port(seq_handle, "Aseq Output",
            SND_SEQ_PORT_CAP_READ|SND_SEQ_PORT_CAP_SUBS_READ,
            SND_SEQ_PORT_TYPE_MIDI_GENERIC)) < 0) {
    fprintf(stderr, "Error creating sequencer port.\n");
    exit(1);
  }
  return(seq_handle);
}

void midi_action(snd_seq_t *seq_handle) {

  snd_seq_event_t *ev;

  do {
    snd_seq_event_input(seq_handle, &ev);
    switch (ev->type) {
      case SND_SEQ_EVENT_CONTROLLER:=20
        fprintf(stderr, "Control event on Channel %2d: %5d       \r",
                ev->data.control.channel, ev->data.control.value);
        break;
      case SND_SEQ_EVENT_PITCHBEND:
        fprintf(stderr, "Pitchbender event on Channel %2d: %5d   \r",=20
                ev->data.control.channel, ev->data.control.value);
        break;
      case SND_SEQ_EVENT_NOTEON:
        fprintf(stderr, "Note On event on Channel %2d: %5d       \r",
                ev->data.control.channel, ev->data.note.note);
        break;       =20
      case SND_SEQ_EVENT_NOTEOFF:=20
        fprintf(stderr, "Note Off event on Channel %2d: %5d      \r",      =
  =20
                ev->data.control.channel, ev->data.note.note);          =20
        break;       =20
    }
    snd_seq_free_event(ev);
  } while (snd_seq_event_input_pending(seq_handle, 0) > 0);
}

int main(int argc, char *argv[]) {

  snd_seq_t *seq_handle;
  int npfd;
  struct pollfd *pfd;
 =20
  seq_handle =3D open_seq();
 =20
  int myqueue =3D snd_seq_alloc_named_queue(seq_handle, "my queue");
=20
  snd_seq_queue_tempo_t *tempo;
  snd_seq_queue_tempo_alloca(&tempo);
  int iTempo =3D (int)(6e7 / ((double)140*(double)96*(double)96);
  snd_seq_queue_tempo_set_tempo(tempo, iTempo); // 60 BPM
  snd_seq_queue_tempo_set_ppq(tempo, 96); // 48 PPQ
  snd_seq_set_queue_tempo(seq_handle, myqueue, tempo);
  snd_seq_queue_tempo_free(tempo);
 =20
  snd_seq_addr_t sender, dest;
  snd_seq_port_subscribe_t *subs;
  sender.client =3D 131;
  sender.port =3D 0;
  dest.client =3D 130;
  dest.port =3D 1;
  snd_seq_port_subscribe_alloca(&subs);
  snd_seq_port_subscribe_set_sender(subs, &sender);
  snd_seq_port_subscribe_set_dest(subs, &dest);
  snd_seq_subscribe_port(seq_handle, subs);

  bool on=3Dfalse;
 =20
  while(true)
  {     =20
  	snd_seq_event_t ev;

        snd_seq_ev_clear(&ev);
        snd_seq_ev_set_source(&ev, sender.port);
        snd_seq_ev_set_subs(&ev);
        snd_seq_ev_schedule_tick(&ev, myqueue, 0, 0);

	if(!on) {
		snd_seq_ev_set_noteon(&ev, 10, 38, 127);
		on=3Dtrue;
	}
	else {
		snd_seq_ev_set_noteoff(&ev, 10, 38, 127);
		on=3Dfalse;
	}

        snd_seq_event_output(seq_handle, &ev);
        snd_seq_drain_output(seq_handle);  // if necessary
	unsigned long fbpm =3D 1000000.0f * ( 60.0f / 140.0f / 2.0f );
	usleep(fbpm);
  }
}


--Multipart=_Wed__11_Jan_2006_22_38_32_+0100_JEegJfdrV1ni2dIs--

--Signature=_Wed__11_Jan_2006_22_38_32_+0100_h2n=6s9G4sv=Xg85
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDxXreVC26eJ+o0+0RAu2jAKCHQMgabv7OYo2/bych0tr94jEv/wCdHltS
6wYZN3jqT9gOBpeRNjh6wo8=
=VkA+
-----END PGP SIGNATURE-----

--Signature=_Wed__11_Jan_2006_22_38_32_+0100_h2n=6s9G4sv=Xg85--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
