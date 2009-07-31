From: Christopher Arndt <chris.arndt@web.de>
Subject: pyalsa: SeqEvent.time strangeness (Was: synchronizing
 queue with MIDI clock events)
Date: Fri, 31 Jul 2009 20:26:27 +0200
Message-ID: <4A733753.60808@web.de>
References: <4A607468.7010300@web.de> <4A65C370.3030205@ladisch.de>
	<4A65EADE.70007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 67743245FD
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Jul 2009 20:26:20 +0200 (CEST)
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 1079710931CD9
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Jul 2009 20:26:19 +0200 (CEST)
Received: from [195.14.198.185] (helo=minimax.paddyland.lan)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277) id 1MWwo6-0005nT-00
	for alsa-devel@alsa-project.org; Fri, 31 Jul 2009 20:26:19 +0200
In-Reply-To: <4A65EADE.70007@web.de>
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

Christopher Arndt schrieb:
>> You can tell ALSA to timestamp all events that are received; just call
>> the snd_seq_port_info_set_timestamping() function and set a queue that
>> is running, then you'll get the queue's current time in each event.
>> This isn't implemented in pyalsa, but you can set this for a specific
>> connection with the queue, time_update, and time_real parameters of the
>> connect_ports function.

I've tested this now and encountered a very strange bevahior of the
event time set by the queue:

a) SeqEvent.time seems to be in milliseconds instead of seconds as would
be expected by the ALSA documentation and looking at the source of
pyalsa.alsaseq.

5) Consecutive timestamp go up to ~1000,00 and then seem to wrap around
and start from zereo again.

I have created a small test program, which demonstrates this:

http://paste.chrisarndt.de/paste/fa8ca7201bc7419f9e001315ca02b1ef

It outputs the time of each MIDI clock signal it receives and whether it
is in tick  or real time and whether it's absolute (= from the start of
the queue) or relative (to the preceding event). Here's some output from
the script:

MIDI CLOCK 0.0 ABS REAL
MIDI CLOCK 23.697488 ABS REAL
MIDI CLOCK 48.701538 ABS REAL
MIDI CLOCK 73.70515 ABS REAL
MIDI CLOCK 98.705762 ABS REAL
MIDI CLOCK 123.709812 ABS REAL
MIDI CLOCK 148.702424 ABS REAL
MIDI CLOCK 173.707474 ABS REAL
MIDI CLOCK 198.711086 ABS REAL
[...]
MIDI CLOCK 898.73904 ABS REAL
MIDI CLOCK 923.74909 ABS REAL
MIDI CLOCK 948.744702 ABS REAL
MIDI CLOCK 973.742314 ABS REAL
MIDI CLOCK 998.749364 ABS REAL
MIDI CLOCK 24.738976 ABS REAL
MIDI CLOCK 49.741026 ABS REAL
MIDI CLOCK 74.743638 ABS REAL
MIDI CLOCK 99.74725 ABS REAL

As you can see, once the time would exceed 1000.0 it seems to start from
zero again. This happens only when the queue sets the event times to
REAL. When ticks are used, the increase infinitely, as expected.

I fail to understand why this is and what I am doing wrong. I would
expect SeqEvent.time to be in seconds and always ascending until I stop
the queue. Please, somebody enlighten me!


Chris
