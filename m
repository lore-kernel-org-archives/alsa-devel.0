From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: Most simple use of sequencer in ALSA
Date: Fri, 15 Feb 2002 07:21:24 +0100 (MET)
Message-ID: <XFMail.020215072124.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
In-Reply-To: <XFMail.020204113205.guenther.sohler@newlogic.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have simplified the seq.c in the alsa-driver-test direcory for me
to also understand.

The program is now quite short and outputs a note and quits

here is it
-----------

#include <stdio.h>
#include "alsa/asoundlib.h"


int main(int argc, char *argv[])
{
        snd_seq_t *handle;
        snd_seq_event_t ev;

        snd_seq_open(&handle, "hw", SND_SEQ_OPEN_DUPLEX, 0);
        snd_seq_alloc_queue(handle);
        
        bzero(&ev, sizeof(ev));
        ev.dest.client=65;
        ev.dest.port=0;
        ev.type = SND_SEQ_EVENT_NOTEON;
        ev.data.note.channel = 0;
        ev.data.note.note = 64 ;
        ev.data.note.velocity = 127;
        snd_seq_event_output_direct(handle, &ev);
        sleep(1);
        ev.type = SND_SEQ_EVENT_NOTEOFF;
        snd_seq_event_output_direct(handle, &ev);
        snd_seq_drain_output(handle);
        return 0;
}

There are two questions ?

Why doesn't it work if I allocate no queue ? There is no need for a queue as i
directly output events
What does "hw" mean ? what are the other possibilities ?



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
