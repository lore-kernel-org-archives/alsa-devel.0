From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] Fix buffer position for ATI SB4x0
Date: Fri, 6 Jun 2008 11:52:32 -0300
Message-ID: <20080606115232.411c13e3@gaivota>
References: <20080529111022.102bf250@gaivota>
	<s5hod6pchui.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 263571037EF
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jun 2008 16:52:40 +0200 (CEST)
In-Reply-To: <s5hod6pchui.wl%tiwai@suse.de>
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

On Thu, 29 May 2008 16:20:21 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 29 May 2008 11:10:22 -0300,
> Mauro Carvalho Chehab wrote:
> > 
> > ATI SB4x0 doesn't need any fix at position.
> 
> It's not about the position fixing but whether to use the
> position-buffer.  The devices on the blacklist are the ones that have
> no position buffer.  So, it would fall into LPIB mode, and this list
> avoids it from the beginning.
> 
> > This patch solves the issue of receiving several clicks during capture on those
> > devices.
> > 
> > Tested with a Gateway Notebook MX-6453.
> 
> The click noise is often a different problem.  Did you already try
> the patch below?

The click seems associated to some residual samples inside the buffer. Here it
is a sample of the king of click noise I'm hearing here (captured from CD input entry):
	http://linuxtv.org/~mchehab/snd.ogg

I've started/stopped the CD some times (with cdplay). When volume goes to zero,
after an "echoed click", it disappears.

I've did some trials with position_fix changes, but nothing solved. So, my
previous patch were wrong. The click is somewhere else (still, I suspect that
it is linked to the buffer handling).

Cheers,
Mauro
