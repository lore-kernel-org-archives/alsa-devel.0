From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 16:29:23 +0200
Message-ID: <20080613142923.GC21255@tango.0pointer.de>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hfxrhhnff.wl%tiwai@suse.de>
	<20080613135128.GA21255@tango.0pointer.de>
	<Pine.LNX.4.61.0806131553450.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 9540D103817
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 16:29:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0806131553450.1798@tm8103-a.perex-int.cz>
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

On Fri, 13.06.08 15:55, Jaroslav Kysela (perex@perex.cz) wrote:

> On Fri, 13 Jun 2008, Lennart Poettering wrote:
> 
> > c) snd_pcm_hw_params_get_buffer_size() - snd_pcm_update_avail()
> >    returns the fill level, but only works on mmap.
> 
> snd_pcm_update_avail() works (or should work) also for standard r/w
> ops.

Ok, so it's just the documentation that needs fixing? Quoting: "Using
of this function is useless for the standard read/write
operations. Use it only for mmap access."

> > d) The snd_pcm_hw_params_get_fifo_size() was supposed to return the
> >    'difference' between a) and c), but was never actually used
> >    for that.
> 
> Nope. It's maximum latency added by an extra fifo/queue (it does not 
> depend if it's hw or sw fifo). For variable fifo size, we need to extend 
> API.

Ok, so it's an upper ceiling for the difference between a) and c), right?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
