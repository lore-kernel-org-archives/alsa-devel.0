From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] asoc/multi-component: fsl: fix exit and
 error paths in DMA and SSI drivers
Date: Wed, 04 Aug 2010 00:35:09 +0100
Message-ID: <1280878509.3112.87.camel@odin>
References: <1280876128-19263-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 6C9BE24154
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 01:35:12 +0200 (CEST)
Received: by wyb42 with SMTP id 42so4824589wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 16:35:12 -0700 (PDT)
In-Reply-To: <1280876128-19263-1-git-send-email-timur@freescale.com>
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

On Tue, 2010-08-03 at 17:55 -0500, Timur Tabi wrote:
> The error handling code in the OF probe function of the SSI driver is not
> freeing all resources correctly.
> 
> Since the machine driver no longer calls the DMA driver to provide information
> about the SSI, we don't need to keep a list of DMA objects any more.  In
> addition, the fsl_soc_dma_remove() function is incorrectly removing *all*
> DMA objects when it should only remove one.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  sound/soc/fsl/fsl_dma.c |   23 +++++++----------------
>  sound/soc/fsl/fsl_ssi.c |   29 ++++++++++++++++-------------
>  2 files changed, 23 insertions(+), 29 deletions(-)
> 

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
