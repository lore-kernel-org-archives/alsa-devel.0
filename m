From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 1/7] S3C AUDIO: Rename s3c24xx_pcm prefix
	to	s3c_dma
Date: Thu, 05 Nov 2009 12:14:41 +0900
Message-ID: <4AF24321.7070303@samsung.com>
References: <1257384866-18188-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id A543D103858
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 04:15:24 +0100 (CET)
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KSM00KIZ90HH7@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 05 Nov 2009 12:14:41 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KSM009MJ90HFM@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 05 Nov 2009 12:14:41 +0900 (KST)
In-reply-to: <1257384866-18188-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On 11/5/2009 10:34 AM, Jassi Brar wrote:
> The s3c24xx_pcm prefix for the soc_platform is inappropriate when
> some Samsung SoCs have PCM controllers which will eventually have
> drivers and hence namespace ambiguities.
> 
> To resolve naming ambiguities in future the following have been
> renamed in order
> 1) s3c24xx_pcm_dma_params -> s3c_audio_dma_params
> 2) s3c24xx_pcm_preallocate_dma_buffer -> s3c_preallocate_dma_buffer
> 3) s3c24xx_pcm_dmamask -> s3c_dmamask
> 4) s3c24xx_pcm_XXX -> s3c_dma_XXX
> 

I think that it should have a consistent prefix: s3c_audio_dma_ or
other prefix.

BTW, should we keep up s3c prefix? If we will change the prefix now, it
is a chance alterable from s3c prefix to other prefix because there is a
variety of samsung SoCs unused s3c prefix.
