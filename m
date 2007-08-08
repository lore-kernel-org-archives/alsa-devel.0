From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: ALSA on MIPS platform
Date: Wed, 8 Aug 2007 13:40:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0708081302350.25542@blysk.ds.pg.gda.pl>
References: <46B332AC.8020403@lemote.com> <5861a7880708062253x7133659cm1ff17f451e4f82f8@mail.gmail.com>
 <5861a7880708062317t21970c81w3f16580858bf50af@mail.gmail.com>
 <20070807.230157.59463765.anemo@mba.ocn.ne.jp> <20070807175402.GA24731@linux-mips.org>
 <s5hlkcnmbll.wl%tiwai@suse.de> <20070808115852.GA6700@linux-mips.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20070808115852.GA6700@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Takashi Iwai <tiwai@suse.de>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, jiankemeng@gmail.com, tiansm@lemote.com, linux-mips@linux-mips.org, alsa-devel@alsa-project.org, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

On Wed, 8 Aug 2007, Ralf Baechle wrote:

> > Yep, but OTOH, the arch code doesn't provide a proper standard way to
> > mmap the pages allocated via dma_alloc_coherent().  That's the missing
> > piece, especially on mips and sparc.  ARM has already one.
> > 
> > My wish is implementing dma_mmap_coherent() on all architectures, so
> > that the driver can use it safely without messy ifdefs.
> 
> Adding dma_mmap_coherent has been proposed in 2004 but the discussion for
> some reason went nowhere because it apparently isn't implementable on
> PARISC due to cache synonyms - on MIPS we'd solve those issues where they
> exist by using uncached or writethrough mappings, as apropriate.

 Hmm, why should everybody suffer from some limitation of some peculiar 
architecture?  I would suggest to let them find an architecture-specific 
way of addressing the problem -- they surely have a good control over 
their own code and can implement a workaround that would not impede all 
the others.

 Ralf, do you have an idea about what their issue exactly is?

  Maciej
