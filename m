From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: Type safe Haskell interface to ALSA sequencer
Date: Tue, 25 May 2010 16:11:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1005251520410.6065@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mlucom15.urz.uni-halle.de (mlucom15.urz.uni-halle.de
	[141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id 01348245A8
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 16:11:30 +0200 (CEST)
Received: from mserv3.urz.uni-halle.de ([141.48.3.161])
	by mlucom15.urz.uni-halle.de with esmtp  (Exim 4.71)
	id 1OGuqv-0000cH-SU for <alsa-devel@alsa-project.org>
	; Tue, 25 May 2010 16:11:30 +0200
Received: from janus.informatik.uni-halle.de ([141.48.9.42])
	by mail.uni-halle.de
	(Sun Java(tm) System Messaging Server 6.3-11.01 (built Feb 12 2010;
	32bit)) with ESMTP id <0L2Z00E9SBET9R00@mail.uni-halle.de> for
	alsa-devel@alsa-project.org; Tue, 25 May 2010 16:11:17 +0200 (CEST)
Received: from anubis.informatik.uni-halle.de
	(anubis.informatik.uni-halle.de [141.48.165.107])
	by janus.informatik.uni-halle.de (Postfix) with SMTP id AE12CC6D73	for
	<alsa-devel@alsa-project.org>; Tue, 25 May 2010 16:11:17 +0200 (CEST)
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


Dear ALSA developers,

  I read the ALSA-Sequencer-API-Doxygen documentation, various 
ALSA-MIDI-How-Tos and their examples and succeeded to work with ALSA 
sequencers in Haskell. However, I'm still uncertain about the meaning of 
the system components and how they interact. It is extensively documented, 
what works, but not, what does not work. Whenever I do a mistake, ALSA 
leaves me with an unspecific "operation not permitted" or "invalid 
argument" error code. Thus I try to encode conditions in Haskell types.

  For instance once I got an "Invalid argument" error code and only after 
some investigation, I found that I opened the sequencer in Output mode but 
later called event_input. (Actually I only wanted to output something, but 
used event_input for synchronization using Echo events. Unfortunately the 
intention of Echo messages is even not explained in the Doxygen stuff.) In 
order to prevent another occurrence of this problem, I defined distinct 
Haskell types for sequencers depending on the input mode. Now, event_input 
is only allowed on sequencers that were opened in Output or Duplex mode.

  However I wondered, why I could create writeable ports in a output-only 
sequencer. Does this make sense? Would it be reasonable to forbid 
writeable ports in output sequencers and readable ports in input 
sequencers by Haskell types? Is there a difference between 
cap_read|cap_write and cap_duplex?

  I also wondered why there can be several ports in one sequencer, since 
multiple clients can connect to one port, and event_input and event_output 
have no port argument. Further I wondered why queues are not bound to a 
specific port. Can queues be shared amongst ports? Is it sensible to have 
multiple queues in one sequencer? Why has sync_output_queue no queue 
argument? The more I think about it, it seems to me that a port is more an 
identifier, a part of an address, than a mailbox. I could use ports as 
tags, that tell which part of an application to control. A queue looks 
like a mail company and I can use the same sender and receiver addresses 
across different companies. If this is true, then I think it would be 
worth to mention this in the API documentation.

  In another example I called sync_output_queue in order to wait for all 
events being sent, but it aborted with "Operation not permitted", whereas 
I have seen example code where it works. What are the preconditions to 
calling sync_output_queue?

  I really like to see a picture of how sequencers, clients, ports, 
port_infos, queues, timers, events are related.
