From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 27/27] sound: ppc: remove unneeded memset after
 dma_alloc_coherent
Date: Fri, 28 Jun 2019 10:59:51 +0200
Message-ID: <83108dee-72f7-e56f-95f6-26162c9a0ccc@c-s.fr>
References: <20190628025055.16242-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190628025055.16242-1-huangfq.daxian@gmail.com>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Richard Fontana <rfontana@redhat.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Allison Randal <allison@lohutok.net>
List-Id: alsa-devel@alsa-project.org



Le 28/06/2019 à 04:50, Fuqian Huang a écrit :
> In commit af7ddd8a627c
> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
> dma_alloc_coherent has already zeroed the memory.
> So memset is not needed.

You are refering to a merge commit, is that correct ?

I can't see anything related in that commit, can you please pinpoint it ?

As far as I can see, on powerpc the memory has always been zeroized 
(since 2005 at least).

Christophe

> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>   sound/ppc/pmac.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
> index 1b11e53f6a62..1ab12f4f8631 100644
> --- a/sound/ppc/pmac.c
> +++ b/sound/ppc/pmac.c
> @@ -56,7 +56,6 @@ static int snd_pmac_dbdma_alloc(struct snd_pmac *chip, struct pmac_dbdma *rec, i
>   	if (rec->space == NULL)
>   		return -ENOMEM;
>   	rec->size = size;
> -	memset(rec->space, 0, rsize);
>   	rec->cmds = (void __iomem *)DBDMA_ALIGN(rec->space);
>   	rec->addr = rec->dma_base + (unsigned long)((char *)rec->cmds - (char *)rec->space);
>   
> 
