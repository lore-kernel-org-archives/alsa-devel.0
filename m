From: Alexandre Oberlin <alxobr@free.fr>
Subject: Re: alsa sequencer: How to eliminate choking
Date: Sun, 12 Dec 2004 01:45:47 +0100
Message-ID: <41BB94BB.789B09F6@free.fr>
References: <20041207030836.76199.qmail@web51904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Michael Geis <michaelgeis11@yahoo.com>
List-Id: alsa-devel@alsa-project.org

Michael Geis wrote:
> 
> 
> The streaming works for pieces that dont contain many parts, but when
> many notes are played simultaneously (e.g. Beethoven's 5 Symphony,
> Movement 1), the order of notes gets mixed up and the output devices
> choke (same problem for a keyboard and with timidity). However, the
> midifile I made the score from plays nicely with pmidi.
> I am pretty convinced that the problem is not queue overflow, since I
> flush queues every two seconds.
The problem apparently lays with the event feeding loops in your app.
This is more likely to arise with midi files containing several tracks
and many notes.
When the user space (external) output buffer becomes full (or when you
explicitely call snd_seq_drain_output), this buffer's contents are
passed over to the sequencer's internal memory pool. At this moment your
app (or midi thread) may have to wait if there is not enough room to
complete the transfer instantly. When the contents of the buffer have
been successfully transferred, you app will catch up feeding the buffer
with scheduled events. If your events are scheduled relative,
ev->time.tick is just the delay between the call to snd_seq_event_output
and the actual sound production. So if a transfer pause occurred before
this call, the event might be processed later than you expected. The
tracks might even get mixed up. 

Two solutions are:
1. Either you monitor more strictly the calls to snd_seq_event_output
and snd_seq_drain_output so that you are sure that you will never have
to wait for the transfer.
2. Either you schedule your events absolute, that is relative=0 in
snd_seq_ev_schedule_tick(ev, q, relative, ttick ). ev->time.tick is then
the time interval between the time when you called snd_seq_start_queue
and the actual sound production. snd_seq_get_queue_status and
snd_seq_queue_status_get_tick_time might then come in handy if you have
more than a straightforward scheduling.

> Does someone have an idea where the choking could come from and what
> measures can be used to get rid of it?
> 
Hope this helps. 
It is based on what I found in the mailing list as well as my own
experiments, so don't hesitate to tell me if I am plain wrong. 

Alexandre Oberlin


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
