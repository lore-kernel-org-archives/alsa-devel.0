From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: RE: Sequencer events not arriving guaranteed
Date: Tue, 19 Feb 2002 09:24:51 +0100 (MET)
Message-ID: <XFMail.020219092451.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Received: from enterprise2.newlogic.com (enterprise2.newlogic.at [194.208.88.1])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA22297
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2002 09:25:41 +0100
Received: from enterprise2.newlogic.com (enterprise2 [172.27.1.1])
	by enterprise2.newlogic.com (8.9.2/8.9.2) with ESMTP id JAA15017
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2002 09:24:52 +0100 (MET)
In-Reply-To: <Pine.LNX.4.31.0202190909040.535-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Does that mean, i have to do following:

1.) open sequencer
2.) create my own port on client
3.) subscribe sender=my port receiver=midi device
4.) create events set source to my client/port destination=midi device
5.) send events

is this the correct way of doing it ?
are there some extra things, which are not neccessary ?


On 19-Feb-02 Jaroslav Kysela wrote:
> On Tue, 19 Feb 2002, Guenther Sohler wrote:
> 
>>
>> On 18-Feb-02 Guenther Sohler wrote:
>> > Hello ALSA Gang,
>> >
>> > In my system i have primarily two important alsa ports for me
>> >
>> > 64:0 is the external midi keyboard
>> > 65:0 is the wavetable synth of my creative audixy
>> >
>> > I have written following code:
>> >
>> >
>> >#include<alsa/asoundlib.h>
>> >#include <stdio.h>
>> >#include <stdlib.h>
>> >#include <string.h>
>> >#include <errno.h>
>> >#include <ctype.h>
>> >#include <getopt.h>
>> >
>> >
>> >
>> >
>> >
>> > int main(int argc, char *argv[])
>> > {
>> >         int xxx;
>> >         snd_seq_event_t ev;
>> >         snd_seq_t *handle;
>> >         sscanf(argv[1],"%d",&xxx);
>> >         snd_seq_open(&handle,"hw",SND_SEQ_OPEN_DUPLEX,0);
>> >         bzero(&ev, sizeof(ev));
>> >         ev.queue=SND_SEQ_QUEUE_DIRECT;
>> >         ev.dest.client=xxx;
>> >         ev.dest.port=0;
>> >         ev.type = SND_SEQ_EVENT_NOTEON;
>> >         ev.data.note.channel = 0;
>> >         ev.data.note.note = 64;
>> >         ev.data.note.velocity = 127;
>> >         snd_seq_event_output_direct(handle, &ev);
>> this also causes the same error
>> >         sleep(1);
>> >         ev.type = SND_SEQ_EVENT_NOTEOFF;
>> >         snd_seq_event_output_direct(handle, &ev);
>> Now I have found, that this command causes an error Nr 28
>> "No Space left on device" But I dont have an idea, why ?
> 
> It's not an error but written bytes. I found a few implementation bugs for
> direct event handling. The CVS code returns -ENODEV for your events. You
> have to subscribe the MIDI port to your port before sending events,
> otherwise the output rawmidi device is not opened, thus it can't accept
> any events.
> 
>                                               Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project  http://www.alsa-project.org
> SuSE Linux    http://www.suse.com
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

Guenther Sohler

NewLogic Technologies AG 
Millennium Park 6
A-6890 Lustenau
                                           Phone: +43-5577-62000-507
E-Mail: guenther.sohler@newlogic.com       Fax:   +43-5577-62000-988


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
