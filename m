From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: Re: sending a sequencer event to a delayed queue
Date: Wed, 14 Mar 2012 18:37:54 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1203141831240.26232@anubis.informatik.uni-halle.de>
References: <alpine.DEB.2.00.1203101859280.16157@anubis.informatik.uni-halle.de>
	<4F5BBECF.8020506@ladisch.de> <4F5CC7AB.3030300@henning-thielemann.de>
	<4F5D0DC5.7090908@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
	[141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id B31B1103AFD
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 18:38:04 +0100 (CET)
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

Hm, I am thinking about how to make use of snd_seq_remove_events in my 
application. It's sad that I cannot find out what events I have actually 
removed. It would be bad if e.g. a NoteOff gets lost and thus a tone is 
played forever. It would be great if I could find out pending events in 
the queue (in the kernel space). Then I could fetch them and re-send them 
immediately, when the user stops my sequencer.
  Unfortunately snd_seq_extract_output only fetches events from the user 
buffer. Is there a snd_seq_extract_output for drained messages?


Regards,
Henning
