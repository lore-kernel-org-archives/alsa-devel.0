From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Difference between substream->dma_buffer and
	substream->runtime->dma_buffer_p?
Date: Fri, 15 Jun 2007 13:17:16 +0530
Message-ID: <8d6898730706150047m4a8af0abibb4b5e88f3da72cb@mail.gmail.com>
References: <4671C59E.70407@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by alsa0.perex.cz (Postfix) with ESMTP id AB2FD24641
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 09:47:19 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so788672nzf
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2007 00:47:16 -0700 (PDT)
In-Reply-To: <4671C59E.70407@freescale.com>
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
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I think this like static and dynamic allocation of buffers.

if it allocated at device driver insertion time then it stored in
substream entry.

And this can be used by both playback and capture

If it allocated at runtime then it is stored in runtime entry.
And you can have different buffers for both playback and capture.

if no substream is open then runtime structure pointer will be NULL.

Nobin


On 6/15/07, Timur Tabi <timur@freescale.com> wrote:
> The snd_pcm_substream structure has a snd_dma_buffer structure.  snd_dma_buffer looks like
> this:
>
> struct snd_dma_buffer {
>         struct snd_dma_device dev;      /* device type */
>         unsigned char *area;    /* virtual pointer */
>         dma_addr_t addr;        /* physical address */
>         size_t bytes;           /* buffer size in bytes */
>         void *private_data;     /* private for allocator; don't touch */
> };
>
> snd_pcm_substream also has a snd_pcm_runtime structure, which looks like this:
>
> struct snd_pcm_runtime {
> ...
>
>         /* -- DMA -- */
>         unsigned char *dma_area;        /* DMA area */
>         dma_addr_t dma_addr;            /* physical bus address (not accessible from main CPU) */
>         size_t dma_bytes;               /* size of DMA area */
>
>         struct snd_dma_buffer *dma_buffer_p;    /* allocated buffer */
>
>
> Why the redundancy?  Not only does snd_pcm_runtime have dma_area, dma_addr, and dma_bytes,
> but it also has a pointer to a dns_dma_buffer structure, which also has this information!
>
> So given a snd_pcm_substream structure, you can obtain the physical address of the DMA
> buffer three ways:
>
> substream->dma_buffer.addr
> substream->runtime->dma_addr
> substream->runtime->dma_buffer_p->addr
>
> When will these three variable contain different values?  If the answer is never, then why
> do they all exist?
>
> --
> Timur Tabi
> Linux Kernel Developer @ Freescale
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
