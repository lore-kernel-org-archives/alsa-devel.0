From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Can I mmap buffer allocated using
	SNDRV_DMA_TYPE_CONTINUOUS?
Date: Thu, 12 Jul 2007 19:49:47 +0530
Message-ID: <61445c750707120719g2d68ffc6q521a58ce593cdd5b@mail.gmail.com>
References: <61445c750707110543w4cecbb1bk73515b9086c347a6@mail.gmail.com>
	<61445c750707110547y2fe7528fg40c45090db859d1f@mail.gmail.com>
	<s5hd4yxn39t.wl%tiwai@suse.de>
	<61445c750707120654t79df3fcfhd5ced09a81f624c@mail.gmail.com>
	<s5hps2x208g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 872AC103827
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2007 16:19:48 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so190493wag
	for <alsa-devel@alsa-project.org>; Thu, 12 Jul 2007 07:19:47 -0700 (PDT)
In-Reply-To: <s5hps2x208g.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Okay got it...I am currently using the mmap APIs given in
arm/mm/consistant.c and they seem to work as expected. Basically I am
not preallocating using ALSA provided API, rather I am using dma
allocation functions given in the same file and the buffer mmaps well.

-pharaoh.

On 7/12/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 12 Jul 2007 19:24:24 +0530,
> Pharaoh . wrote:
> >
> > okay, I am on ARM..so better I do not use preallocation scheme with
> > CONTINUOUS flag in case I want to mmap my dma buffer. In fact, I tried
> > mmaping it, but it didn't work as expected.
>
> On ARM, the mmap support is a bit tricky, so far.
> The preallocation itself should work with SNDRV_DMA_TYPE_TYPE_DEV.
> But you'd need the mmap PCM ops to call dma_mmap_coherent() there
> instead of the default ALSA mmap handler.
>
>
> Takashi
>
> >
> > On 7/12/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Wed, 11 Jul 2007 18:17:49 +0530,
> > > Pharaoh . wrote:
> > > >
> > > > On 7/11/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> > > > >
> > > > > Hi,
> > > > > I have allocated the DMA buffer using snd_pcm_lib_malloc_pages() and
> > > > > it was preallocated as:
> > > > >
> > > > > snd_pcm_lib_preallocate_pages_for_all(pcm,
> > > > >
> SNDRV_DMA_TYPE_CONTINUOUS,
> > > > >                                              snd_dma_continuous_data
> > > > >                                              (GFP_KERNEL),
> > > > >                                              128 * 1024, 128 *
> 1024);
> > > > >
> > > > > Can I mmap such a dma buffer? I think yes...
> > > > >
> > > > > -pharaoh.
> > > > >
> > > >
> > > >
> > > > I dont think it can be mmapped.
> > >
> > > It can be basically, but not on all architectures.
> > > For example, ARM has a problem with coherency.
> > >
> > >
> > > Takashi
> > >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
