From: "=?ISO-8859-1?Q?Guillaume_Dupr=E9?=" <gui.dupre@gmail.com>
Subject: Loop sequencer
Date: Fri, 28 Mar 2008 08:26:01 +0100
Message-ID: <c60df1300803280026p18a09024v6164d616bea1b5c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3499F2470F
	for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2008 08:26:03 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so140490wag.8
	for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2008 00:26:01 -0700 (PDT)
Content-Disposition: inline
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

Hello

I try to program a loop midi sequencer with libasound .

For the moment, I have this :

#include <alsa/asoundlib.h>
#include <unistd.h>

using namespace std;
int main()
{
    int aa;
        snd_seq_t* seq;
        int port,port2, queue;
        snd_seq_queue_tempo_t* tempo;
        snd_seq_event_t ev;
        snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, 0);
    snd_seq_set_client_name(seq, "monprog");
        port =3D snd_seq_create_simple_port(seq, "port1",SND_SEQ_PORT_CAP_R=
EAD
| SND_SEQ_PORT_CAP_SUBS_READ,SND_SEQ_PORT_TYPE_APPLICATION);
        queue =3D snd_seq_alloc_queue(seq);
    //TEMPO
        snd_seq_queue_tempo_alloca(&tempo);
        snd_seq_queue_tempo_set_tempo(tempo, 60000000 / 120);
        snd_seq_queue_tempo_set_ppq(tempo, 4);
        snd_seq_set_queue_tempo(seq, queue, tempo);

       snd_seq_connect_to(seq, port, 130, 0);

       snd_seq_start_queue(seq, queue, NULL);
  // write 2 notes
        snd_seq_ev_clear(&ev);
        snd_seq_ev_set_subs(&ev);
        snd_seq_ev_set_source(&ev, port);

        snd_seq_ev_schedule_tick(&ev, queue, 0, 0);
        snd_seq_ev_set_note(&ev, 0, 60, 127, 3);

        snd_seq_event_output(seq, &ev);

        ev.time.tick =3D 4;
        ev.data.note.note =3D 67;
       snd_seq_event_output(seq, &ev);

        snd_seq_drain_output(seq);

sleep(4) ;

        return 0;
}

It works, no problem .
But now, I want to do a loop with my two notes .
I searched on the Internet but I didn't find .

Thanks

Guillaume Dupr=E9
