From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH 0/5] PCM mmap (temporary) fixes for
	non-coherent	architectures
Date: Wed, 13 Jan 2010 10:28:25 +0100
Message-ID: <20100113092825.GA15394@rhlx01.hs-esslingen.de>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
	<20100101193130.GA21510@rhlx01.hs-esslingen.de>
	<s5haawj7qlv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 71FBC1037FE
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 10:28:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5haawj7qlv.wl%tiwai@suse.de>
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
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Becky Bruce <beckyb@kernel.crashing.org>, Wu Zhangjin <wuzhangjin@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Andreas Mohr <andi@lisas.de>, Kumar Gala <galak@gate.crashing.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Jan 12, 2010 at 08:02:36AM +0100, Takashi Iwai wrote:
> At Fri, 1 Jan 2010 20:31:30 +0100,
> Andreas Mohr wrote:
> > 
> > Hi,
> > 
> > I've tried this patch set (with the typo-corrected part 4) on my ASUS
> > WL-500gP v2 MIPSEL via a backport to 2.6.31.9, but all I get is a
> > small blip of the sound I wanted to play, and then the system is fubar
> > (I believe just the same thing as what happened without having this patch
> > applied).

Crap, you already managed to beat me to my own reply! ;)
(I'll try your patch in the other mail _ASAP_)

> As I mentioned in the previous followup, if your device is a
> USB-audio, the patch doesn't help because it's for devices with
> buffers using dma_alloc_coherent().  For USB-audio, it uses vmalloc
> for an intermediate buffer.  Maybe this should be changed to dma_*()
> stuff for such architectures.

I've been searching the mailing list postings up and down,
but I couldn't deduce anything to that effect from that content
(but I'm mailing list-externally - maybe I just really didn't find the
correct posting or there was a threading split)

> Nevertheless, I don't know whether the crash is related with the
> audio part...

Yes, I wasn't fully pointing at the crash being caused by insufficient
patches in that area either...
(but I haven't fully investigated these OOPSes yet)

Thanks a lot for your new test patch,

Andreas Mohr
