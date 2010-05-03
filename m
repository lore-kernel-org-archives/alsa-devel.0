From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: asoc: fsl_dma_hw_free being called twice at end of
	playback
Date: Tue, 4 May 2010 07:57:37 +0800
Message-ID: <s2l4f3252891005031657x7ede8598g5f8a921638b1bc97@mail.gmail.com>
References: <4BDF3738.3070900@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by alsa0.perex.cz (Postfix) with ESMTP id CF0B62438F
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 01:57:38 +0200 (CEST)
Received: by pzk40 with SMTP id 40so1453931pzk.23
	for <alsa-devel@alsa-project.org>; Mon, 03 May 2010 16:57:37 -0700 (PDT)
In-Reply-To: <4BDF3738.3070900@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/5/4 Timur Tabi <timur@freescale.com>

> In my 8610 ASoC driver, I'm seeing the DMA driver's .hw_free function being
> called twice whenever playback ends.  I've added some printk's to
> demonstrate:
>
> snd_pcm_common_ioctl1:2543
> snd_pcm_hw_free:543
> soc_pcm_hw_free:761 c023983c
> fsl_dma_hw_free:720 substream=df029d00 dma_private=df440000 stream=0
> snd_pcm_release_substream:2022
> soc_pcm_hw_free:761 c023983c
> fsl_dma_hw_free:720 substream=df029d00 dma_private=df440000 stream=0
> fsl_dma_close:759 substream=df029d00 dma_private=df440000
>
> So the ioctl is being called only once, but the both snd_pcm_hw_free() and
> snd_pcm_release_substream() are calling the .hw_free function.
>
> Is this normal?  I don't know how to handle this, other than to add some
> boolean to my private data structure that indicates whether the resources
> have been freed or not.
>
> --
> Timur Tabi
> Linux kernel developer at Freescale
>

http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch05s06.html#pcm-interface-operators-hw-free-callback

This function is always called before the close callback is called. Also,
the callback may be called multiple times, too. Keep track whether the
resource was already released.
