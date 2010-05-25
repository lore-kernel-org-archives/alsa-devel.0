From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Type safe Haskell interface to ALSA sequencer
Date: Tue, 25 May 2010 17:27:30 +0200
Message-ID: <4BFBEC62.7030101@ladisch.de>
References: <alpine.DEB.2.00.1005251520410.6065@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id CE914245F6
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 17:27:36 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.00.1005251520410.6065@anubis.informatik.uni-halle.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Henning Thielemann <alsa@henning-thielemann.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Henning Thielemann wrote:
> ...
>   However I wondered, why I could create writeable ports in a output-only
> sequencer. Does this make sense? Would it be reasonable to forbid
> writeable ports in output sequencers and readable ports in input
> sequencers by Haskell types?

The PORT_CAP flags say what _other_ clients are allowed to do with the
port, but they do not enforce restrictions for the port's client itself.

For example, aplaymidi needs a source port for the events it sends, but
this port isn't of interest to any other application, so it doesn't set
_any_ CAP flag.

Whether an application can read/write events is determined only by the
INPUT/OUTPUT flags given to snd_seq_open.

> Is there a difference between cap_read|cap_write and cap_duplex?

In theory, the latter indicates that input and output are allowed at the
same time.  (In practice, nobody cares.)

>   I also wondered why there can be several ports in one sequencer, since
> multiple clients can connect to one port,

MIDI has a limit of 16 channels per port, so it is often necessary to
have multiple ports per device.

> and event_input and event_output have no port argument.

Events are sent between clients; their source and destination ports are
more like labels.

> Further I wondered why queues are not bound to a specific port. Can
> queues be shared amongst ports?

Queues are about _timing_; they allow events sent through them to be
timestamped and/or to be delivered at a specific time.

Queues do not have a direct relationship with ports, the events sent
through them have.

> Is it sensible to have multiple queues in one sequencer?

If you want to use multiple timers.

> Why has sync_output_queue no queue argument?

Because it does not actually apply to a sequencer queue.  Events that
are scheduled to be sent later remain in the sending client's output
buffer until they are actually delivered.  This output buffer is called
"queue" here.

> ... it would be worth to mention this in the API documentation.

I've added an entry to my TODO list to move the "documentation" TODO
entry further up.

>   In another example I called sync_output_queue in order to wait for all
> events being sent, but it aborted with "Operation not permitted", whereas
> I have seen example code where it works. What are the preconditions to
> calling sync_output_queue?

In theory, none except having the client opened for output, and I don't
see any code that could return -EPERM for this.


Regards,
Clemens
