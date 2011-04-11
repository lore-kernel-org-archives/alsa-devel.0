From: r10kindsofpeople <r10kindsofpeople@gmail.com>
Subject: Re: incoming sequencer event timestamping (via a
 running queue): how?
Date: Mon, 11 Apr 2011 16:10:34 -0400
Message-ID: <BANLkTik1bFCEwMDw2cgxvLLEFkkyBXkPFQ@mail.gmail.com>
References: <20110411200139.b9a035c0.chromisx@nedlinux.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 775441038F4
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 22:10:35 +0200 (CEST)
Received: by gyg8 with SMTP id 8so2721977gyg.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2011 13:10:34 -0700 (PDT)
In-Reply-To: <20110411200139.b9a035c0.chromisx@nedlinux.nl>
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

On Mon, Apr 11, 2011 at 2:01 PM, R. Dresens <chromisx@nedlinux.nl> wrote:
>
> Hello,
>
> I'm attempting to write a program that lets me record (and play)
> MIDI sequences,
>
> I have created a sequencer queue (with `snd_seq_alloc_queue`), and
> when I set it up and let it run I can observe that the tick value
> properly increases (with `snd_seq_queue_status_get_tick_time`);
> everything runs fine. Queing events to an output work as well.
>
> But is it somehow possible to bind "incoming events" to this queue as
> well? (...in such a way that the `event->time.tick` value of these
> incoming events is used to automatically store the queue timer value
> at reception? ...)
>
> At this moment, I just sample the tick value manually when I get an
> event. That kinda works, but chances are high that the kernel
> sequencer system can do that for me with more accuracy?
>
> I wrote a function that essentially reconnects the inputs of the port
> used for reception just before the queue is started. This allows me
> to set the queue explicitly. I also enable
> `snd_seq_port_subscribe_set_time_update`. It doesnt't work (yet).
>
> Should this work? Am I on the right track? Or am I missing something?
>
> Can anyone give me a hint?
>
> Thanks!
>
> Greetings,
>
> Raymond.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

In your function that does the connection to the reception port...
snd_seq_port_subscribe_set_queue(subs, queue_id); =A0//<< queue_id being
the one you allocated
snd_seq_port_subscribe_set_time_update(subs, 1);
snd_seq_port_subscribe_set_time_real(subs, 0);
snd_seq_subscribe_port(pSeq, subs);

...with the caution that this may be the completely wrong way to go
about this, but it may help until someone more knowledgeable comes
along...

John
