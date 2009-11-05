From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 1/7] S3C AUDIO: Rename s3c24xx_pcm prefix
	to	s3c_dma
Date: Thu, 05 Nov 2009 14:03:08 +0900
Message-ID: <4AF25C8C.3020001@samsung.com>
References: <1257384866-18188-1-git-send-email-jassi.brar@samsung.com>
	<4AF24321.7070303@samsung.com>
	<1b68c6790911042016s6993f314x6e2a1c169ba5d437@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C2F3103870
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 06:03:12 +0100 (CET)
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KSM00LOXE18B6@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 05 Nov 2009 14:03:09 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KSM00JE4E188X@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 05 Nov 2009 14:03:08 +0900 (KST)
In-reply-to: <1b68c6790911042016s6993f314x6e2a1c169ba5d437@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On 11/5/2009 1:16 PM, jassi brar wrote:
> On Thu, Nov 5, 2009 at 12:14 PM, Joonyoung Shim <jy0922.shim@samsung.com> wrote:
>> On 11/5/2009 10:34 AM, Jassi Brar wrote:
>>> The s3c24xx_pcm prefix for the soc_platform is inappropriate when
>>> some Samsung SoCs have PCM controllers which will eventually have
>>> drivers and hence namespace ambiguities.
>>>
>>> To resolve naming ambiguities in future the following have been
>>> renamed in order
>>> 1) s3c24xx_pcm_dma_params -> s3c_audio_dma_params
>>> 2) s3c24xx_pcm_preallocate_dma_buffer -> s3c_preallocate_dma_buffer
>>> 3) s3c24xx_pcm_dmamask -> s3c_dmamask
>>> 4) s3c24xx_pcm_XXX -> s3c_dma_XXX
>>>
>> I think that it should have a consistent prefix: s3c_audio_dma_ or
>> other prefix.
> Ideally, Yes.
> but if we try so, we have the following
>  1) s3c24xx_pcm_dma_params -> s3c_dma_dma_params
>  2) s3c24xx_pcm_preallocate_dma_buffer -> s3c_dma_preallocate_dma_buffer
>  3) s3c24xx_pcm_dmamask -> s3c_dma_dmamask
> 
> none of which seem very nice.
> 

You can modify the names for the consistent prefix. If you
use s3c_dma_ prefix, for example, s3c24xx_pcm_dma_params can be to 
s3c_dma_params.

>> BTW, should we keep up s3c prefix? If we will change the prefix now, it
>> is a chance alterable from s3c prefix to other prefix because there is a
>> variety of samsung SoCs unused s3c prefix.
> These patches is not about changing naming conventions. Only changes, necessary
> to have a clean and consistent namespace after integrating PCM driver, have
> been made.

Agree, but you already are changing the prefix from s3c24xx to s3c.

> About changing the s3c prefix is a valid discussion, though.
> 
