From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa timestamps
Date: Mon, 19 Nov 2007 14:07:30 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711191405590.7813@tm8103.perex-int.cz>
References: <47413D60.9000404@cs.helsinki.fi> <47418778.20609@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 9884024771
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 14:07:30 +0100 (CET)
In-Reply-To: <47418778.20609@cs.helsinki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Heikki Lindholm <holindho@cs.helsinki.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 19 Nov 2007, Heikki Lindholm wrote:

> Heikki Lindholm kirjoitti:
> > Hello list,
> > 
> > I took up some old dusty code of mine that uses snd_pcm_state followed 
> > by snd_pcm_status_get_tstamp when in capture mode. The code used to 
> > work, but now the returned timestamps are all zeroes. Is there some API 
> > change done recently or is the whole timestamping deprecated or 
> > something? I've tried with different drivers on ubuntu's alsa .14 and 
> > gentoo's .14. I've also tried mmap'ed and r/w modes, and I'm setting the 
> > TSTAMP_MMAP sw param.
> 
> I figured out that this doesn't happen when using hw:x,y devices. Is it 
> a documented feature that some (software?) devices don't fill in timestamps?

I think that it should be fixed. Could you send us 'snd_pcm_dump()' for a 
non-working device? It's probably ommited code in direct pcm plugins (dmix 
& etc.).

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
