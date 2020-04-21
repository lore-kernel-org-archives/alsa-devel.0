Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2901C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 06:07:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255272076C
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 06:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dImtwe5a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="meeAYjLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255272076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 762A1168C;
	Tue, 21 Apr 2020 08:06:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 762A1168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587449254;
	bh=0XrbedQXm6WV8t/yz8p39cq6YexlQte82FD5QA1NeKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dImtwe5aIVkhPTFwcHXHSyQZNRzMwABS+/IABU/wuvSKPU23dAYqIPiaChEcAaX8t
	 h3+VMIviA4jMtHdXphjjm4ecZDtXoKemlgwU+D0GNMu5wnzjEZEieMKsH89P55Uhk/
	 hhds0Ioq1NohE+TOj5Oe14KODFkyAv27cebDaXcI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4094DF8028F;
	Tue, 21 Apr 2020 08:04:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 12819F801D9; Tue, 21 Apr 2020 02:49:45 +0200 (CEST)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6E20F800C8
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2020 02:49:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6E20F800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au
 header.b="meeAYjLZ"
Received: by mail-ed1-x542.google.com with SMTP id j20so8985049edj.0
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 17:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wJHlw0Va8nRu1bocL0iGdefgbBDvsiBEjRNcEzF2emU=;
 b=meeAYjLZhNhYpKBnFQIRY8QNiqkTLOGzc2f5eEof1vaJQqZnU3xO9BHaM0ZTWqz18H
 7JdM/LuAS1FxwOG+U10a3oGmldXeSsYkdnMVfzGPyQiNrW5OHAnV4Q5byiDuVeQsbNl1
 E333eMFKt3b2MoMegW3BJnD5V/q7diY8XYF6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wJHlw0Va8nRu1bocL0iGdefgbBDvsiBEjRNcEzF2emU=;
 b=W7DkZ7a2ExgRlh+LmW+pw6dmxEWMX4AFzWmWxqOc2/07DGAqFgG8Q0nnWAxf4vxb/l
 rG2d8U8af1LCzmNhoXDDh1/guP0/ZOvz9IBnUTs4seemmmx9fhDkiWXSDRdIjloRra7G
 ece3DhLNNcjTRjZPqqNtN/NIXaiXC8seDTHV9fw+qkNTUqxJ3xcWQryD+d7Dvi8twy3r
 Ts5N1o46TFfAXMB+5n3x1AbzIjxqTLoQCCmtJEy539hb45YOdFm92sRwzJRfvxD1CdzJ
 6NiMoJAN1gKuTRtTYqth1vkX5D1XQeM+PinQZEMp8S2zV0PFsETOLmlOXtDN+dqNNIj5
 YLIg==
X-Gm-Message-State: AGi0PuatdzP0cxRWSgWE2E75xR0NGCzqplPJaj42IVsQpK1nxj7OEYyV
 7JcnAvEPx3J3C+ql8Rjni9X7RcJAIRT1BHGxGwY=
X-Google-Smtp-Source: APiQypI1EAeVQeoUmWxrcddmzILwfd83lCEKJEUjqchmR0ZO8JH1LNOiAonElPJJKLVzNuxsgOg9s5aCArGIIeHtz4k=
X-Received: by 2002:a50:cd17:: with SMTP id z23mr16344581edi.191.1587430175724; 
 Mon, 20 Apr 2020 17:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <a5945463f86c984151962a475a3ee56a2893e85d.1587407777.git.christophe.leroy@c-s.fr>
In-Reply-To: <a5945463f86c984151962a475a3ee56a2893e85d.1587407777.git.christophe.leroy@c-s.fr>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 21 Apr 2020 00:49:23 +0000
Message-ID: <CACPK8XdzLiUkzp-B3DuwxVHgn-hZqKypoyU_PLtE5d0K=B1mXQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] drivers/powerpc: Replace _ALIGN_UP() by ALIGN()
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 21 Apr 2020 08:04:34 +0200
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, Paul Mackerras <paulus@samba.org>,
 linux-fbdev@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, 20 Apr 2020 at 18:37, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>
> _ALIGN_UP() is specific to powerpc
> ALIGN() is generic and does the same
>
> Replace _ALIGN_UP() by ALIGN()
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

I was curious, so I expanded out the kernel one. Here's the diff:

- (((addr)+((size)-1))&(~((typeof(addr))(size)-1)))
+ (((addr)+((typeof(addr))(size) - 1))&~((typeof(addr))(size)-1))

