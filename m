From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] Fix buffer position for ATI SB4x0
Date: Fri, 6 Jun 2008 15:31:45 -0300
Message-ID: <20080606153145.4329a297@gaivota>
References: <20080529111022.102bf250@gaivota> <s5hod6pchui.wl%tiwai@suse.de>
	<20080606115232.411c13e3@gaivota> <s5hfxrqcxuv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	by alsa0.perex.cz (Postfix) with ESMTP id B61E2244B6
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jun 2008 20:32:02 +0200 (CEST)
In-Reply-To: <s5hfxrqcxuv.wl%tiwai@suse.de>
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

On Fri, 06 Jun 2008 18:49:28 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 6 Jun 2008 11:52:32 -0300,
> Mauro Carvalho Chehab wrote:
> > 
> > On Thu, 29 May 2008 16:20:21 +0200
> > Takashi Iwai <tiwai@suse.de> wrote:
> > 
> > > At Thu, 29 May 2008 11:10:22 -0300,
> > > Mauro Carvalho Chehab wrote:
> > > > 
> > > > ATI SB4x0 doesn't need any fix at position.
> > > 
> > > It's not about the position fixing but whether to use the
> > > position-buffer.  The devices on the blacklist are the ones that have
> > > no position buffer.  So, it would fall into LPIB mode, and this list
> > > avoids it from the beginning.
> > > 
> > > > This patch solves the issue of receiving several clicks during capture on those
> > > > devices.
> > > > 
> > > > Tested with a Gateway Notebook MX-6453.
> > > 
> > > The click noise is often a different problem.  Did you already try
> > > the patch below?
> > 
> > The click seems associated to some residual samples inside the buffer. Here it
> > is a sample of the king of click noise I'm hearing here (captured from CD input entry):
> > 	http://linuxtv.org/~mchehab/snd.ogg
> 
> (I didn't check the ogg file yet, and just a wild guess)
> 
> Is it with dsnoop plugin?  With "default" PCM, ALSA uses dsnoop for
> capture to allow multiplexing for HD-audio.  Does it happen with "hw"
> or "plughw" PCM?

Results with the cdplay:

With "default" PCM (both with and without mmap):
	several clicks per second, very high clicks;
	(like a very risky analog disk)

With "hw" or "plughw" (no mmap):
	less clicks (something like two clicks or three per second), with less volume.
	both hw and plughw produces the same effect.

With "hw" or "plughw" and mmap (-M):
	high quality. no noticeable clicks.

So, it seems that there are two different issues: one with dsnoop and another
with non-mmapped captures.

Cheers,
Mauro
