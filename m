From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: Re: sending a sequencer event to a delayed queue
Date: Tue, 13 Mar 2012 23:33:07 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1203132322120.5893@anubis.informatik.uni-halle.de>
References: <alpine.DEB.2.00.1203101859280.16157@anubis.informatik.uni-halle.de>
	<4F5BBECF.8020506@ladisch.de> <4F5CC7AB.3030300@henning-thielemann.de>
	<4F5D0DC5.7090908@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
	[141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id 546BC104232
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 23:33:11 +0100 (CET)
In-reply-to: <4F5D0DC5.7090908@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Sun, 11 Mar 2012, Clemens Ladisch wrote:

> I'd suggest to use one queue for both kinds of events, and to add the
> delay to the scheduled time.  To remove certain events, use
> snd_seq_remove_events().

In order to understand how snd_seq_remove_events works, I looked into its 
source code ... I wondered why I can set the queue as condition with 
snd_seq_remove_events_set_queue but there is no flag that enables queue 
matching and actually the queue is not checked in remove_match, as far as 
I can see.

I have another question: Is snd_seq_remove_events atomic, that is, if some 
events have the same time stamp, is it guaranteed that they are removed 
all or none at all? Are events still delivered while removing? Or is there 
a possibility to check what I actually removed? I also thought about using 
snd_seq_extract_output, but I am concerned about removing events while 
events are delivered.


Regards,
Henning
