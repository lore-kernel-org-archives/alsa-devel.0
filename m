From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: Sequencer events not arriving guaranteed
Date: Mon, 18 Feb 2002 20:34:26 +0100 (MET)
Message-ID: <XFMail.020218203426.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Received: from enterprise2.newlogic.com (enterprise2.newlogic.at [194.208.88.1])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA07278
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2002 20:35:00 +0100
Received: from enterprise2.newlogic.com (enterprise2 [172.27.1.1])
	by enterprise2.newlogic.com (8.9.2/8.9.2) with ESMTP id UAA02159
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2002 20:34:27 +0100 (MET)
Received: from ultra1-2.newlogic.at (ultra1-2.newlogic.at [172.27.101.2])
	by enterprise2.newlogic.com (8.9.2/8.9.2) with ESMTP id UAA02155
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2002 20:34:27 +0100 (MET)
Received: (from gsohler@localhost)
	by ultra1-2.newlogic.at (8.10.2+Sun/8.10.2) id g1IJYQH11996
	for alsa-devel@alsa-project.org; Mon, 18 Feb 2002 20:34:26 +0100 (MET)
In-Reply-To: <1014060111.935.2766.camel@phantasy>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello ALSA Gang,

In my system i have primarily two important alsa ports for me

64:0 is the external midi keyboard
65:0 is the wavetable synth of my creative audixy

I have written following code:


#include<alsa/asoundlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <ctype.h>
#include <getopt.h>





int main(int argc, char *argv[])
{
        int xxx;
        snd_seq_event_t ev;
        snd_seq_t *handle;
        sscanf(argv[1],"%d",&xxx);
        snd_seq_open(&handle,"hw",SND_SEQ_OPEN_DUPLEX,0);       
        bzero(&ev, sizeof(ev));
        ev.queue=SND_SEQ_QUEUE_DIRECT;
        ev.dest.client=xxx;
        ev.dest.port=0;
        ev.type = SND_SEQ_EVENT_NOTEON;
        ev.data.note.channel = 0;
        ev.data.note.note = 64;
        ev.data.note.velocity = 127;
        snd_seq_event_output_direct(handle, &ev);
        sleep(1);
        ev.type = SND_SEQ_EVENT_NOTEOFF;
        snd_seq_event_output_direct(handle, &ev);
        return 0;
}

this code works for outputting events to the wavetable, but it very seldom
works for outputting to the external midi keyboard.
If I integrate this code to my application. it works sometimes for outputting
to the wavetable but i have never seen it working with external midi.

Is there an inportant feature missing in my code to make its work more relyable
? (apart from error checking).
Is a queue important for reliability ?
And what about a polling descriptor ?

I am looking forward to makeing my app reliable and working


rds guenther


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
