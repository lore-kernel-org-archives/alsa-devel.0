From: Josep Andreu <holborn@telefonica.net>
Subject: ALSA seq Segfault on snd_seq_event_output_direct in
	64bit
Date: Sun, 5 Sep 2010 01:17:18 +0100
Message-ID: <20100905011718.813dd7dd.holborn@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from IMPaqm2.telefonica.net (impaqm2.telefonica.net [213.4.138.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 63A391037E3
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Sep 2010 02:17:34 +0200 (CEST)
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


Hi

I was made a program called stygmorgan that mades hard use of the ALSA sequencer ...

I run this programs in a lot of 32 bit computers without problems but I received various emails form ppl that has 64bit and the program segfault in:

#0  0x00007f5e6c1cb9a6 in snd_seq_event_output_direct () from /usr/lib/libasound.so.2
#1  0x000000000040caf2 in RMGMO::enviocontrol (this=<value optimized out>, canal=<value optimized out>, 
                control=28, value=0) at stygmorgan.midiout.C:91


Unfortunately I dont have any 64 bit computer to check but I made some checks with some users and the  incredible thing is the segfault is produced after the function is called 90 times ...  at the 91 segfault. And is not related to the midi event data because previously I send the same data.
 
This is the function:

void
RMGMO::enviocontrol(int canal,int control, int value)
{

snd_seq_event_t midievent;               
snd_seq_ev_clear (&midievent);

snd_seq_ev_set_controller (&midievent, canal, control, value);
snd_seq_ev_set_subs (&midievent);
snd_seq_ev_set_direct (&midievent);
snd_seq_event_output_direct (midi_out, &midievent);

}


Any help ... any idea? ... is this an ALSA seq bug?  

Josep



-- 
Josep Andreu <holborn@telefonica.net>
