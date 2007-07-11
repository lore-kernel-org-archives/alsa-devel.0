From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Can I mmap buffer allocated using
	SNDRV_DMA_TYPE_CONTINUOUS?
Date: Wed, 11 Jul 2007 18:17:49 +0530
Message-ID: <61445c750707110547y2fe7528fg40c45090db859d1f@mail.gmail.com>
References: <61445c750707110543w4cecbb1bk73515b9086c347a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BBAD103916
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 14:47:51 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2159070wag
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 05:47:49 -0700 (PDT)
In-Reply-To: <61445c750707110543w4cecbb1bk73515b9086c347a6@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/11/07, Pharaoh . <pharaoh137@gmail.com> wrote:
>
> Hi,
> I have allocated the DMA buffer using snd_pcm_lib_malloc_pages() and
> it was preallocated as:
>
> snd_pcm_lib_preallocate_pages_for_all(pcm,
>                                              SNDRV_DMA_TYPE_CONTINUOUS,
>                                              snd_dma_continuous_data
>                                              (GFP_KERNEL),
>                                              128 * 1024, 128 * 1024);
>
> Can I mmap such a dma buffer? I think yes...
>
> -pharaoh.
>


I dont think it can be mmapped.
-pharaoh.
