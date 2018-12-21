From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v3 09/14] ASoC: SOF: Add firmware,
 loader support
Date: Fri, 21 Dec 2018 15:43:16 +0000
Message-ID: <8ce59b64ad855f9b6602318f78b3087f8181fdf2.camel@linux.intel.com>
References: <mailman.3934.1544619824.753.alsa-devel@alsa-project.org>
 <1ce21393-048f-6c04-b899-8cbfbf93983e@linux.intel.com>
 <s5h8t0kobov.wl-tiwai@suse.de>
 <05d38b48-559f-75ce-6299-e1dfd3a62c30@linux.intel.com>
 <f715299c-d610-2dc2-d968-82c4cf75a5ea@linux.intel.com>
 <s5hfturmcc2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hfturmcc2.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Bard liao <yung-chuan.liao@linux.intel.com>
Cc: daniel.baluta@gmail.com, andriy.shevchenko@intel.com, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org, broonie@kernel.org, sound-open-firmware@alsa-project.org, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2018-12-21 at 10:57 +0100, Takashi Iwai wrote:
> On Fri, 21 Dec 2018 10:05:04 +0100,
> Bard liao wrote:
> > 
> > On 12/20/2018 11:07 PM, Pierre-Louis Bossart wrote:
> > > > > > > + snd_sof_dsp_block_write(sdev, offset,
> > > > > > > +                    (void *)block + sizeof(*block),
> > > > > > > +                    block->size);
> > > > > > > +
> > > > > > > +        /* next block */
> > > > > > > +        block = (void *)block + sizeof(*block) + block->size;
> > > > > > This may lead to an unaligned access.
> > > > > Did you mean we should double check the block->size to
> > > > > prevent access to an invalid address?
> > > > You need two types of checks for the given data:
> > > > - The bounce check of block->size;
> > > >    We need to avoid out-of-bounce access.
> > > s/bounce/bounds ?
> > > > - Alignment of block->size;
> > > >    For some non-x86 platforms, the access to an unaligned address might
> > > >    be illegal.
> > > 
> > > Maybe I am missing something but I don't see any sort of explicit
> > > restriction on alignment in the SOF tools. it looks implicit based
> > > on address offsets and bases.
> > 
> > Maybe get_unaligned() is good enough to avoid unaligned access?
> 
> That's another option, but you'd need to put everywhere.
> 
> An alternative is to just copy the data on a new block header on the
> stack temporarily and refer it.
> 
> Or simply assuring the alignment by checking block->size as Pierre
> suggested...

Yep, checking size is good for me too.

> 
> 
> Takashi
> 
> 
> > > Liam, do you see any negative side effects if we enforce a 32-bit
> > > alignment for all blocks (which essentially means all block sizes
> > > are multiple of 4)? we can try and experiment but it's better if we
> > > have an agreement on the design.


This shouldn't cause any problems, iirc all block sizes are rounded up to
nearest uint32_t anyway (as we have exception handler blocks that are 3 bytes of
assembly in size and rounded up to 4).

Liam

> > > 
> > > 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
