From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 1/7] S3C AUDIO: Rename s3c24xx_pcm prefix
	to	s3c_dma
Date: Mon, 09 Nov 2009 14:14:16 +0900
Message-ID: <4AF7A528.3080602@samsung.com>
References: <1257384866-18188-1-git-send-email-jassi.brar@samsung.com>
	<4AF24321.7070303@samsung.com>
	<1b68c6790911042016s6993f314x6e2a1c169ba5d437@mail.gmail.com>
	<4AF25C8C.3020001@samsung.com> <20091106162322.GD4938@sirena.org.uk>
	<1b68c6790911061946w6cf04e4cv30f790470c20cba4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E0B310382D
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 06:14:41 +0100 (CET)
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KST00IBOT7RVE@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 09 Nov 2009 14:14:16 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KST006DCT7SP5@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 09 Nov 2009 14:14:16 +0900 (KST)
In-reply-to: <1b68c6790911061946w6cf04e4cv30f790470c20cba4@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On 11/7/2009 12:46 PM, jassi brar wrote:
>> On Thu, Nov 05, 2009 at 02:03:08PM +0900, Joonyoung Shim wrote:
>>> On 11/5/2009 1:16 PM, jassi brar wrote:
> On Sat, Nov 7, 2009 at 1:23 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>>>> These patches is not about changing naming conventions. Only changes, necessary
>>>> to have a clean and consistent namespace after integrating PCM driver, have
>>>> been made.
>>> Agree, but you already are changing the prefix from s3c24xx to s3c.
>> I also agree with this - if we're renaming this driver anyway then
>> changing the prefix for it while we're at it seems reasonable, it means
>> one less change in the future.
> renaming is a box of worms which i dont wanna be the first to open.
> I would wait for a complete discussion on the naming conventions to happen
> and have a decision made before I do renaming.
> Though, I can resend the patch with samsung_ prefix too, if everyone
> is willing to
> hold their peace forever.
> 
>>>> but if we try so, we have the following
>>>>  1) s3c24xx_pcm_dma_params -> s3c_dma_dma_params
>>>>  2) s3c24xx_pcm_preallocate_dma_buffer -> s3c_dma_preallocate_dma_buffer
>>>>  3) s3c24xx_pcm_dmamask -> s3c_dma_dmamask
>>>> none of which seem very nice.
>>> You can modify the names for the consistent prefix. If you
>>> use s3c_dma_ prefix, for example, s3c24xx_pcm_dma_params can be to
>>> s3c_dma_params.
>> I tend to agree with this.  The actual rename needs to happen to free up
>> the PCM name for the driver for the PCM hardware.
> 
> So taking into account the aforementioned point as well, you suggest
> 1) s3c24xx_pcm_dma_params -> samsung_dma_params
> 2) s3c24xx_pcm_preallocate_dma_buffer -> samsung_preallocate_dma_buffer
> 3) s3c24xx_pcm_dmamask -> samsung_dmamask
> 4) s3c24xx_pcm_XXX -> samsung_dma_XXX
> 

Hmm, i was missing about the DMA on the prior mail. We should consider
the DMA with this. The DMA chip(PL330) of s5p CPUs differs with s3c
CPUs. We first should desided whether use the existing DMA interface of
s3c. If we use it, this prefix is better samsung than s3c.

The other option is using the DMA subsystem about s5p DMA. This need
also implementing ASoC platform driver of s5p for DMA, so it is better
two each different prefix than samsung. I have posted the s5p DMA driver
using the DMA subsystem.
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-September/000810.html