So it adds a cast, but aside from that it's the same.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/ps3/ps3-lpm.c               | 6 +++---
>  drivers/vfio/pci/vfio_pci_nvlink2.c | 2 +-
>  drivers/video/fbdev/ps3fb.c         | 4 ++--
>  sound/ppc/snd_ps3.c                 | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/ps3/ps3-lpm.c b/drivers/ps3/ps3-lpm.c
> index 83c45659bc9d..064b5884ba13 100644
> --- a/drivers/ps3/ps3-lpm.c
> +++ b/drivers/ps3/ps3-lpm.c
> @@ -1096,8 +1096,8 @@ int ps3_lpm_open(enum ps3_lpm_tb_type tb_type, void *tb_cache,
>                 lpm_priv->tb_cache_internal = NULL;
>                 lpm_priv->tb_cache = NULL;
>         } else if (tb_cache) {
> -               if (tb_cache != (void *)_ALIGN_UP((unsigned long)tb_cache, 128)
> -                       || tb_cache_size != _ALIGN_UP(tb_cache_size, 128)) {
> +               if (tb_cache != (void *)ALIGN((unsigned long)tb_cache, 128)
> +                       || tb_cache_size != ALIGN(tb_cache_size, 128)) {
>                         dev_err(sbd_core(), "%s:%u: unaligned tb_cache\n",
>                                 __func__, __LINE__);
>                         result = -EINVAL;
> @@ -1116,7 +1116,7 @@ int ps3_lpm_open(enum ps3_lpm_tb_type tb_type, void *tb_cache,
>                         result = -ENOMEM;
>                         goto fail_malloc;
>                 }
> -               lpm_priv->tb_cache = (void *)_ALIGN_UP(
> +               lpm_priv->tb_cache = (void *)ALIGN(
>                         (unsigned long)lpm_priv->tb_cache_internal, 128);
>         }
>
> diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
> index ed20d73cc27c..65c61710c0e9 100644
> --- a/drivers/vfio/pci/vfio_pci_nvlink2.c
> +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> @@ -67,7 +67,7 @@ static size_t vfio_pci_nvgpu_rw(struct vfio_pci_device *vdev,
>          *
>          * This is not fast path anyway.
>          */
> -       sizealigned = _ALIGN_UP(posoff + count, PAGE_SIZE);
> +       sizealigned = ALIGN(posoff + count, PAGE_SIZE);
>         ptr = ioremap_cache(data->gpu_hpa + posaligned, sizealigned);
>         if (!ptr)
>                 return -EFAULT;
> diff --git a/drivers/video/fbdev/ps3fb.c b/drivers/video/fbdev/ps3fb.c
> index 834f63edf700..9df78fb77267 100644
> --- a/drivers/video/fbdev/ps3fb.c
> +++ b/drivers/video/fbdev/ps3fb.c
> @@ -44,7 +44,7 @@
>  #define GPU_CMD_BUF_SIZE                       (2 * 1024 * 1024)
>  #define GPU_FB_START                           (64 * 1024)
>  #define GPU_IOIF                               (0x0d000000UL)
> -#define GPU_ALIGN_UP(x)                                _ALIGN_UP((x), 64)
> +#define GPU_ALIGN_UP(x)                                ALIGN((x), 64)
>  #define GPU_MAX_LINE_LENGTH                    (65536 - 64)
>
>  #define GPU_INTR_STATUS_VSYNC_0                        0       /* vsync on head A */
> @@ -1015,7 +1015,7 @@ static int ps3fb_probe(struct ps3_system_bus_device *dev)
>         }
>  #endif
>
> -       max_ps3fb_size = _ALIGN_UP(GPU_IOIF, 256*1024*1024) - GPU_IOIF;
> +       max_ps3fb_size = ALIGN(GPU_IOIF, 256*1024*1024) - GPU_IOIF;
>         if (ps3fb_videomemory.size > max_ps3fb_size) {
>                 dev_info(&dev->core, "Limiting ps3fb mem size to %lu bytes\n",
>                          max_ps3fb_size);
> diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
> index 6d2a33b8faa0..b8161a08f2ca 100644
> --- a/sound/ppc/snd_ps3.c
> +++ b/sound/ppc/snd_ps3.c
> @@ -926,7 +926,7 @@ static int snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
>                             PAGE_SHIFT, /* use system page size */
>                             0, /* dma type; not used */
>                             NULL,
> -                           _ALIGN_UP(SND_PS3_DMA_REGION_SIZE, PAGE_SIZE));
> +                           ALIGN(SND_PS3_DMA_REGION_SIZE, PAGE_SIZE));
>         dev->d_region->ioid = PS3_AUDIO_IOID;
>
>         ret = ps3_dma_region_create(dev->d_region);
> --
> 2.25.0
>
