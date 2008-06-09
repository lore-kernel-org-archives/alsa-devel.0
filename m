From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] Fix buffer position for ATI SB4x0
Date: Mon, 9 Jun 2008 17:29:23 -0300
Message-ID: <20080609172923.053f24ea@gaivota>
References: <20080529111022.102bf250@gaivota> <s5hod6pchui.wl%tiwai@suse.de>
	<20080606115232.411c13e3@gaivota> <s5hfxrqcxuv.wl%tiwai@suse.de>
	<20080606153145.4329a297@gaivota> <s5hmylxhcol.wl%tiwai@suse.de>
	<s5htzg2bvd6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F49F24347
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jun 2008 22:29:35 +0200 (CEST)
In-Reply-To: <s5htzg2bvd6.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 09 Jun 2008 15:17:41 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 07 Jun 2008 10:27:54 +0200,
> I wrote:
> > 
> > At Fri, 6 Jun 2008 15:31:45 -0300,
> > Mauro Carvalho Chehab wrote:
> > > 
> > > On Fri, 06 Jun 2008 18:49:28 +0200
> > > Takashi Iwai <tiwai@suse.de> wrote:
> > > 
> > > > At Fri, 6 Jun 2008 11:52:32 -0300,
> > > > Mauro Carvalho Chehab wrote:
> > > > > 
> > > > > On Thu, 29 May 2008 16:20:21 +0200
> > > > > Takashi Iwai <tiwai@suse.de> wrote:
> > > > > 
> > > > > > At Thu, 29 May 2008 11:10:22 -0300,
> > > > > > Mauro Carvalho Chehab wrote:
> > > > > > > 
> > > > > > > ATI SB4x0 doesn't need any fix at position.
> > > > > > 
> > > > > > It's not about the position fixing but whether to use the
> > > > > > position-buffer.  The devices on the blacklist are the ones that have
> > > > > > no position buffer.  So, it would fall into LPIB mode, and this list
> > > > > > avoids it from the beginning.
> > > > > > 
> > > > > > > This patch solves the issue of receiving several clicks during capture on those
> > > > > > > devices.
> > > > > > > 
> > > > > > > Tested with a Gateway Notebook MX-6453.
> > > > > > 
> > > > > > The click noise is often a different problem.  Did you already try
> > > > > > the patch below?
> > > > > 
> > > > > The click seems associated to some residual samples inside the buffer. Here it
> > > > > is a sample of the king of click noise I'm hearing here (captured from CD input entry):
> > > > > 	http://linuxtv.org/~mchehab/snd.ogg
> > > > 
> > > > (I didn't check the ogg file yet, and just a wild guess)
> > > > 
> > > > Is it with dsnoop plugin?  With "default" PCM, ALSA uses dsnoop for
> > > > capture to allow multiplexing for HD-audio.  Does it happen with "hw"
> > > > or "plughw" PCM?
> > > 
> > > Results with the cdplay:
> > > 
> > > With "default" PCM (both with and without mmap):
> > > 	several clicks per second, very high clicks;
> > > 	(like a very risky analog disk)
> > 
> > Hm, it's obviously a problem.  I couldn't reproduce it on my machine
> > with HD-audio, so it might be controller/codec-specific, though.
> > 
> > > With "hw" or "plughw" (no mmap):
> > > 	less clicks (something like two clicks or three per second), with less volume.
> > > 	both hw and plughw produces the same effect.
> > 
> > If it works with hw, plughw should have no effect (i.e. no conversion
> > is done).  Thus it's logical that both hw and plughw have the same
> > result.
> > 
> > > With "hw" or "plughw" and mmap (-M):
> > > 	high quality. no noticeable clicks.
> > > 
> > > So, it seems that there are two different issues: one with dsnoop and another
> > > with non-mmapped captures.
> > 
> > Interesting.  The fact that even "hw" without mmap causes occasional
> > click noises implies that there is certainly a problem with the DMA
> > position calculation.  The dsnoop has more problems likely because it
> > uses smaller period size and more periods than hw, I guess.
> > Still not sure why the mmap mode works.
> > 
> > Anyway, it means that the capture position is wrongly reported, maybe
> > just in a reverse way of the playback position -- a few samples ahead
> > than the real position.  Sigh, another workaround is needed.
> 
> The patch below adds another workaround for the DMA buffer position.
> Could you give it a try?  It adds as default one sample delay for
> issuing the interrupt so that the DMA pointer gets the right
> position.  The delay can be changed (even dynamically) via bdl_pos_adj
> module option.

I tried it here, but I didn't noticed any results. I've ranged the value from 1
to 317 (I had to stop/start record each time). I tried with the default PCM input,
since this way is easier to notice the click.

Cheers,
Mauro
