From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: Forcing an absolute timestamp for every midi event.
Date: Wed, 21 Aug 2002 02:10:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <005601c248af$92d0a860$0400a8c0@martijn>
References: <20020819050734.0e3e0a7c.coding@reduz.com.ar> <003a01c2477d$6a346d20$0400a8c0@martijn> <20020820211118.GA3301@idefix.fvdpol.home.nl>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA20047
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2002 02:13:22 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Frank van de Pol <fvdpol@home.nl>
Cc: Juan Linietsky <coding@reduz.com.ar>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[...]
> > I'm working on this, but it is not that easy since merging MIDI streams
> > is non-trivial and I want to be able to have hardware do the scheduling
if
> > it supports it and this means events can only be queued in timed order.
>
> Not necessarely; If you have the ability to adjust when your timer is to
be
> fired/generate irq, you can readjust the schedule time when an event is
> received (after all, that's the whole fun with an event based interface).
> Merging streams is not a problem; You'll need a priority queue anyway for
> merging multiple streams.

Perhaps it is not necessary to have the messages queued in timed order, but
on the other hand and application should be able to know the order of the
messages and thus has no good reason not queue them time ordered. I think
a requirement for time-ordered queueing in combination with a global
pre-schedule
value (i.e. minimum time scheduled events are to be queued early) could
simplify
implementation.

--martijn





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
