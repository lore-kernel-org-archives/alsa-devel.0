From: Tim Goetze <tim@quitte.de>
Subject: Re: user mode sequencer timer?
Date: Mon, 19 Aug 2002 20:40:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0208192009370.673-100000@summer.quitte>
References: <s5hu1lqssuk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA26268
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2002 20:54:00 +0200
In-Reply-To: <s5hu1lqssuk.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Mon, 19 Aug 2002 17:42:07 +0200 (CEST),
>Tim Goetze wrote:
>> 
>> Takashi Iwai wrote:
>> 
>> >At Mon, 19 Aug 2002 09:22:10 +0200 (CEST),
>> >Tim Goetze wrote:
>> >> 
>> >> Is it possible to register a sequencer client that acts as a timer
>> >> (not only an event consumer/producer), and if so, how would one go 
>> >> about implementing one?
>> >
>> >timer = event producer in a certain schedule, isn't it ??
>> >it will deliver "tick" events in a programmed rythm.
>> 
>> You mean it is sufficient to emit SND_SEQ_EVENT_SETPOS_TICK or *_TIME 
>> periodically, and transport control events accordingly? Are these 
>> events then used by alsa-lib to update the queue timing information?
>
>well, sorry, then i misunderstood your question.
>
>do you mean that a sequencer client as a timer source, or as a
>controller of the queue?
>
>the former is difficult, because the queue is driven by interrupts
>from a timer source.  that is, a sequencer client must give signals at
>the constant and fine period.  this is not a job what a user process
>does.
>
>the latter, controlling a queue, would be feasible.
>in this case, you can change the tempo or time skew dynamically by
>sending events via system-timer port (0:0) to a specified queue.
>but anyway, a queue must run individually from the client.
>
>maybe i can give more specific answer if i understand your question
>more clearly...

OK, here goes. I have a core here that processes MIDI and PCM. There's
a RTC thread that controls event timing, synced to the sample clock. 
So, internally, the application has a precise idea of the current 
tempo, tick, time and frame.

Currently, events sent to ALSA sequencer ports are sent via
snd_seq_event_output_direct(), with a 0 timestamp. 

Now what I'm looking for is a way to export this timer functionality
to the sequencer system, ie make it possible for other clients to
sync to this clock.

tim



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
