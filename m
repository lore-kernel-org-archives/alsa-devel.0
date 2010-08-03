From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
 36-bit physical addresses
Date: Wed, 04 Aug 2010 00:34:49 +0100
Message-ID: <1280878489.3112.86.camel@odin>
References: <1280771076-8630-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3177524153
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 01:34:53 +0200 (CEST)
Received: by wwb17 with SMTP id 17so1817837wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 16:34:52 -0700 (PDT)
In-Reply-To: <1280771076-8630-1-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-08-02 at 12:44 -0500, Timur Tabi wrote:
> Update the DMA driver used by the Freescale MPC8610 HPCD audio driver to
> support 36-bit physical addresses, for both DMA buffers and the SSI registers.
> 
> The DMA driver calls snd_dma_alloc_pages() to allocate the DMA buffers for
> playback and capture.  This function is just a front-end for
> dma_alloc_coherent().  Currently, dma_alloc_coherent() only allocates buffers
> in low memory (it ignores GFP_HIGHMEM), so we never actually get a DMA buffer
> with a real 36-bit physical address.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> Liam, this patch should *not* be squashed into the rest of the changes for
> multi-component.
> 
>  sound/soc/fsl/fsl_dma.c |   77 +++++++++++++++++++++++++++++++----------------
>  1 files changed, 51 insertions(+), 26 deletions(-)
> 

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
