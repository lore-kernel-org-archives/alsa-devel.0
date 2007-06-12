From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: snd_pcm_lib_malloc_pages()
Date: Tue, 12 Jun 2007 11:41:50 +0530
Message-ID: <8d6898730706112311n30e8b772xc319516f31cf4e3f@mail.gmail.com>
References: <46688D51.8030407@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by alsa0.perex.cz (Postfix) with ESMTP id BF61810382A
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 08:11:51 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1387782nzf
	for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2007 23:11:50 -0700 (PDT)
In-Reply-To: <46688D51.8030407@freescale.com>
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

In the new patch 13.4 see the implementation of imx it uses
use snd_pcm_lib_malloc_pages()

http://opensource.wolfsonmicro.com/~lg/asoc/

patch version 13.4

On 6/8/07, Timur Tabi <timur@freescale.com> wrote:
> Liam
>
> Why do none of the ASoC drivers use snd_pcm_lib_malloc_pages()?  They all allocate their
> DMA buffers by hand.
>
> --
> Timur Tabi
> Linux Kernel Developer @ Freescale
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
