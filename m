From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: Re: Most simple use of sequencer in ALSA
Date: Sat, 16 Feb 2002 09:47:51 +0100 (MET)
Message-ID: <XFMail.020216094751.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5hlmdud7u2.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

thank you for your info.

now i know that my procedure was almost correct.
Until now i had good success in porting my app to alsa. it will be completed
soon.


rds guenther

On 15-Feb-02 Takashi Iwai wrote:
> At Fri, 15 Feb 2002 07:21:24 +0100 (MET),
> Guenther Sohler wrote:
>> 
>> I have simplified the seq.c in the alsa-driver-test direcory for me
>> to also understand.
>> 
>> The program is now quite short and outputs a note and quits
>> 
>> here is it
>> -----------
>> 
>> #include <stdio.h>
>> #include "alsa/asoundlib.h"
>> 
>> 
>> int main(int argc, char *argv[])
>> {
>>         snd_seq_t *handle;
>>         snd_seq_event_t ev;
>> 
>>         snd_seq_open(&handle, "hw", SND_SEQ_OPEN_DUPLEX, 0);
>>         snd_seq_alloc_queue(handle);
>>         
>>         bzero(&ev, sizeof(ev));
>>         ev.dest.client=65;
>>         ev.dest.port=0;
>>         ev.type = SND_SEQ_EVENT_NOTEON;
>>         ev.data.note.channel = 0;
>>         ev.data.note.note = 64 ;
>>         ev.data.note.velocity = 127;
>>         snd_seq_event_output_direct(handle, &ev);
>>         sleep(1);
>>         ev.type = SND_SEQ_EVENT_NOTEOFF;
>>         snd_seq_event_output_direct(handle, &ev);
>>         snd_seq_drain_output(handle);
>>         return 0;
>> }
>> 
>> There are two questions ?
>> 
>> Why doesn't it work if I allocate no queue ? There is no need for a queue as
>> i
>> directly output events
> 
> No, you don't need to allocate a queue if you schedule by yourself.
> your program lack the schedule of events, i.e.
> 
>       snd_seq_ev_set_direct(&ev);
> 
> before output the event packet.  this is equivalent with
> 
>       ev.queue = SND_SEQ_QUEUE_DIRECT;
> 
> if this is specified, the event is sent immediately to the
> destination, so you don't need any queue.
> as default, the event is scheduled using a specified queue, and as
> default, the queue is #0.  that's why you had to allocate a queue.
> 
> one more note: you don't need to call snd_seq_drain_output() when you
> send events via snd_seq_event_output_direct().  the drain_output() is
> necessary for buffered outputs via normal snd_seq_event_output()
> functions.
> 
> 
>> What does "hw" mean ? what are the other possibilities ?
> 
> originally it means "hardware".
> in future it can be other ones, such like "network:foo", etc.
> (well, we can dream :)
> 
> 
> ciao,
> 
> Takashi
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
