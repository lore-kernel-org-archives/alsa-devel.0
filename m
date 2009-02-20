From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Timer instability
Date: Fri, 20 Feb 2009 02:50:19 +0100
Message-ID: <20090220015019.GA12980@tango.0pointer.de>
References: <20090219024611.GA7930@tango.0pointer.de>
	<s5hy6w2hqap.wl%tiwai@suse.de>
	<20090220012220.GA11526@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id C2E2A1037F9
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 02:50:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090220012220.GA11526@tango.0pointer.de>
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

On Fri, 20.02.09 02:22, Lennart Poettering (mznyfn@0pointer.de) wrote:

> > > 
> > > If necessary I could extract a test case for this, but my hope that
> > > you guys might have an idea what goes on without a test case, given
> > > that this smells so "overflowy" ;-)
> > > 
> > > And of course, how come ALSA triggers POLLIN if I asked it not to?
> > 
> > Are you using *_period_event() stuff?
> 
> Yes, I am. But ignore that part for now. I have now commented the use
> of that call. Now I certainly get more POLLOUTs as expected, but the
> real problem stays: after a few minutes _avail() will suddenly jump
> from next to zero to more then the hwbuf size in less than 1ms without
> any further inteference and with a buffer size of 350ms! There is
> something really wrong with the behaviour of _avail().
> 
> I can reproduce this only on ens1371 for now.

Actually it is worse than just the issue mentioned above. I also can
reproduce that _avail() tells me the device is almost completely full
(i.e. 370ms of data), and when i then go to sleep for 350ms then
afterwards _avail() will tell me that about 700ms are missing. From
the context the first _avail() was just wrong.

In summary: _avail() is completely unreliable on ens1371. It sometimes
returns values that are too high by once the buffer size, and
sometimes too low by once the buffer size.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
