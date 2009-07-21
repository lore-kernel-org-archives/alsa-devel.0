From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: pyalsa: synchronizing queue with MIDI clock events
Date: Tue, 21 Jul 2009 15:32:32 +0200
Message-ID: <4A65C370.3030205@ladisch.de>
References: <4A607468.7010300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4363F244D9
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 15:32:18 +0200 (CEST)
In-Reply-To: <4A607468.7010300@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christopher Arndt <chris.arndt@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Christopher Arndt wrote:
> Now to synchronize the queue tempo to incoming MIDI clock events, to be
> able implement synchronized delays or arpeggiators,  I use the method in
> the code shown below. This works ok, but I notice that the measured BPM
> oscillates +-1 BPM around the value displayed by the clock source (my
> synth's sequencer) if I measure/average only a few (~10) ticks or do not
>  round the result to an integer value.
> 
> Is this the right approach? What is a sensible number of ticks to take
> into account for measurement?

Large enough that you get a stable average, but small enough that you
can detect actual changes.

> Should I use another reference timer than Python's time.time() function?

That timer probably has a high enough resolution, but you measure the
time when your code is executed, which may be later then when the
event was actually received.

You can tell ALSA to timestamp all events that are received; just call
the snd_seq_port_info_set_timestamping() function and set a queue that
is running, then you'll get the queue's current time in each event.
This isn't implemented in pyalsa, but you can set this for a specific
connection with the queue, time_update, and time_real parameters of the
connect_ports function.

> Is pyalsa generally suitable for this kind of application even on
> older/weaker hardware (e.g. a NSLU2)?

The biggest problem is probably scheduling delays, so I guess using
Python instead of C should not add any noticeable delay.


Best regards,
Clemens
