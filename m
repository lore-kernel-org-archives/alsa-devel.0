From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd-rme9652_mem and the H-DSP
Date: Thu, 9 May 2002 16:43:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0205091638130.482-100000@pnote.perex-int.cz>
References: <200205091257.g49CvTO16266@op.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA28028
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 16:44:28 +0200
In-Reply-To: <200205091257.g49CvTO16266@op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 May 2002, Paul Davis wrote:

> both the hammerfall and hammerfall-dsp require exactly the same kind
> of memory allocation. the snd-rme9652_mem module, which allocates
> a contiguous chunk of about 1.2MB of physical RAM, uses the "driver
> index" to identify which snd-card is using a given buffer. this means
> that if we try to use both a hammerfall and a hammerfall-dsp, things
> don't work: both drivers pass "driver index" = 0 to the memory
> module, and the second try (whatever it is) concludes that it already
> has buffers allocated.
> 
> i propose using the card->number value instead, so that the numbers are
> unique across all driver modules. 
> 
> the only other option i can see is to duplicate the code in
> snd-rme9652_mem, which seems really dumb.
> 
> i also propose renaming the module to snd-hammerfall_mem to clearly
> indicate its generic status, and moving it into its own directory. it
> will be built if either CONFIG_SND_CARD_RME9652 and/or
> CONFIG_SND_CARD_HDSP are defined.
> 
> let me know if this sounds like the right solution, or if you have a
> better one.

Perhaps, we can use a more universal name like 'snd-pci-bigmem' or
something like that. Other hardware might require this (if I remember
correctly S3 SonicVibes cards also requires a big memory chunk for DLS
samples). We can move this module to /alsa-kernel/pci.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
