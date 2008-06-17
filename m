From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA 1.0.17rc2 release
Date: Tue, 17 Jun 2008 14:12:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806171411290.1798@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0806161121530.1798@tm8103-a.perex-int.cz>
	<200806171018.52879.gineera@aspect135.co.uk>
	<200806171116.27558.gineera@aspect135.co.uk>
	<Pine.LNX.4.61.0806171341290.1798@tm8103-a.perex-int.cz>
	<s5hfxrc9t98.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BE1224361
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 14:12:09 +0200 (CEST)
In-Reply-To: <s5hfxrc9t98.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 17 Jun 2008, Takashi Iwai wrote:

> At Tue, 17 Jun 2008 13:42:40 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Tue, 17 Jun 2008, Alan Horstmann wrote:
> > 
> > > I have just confirmed that pasting
> > > 
> > > 	#define GFP_DMA32	((__force gfp_t)0x04u)
> > > 
> > > into /alsa-kernel/pci/emu10k1/memory.c (not a correct fix -just taken from 
> > > 2.6.24 headers) enables build to complete.  So there should be no other 
> > > hidden issues.
> > 
> > Could you try attached patch (also pasted bellow)?
> 
> That's too overhead.  A simple #ifndef GFP_DMA32 would work.
> And, GFP_DMA32 isn't GFP_DMA.

But old kernels with dma_mask < 0xffffffff sets GFP_DMA flag for page 
allocation. So there's no regression.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
