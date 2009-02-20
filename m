From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Timer instability
Date: Fri, 20 Feb 2009 21:34:17 +0100
Message-ID: <20090220203417.GA19093@tango.0pointer.de>
References: <20090219024611.GA7930@tango.0pointer.de>
	<s5hy6w2hqap.wl%tiwai@suse.de>
	<20090220012220.GA11526@tango.0pointer.de>
	<s5h1vtty3f8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 26D3324448
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 21:34:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h1vtty3f8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 20.02.09 08:26, Takashi Iwai (tiwai@suse.de) wrote:

> > Yes, I am. But ignore that part for now. I have now commented the use
> > of that call. Now I certainly get more POLLOUTs as expected, but the
> > real problem stays: after a few minutes _avail() will suddenly jump
> > from next to zero to more then the hwbuf size in less than 1ms without
> > any further inteference and with a buffer size of 350ms! There is
> > something really wrong with the behaviour of _avail().
> > 
> > I can reproduce this only on ens1371 for now.
> 
> The ens1371 driver itself is damn simple.  The pointer callback just
> returns the read value.  So, it implies that it's basically a hardware
> issue.
> 
> Does the patch below have any influence?

No. It doesn't appear to have any effect whatsoever. Still, from time
to time the value returned by _avail() is off by once the buffer size,
sometimes upwards, sometimes downwards.

Moreover I can now reproduce the same issue on snd-intel8x0, albeit it
takes more than a couple of minutes to make snd_pcm_avail() return
bogus data.

Somehow I get the feeling the problem is not so much the inaccuracy of
the pointer the kernel reports but in what alsa-libs does ith it.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
