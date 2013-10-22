From: Nicole Otsuka <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v6] ALSA: Add SoC on-chip internal memory
 support for DMA buffer allocation
Date: Wed, 23 Oct 2013 00:28:35 +0800
Message-ID: <CAGoOwPRUkaxdoRi+xuibB5CMzgFR=YUxExK_5vDiTuUbAh9P8g@mail.gmail.com>
References: <1382410849-11906-1-git-send-email-b42378@freescale.com>
 <52666A30.7030102@metafoo.de>
 <CAGoOwPT19nVQ6KdWYoFv0=Y1RNPtSNCbHf6KC2zefBwB7XpEYg@mail.gmail.com>
 <s5hr4bdo2ue.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 493AC26031E
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2013 18:28:36 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id d7so1371665bkh.26
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2013 09:28:35 -0700 (PDT)
In-Reply-To: <s5hr4bdo2ue.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, broonie@kernel.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 22, 2013 at 9:24 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 22 Oct 2013 20:49:49 +0800,
> Nicole Otsuka wrote:
> >
> > On Tue, Oct 22, 2013 at 8:06 PM, Lars-Peter Clausen <lars@metafoo.de>
> wrote:
> >
> > > On 10/22/2013 05:00 AM, Nicolin Chen wrote:
> > > [...]
> > > > +/**
> > > > + * snd_free_dev_iram - free allocated specific memory from on-chip
> > > internal memory
> > > > + * @dev: DMA device pointer
> > > > + * @size: size in bytes of memory to free
> > > > + * @ptr: cpu-view address returned from snd_malloc_dev_iram
> > > > + *
> > > > + * This function requires iram phandle provided via of_node
> > > > + */
> > > > +void snd_free_dev_iram(struct device *dev, size_t size, void *ptr)
> > > > +{
> > > > +     struct gen_pool *pool = NULL;
> > > > +
> > > > +     if (!dev->of_node)
> > > > +             return;
> > > > +
> > > > +     pool = of_get_named_gen_pool(dev->of_node, "iram", 0);
> > > > +     if (!pool)
> > > > +             return;
> > >
> > > I've had a closer look at the other SNDRV_DMA_TYPE implementations and
> I
> > > think a better way to handle this is to assign the pool to the
> > > snd_dma_buffer's private_data field and then use it here instead of
> looking
> > > the pool up again. This will also make it easier to use a non-OF lookup
> > > scheme.
> > >
> >
> > > By saving the pool to pdata during the allocating? Hmm..that should be
> > nicer.
> > > Just need to change the parameter "struct device *" to "struct gen_pool
> > *" directly
> > > I'll see what I can do to refine it. Thank you for the suggestion.
>
> > I guess Lars meant to use simply snd_dma_buffer.private_data field for
> > storing the pool pointer in snd_malloc_dev_iram(), and use this
> > pointer instead of calling of_get_named_gen_pool() again in
> > snd_free_dev_iram().
>
> Oh, thank you for the explain.
I'll try to refine it tomorrow.

Nicolin Chen

>
> > Takashi
>
