From: "R. Dresens" <chromisx@nedlinux.nl>
Subject: incoming sequencer event timestamping (via a running
	queue): how?
Date: Mon, 11 Apr 2011 20:01:39 +0200
Message-ID: <20110411200139.b9a035c0.chromisx@nedlinux.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq4.gn.mail.iss.as9143.net (smtpq4.gn.mail.iss.as9143.net
	[212.54.34.167]) by alsa0.perex.cz (Postfix) with ESMTP id 40EF3244F4
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 20:01:53 +0200 (CEST)
Received: from [212.54.34.132] (helo=smtp1.gn.mail.iss.as9143.net)
	by smtpq4.gn.mail.iss.as9143.net with esmtp (Exim 4.71)
	(envelope-from <chromisx@nedlinux.nl>) id 1Q9LQv-0001iy-7u
	for alsa-devel@alsa-project.org; Mon, 11 Apr 2011 20:01:53 +0200
Received: from 5ed6401a.cm-7-7b.dynamic.ziggo.nl ([94.214.64.26]
	helo=localhost) by smtp1.gn.mail.iss.as9143.net with smtp (Exim 4.71)
	(envelope-from <chromisx@nedlinux.nl>) id 1Q9LQv-0002C3-0k
	for alsa-devel@alsa-project.org; Mon, 11 Apr 2011 20:01:53 +0200
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


Hello,

I'm attempting to write a program that lets me record (and play)
MIDI sequences,

I have created a sequencer queue (with `snd_seq_alloc_queue`), and
when I set it up and let it run I can observe that the tick value
properly increases (with `snd_seq_queue_status_get_tick_time`);
everything runs fine. Queing events to an output work as well.

But is it somehow possible to bind "incoming events" to this queue as
well? (...in such a way that the `event->time.tick` value of these
incoming events is used to automatically store the queue timer value
at reception? ...)

At this moment, I just sample the tick value manually when I get an
event. That kinda works, but chances are high that the kernel
sequencer system can do that for me with more accuracy?

I wrote a function that essentially reconnects the inputs of the port
used for reception just before the queue is started. This allows me
to set the queue explicitly. I also enable
`snd_seq_port_subscribe_set_time_update`. It doesnt't work (yet).

Should this work? Am I on the right track? Or am I missing something?

Can anyone give me a hint?

Thanks!

Greetings,

Raymond.
