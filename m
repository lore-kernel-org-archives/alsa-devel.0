From: "R. Dresens" <chromisx@nedlinux.nl>
Subject: Re: Detecting new alsa sequencer clients (with some
 event loop) so that i can subscribe them
Date: Tue, 1 Apr 2008 23:24:00 +0200
Message-ID: <20080401232400.0ab32b71.chromisx@nedlinux.nl>
References: <20080401034801.7ad2696d.chromisx@nedlinux.nl>
	<47F1DDDE.5090703@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id DF4152446C
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Apr 2008 17:28:44 +0200 (CEST)
In-Reply-To: <47F1DDDE.5090703@ladisch.de>
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

On Tue, 01 Apr 2008 09:01:50 +0200
Clemens Ladisch <clemens@ladisch.de> wrote:

> > A possible solution is polling; every second or so, i could
> > generate a list of clients with snd_seq_query_next_client and
> > look for a certain client name (libpcre comes to mind here;), but
> > I was wondering if there is a better solution? ..in other words, is
> > it possible to get such events from the system in a similar way
> > like one would receive regular  MIDI events?
> 
> Subscribe to SND_SEQ_CLIENT_SYSTEM:SND_SEQ_PORT_SYSTEM_ANNOUNCE.
> Try "aseqdump -p 0:1" to see what events you get.

Yes, that did the trick: this is exactly what I'm looking for.

Thanks for your help!

Greetings,

Raymond Dresens.
