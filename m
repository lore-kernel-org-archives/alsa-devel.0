From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: Sequencer events not arriving guaranteed
Date: Tue, 19 Feb 2002 09:11:42 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202190909040.535-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA22096
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2002 09:12:32 +0100
In-Reply-To: <XFMail.020219070036.guenther.sohler@newlogic.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guenther Sohler <guenther.sohler@newlogic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Feb 2002, Guenther Sohler wrote:

>
> On 18-Feb-02 Guenther Sohler wrote:
> > Hello ALSA Gang,
> >
> > In my system i have primarily two important alsa ports for me
> >
> > 64:0 is the external midi keyboard
> > 65:0 is the wavetable synth of my creative audixy
> >
> > I have written following code:
> >
> >
> >#include<alsa/asoundlib.h>
> >#include <stdio.h>
> >#include <stdlib.h>
> >#include <string.h>
> >#include <errno.h>
> >#include <ctype.h>
> >#include <getopt.h>
> >
> >
> >
> >
> >
> > int main(int argc, char *argv[])
> > {
> >         int xxx;
> >         snd_seq_event_t ev;
> >         snd_seq_t *handle;
> >         sscanf(argv[1],"%d",&xxx);
> >         snd_seq_open(&handle,"hw",SND_SEQ_OPEN_DUPLEX,0);
> >         bzero(&ev, sizeof(ev));
> >         ev.queue=SND_SEQ_QUEUE_DIRECT;
> >         ev.dest.client=xxx;
> >         ev.dest.port=0;
> >         ev.type = SND_SEQ_EVENT_NOTEON;
> >         ev.data.note.channel = 0;
> >         ev.data.note.note = 64;
> >         ev.data.note.velocity = 127;
> >         snd_seq_event_output_direct(handle, &ev);
> this also causes the same error
> >         sleep(1);
> >         ev.type = SND_SEQ_EVENT_NOTEOFF;
> >         snd_seq_event_output_direct(handle, &ev);
> Now I have found, that this command causes an error Nr 28
> "No Space left on device" But I dont have an idea, why ?

It's not an error but written bytes. I found a few implementation bugs for
direct event handling. The CVS code returns -ENODEV for your events. You
have to subscribe the MIDI port to your port before sending events,
otherwise the output rawmidi device is not opened, thus it can't accept
any events.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
