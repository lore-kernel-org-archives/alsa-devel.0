From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: sending a sequencer event to a delayed queue
Date: Sat, 10 Mar 2012 19:20:30 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1203101859280.16157@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
	[141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id 14B9F244F8
	for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2012 19:21:23 +0100 (CET)
Received: from mserv3.urz.uni-halle.de ([141.48.3.161])
	by mlucom18.urz.uni-halle.de with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.77) id 1S6Qux-0002qm-D0 for <alsa-devel@alsa-project.org>
	; Sat, 10 Mar 2012 19:21:23 +0100
Received: from hermes.informatik.uni-halle.de ([141.48.9.46])
	by mail.uni-halle.de
	(Sun Java(tm) System Messaging Server 6.3-15.01 (built Mar 21 2011;
	32bit)) with ESMTP id <0M0O00BNCLM6OIC0@mail.uni-halle.de> for
	alsa-devel@alsa-project.org; Sat, 10 Mar 2012 19:20:30 +0100 (CET)
Received: from anubis.informatik.uni-halle.de
	(anubis.informatik.uni-halle.de [141.48.165.107])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by hermes.informatik.uni-halle.de
	(Postfix)
	with ESMTPS id 905374E3268F	for <alsa-devel@alsa-project.org>; Sat,
	10 Mar 2012 19:20:30 +0100 (CET)
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


Unfortunately the ALSA doc does not say, what happens if I send an event 
to a queue that is not running. I expected that the event is being 
delivered once the queue is started. But it seems that instead the event 
is dropped. What is the reason for that behaviour?

  What I want to do is the following: I have a program that computes a 
sequence of events in real-time. Since computation of an event requires 
varying amount of time, I want to add a latency in order to get a 
correctly timed output. To this end I set up two queues: One queue 
triggers computation of events via Echo messages and the other queue 
delivers the computed events. I want to use the same time stamps for both 
queues and just start the queues with a delay between them.
  Why is it not possible to use one queue and add latency manually to the 
timestamps? Because the user of the program shall be able to halt the 
computation. Thus the computation must be halted first and the delivery of 
events must be halted later. I cannot achieve this with one queue and a 
queue_stop command.
  Now the problem is: When my program starts it computes the first event 
and sends it to the second (delayed) queue. But since this queue is 
started only after a delay, it is not yet running and thus my event is not 
delayed, but lost. :-( How to solve that problem? Is there a proposed way 
to manage latency in ALSA sequencing?


Regards,
Henning
