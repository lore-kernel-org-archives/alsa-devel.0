From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 1/7] S3C AUDIO: Rename s3c24xx_pcm prefix
	to s3c_dma
Date: Thu, 5 Nov 2009 13:16:43 +0900
Message-ID: <1b68c6790911042016s6993f314x6e2a1c169ba5d437@mail.gmail.com>
References: <1257384866-18188-1-git-send-email-jassi.brar@samsung.com>
	<4AF24321.7070303@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DBD6910385C
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 05:16:45 +0100 (CET)
Received: by pwj16 with SMTP id 16so1565375pwj.32
	for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2009 20:16:44 -0800 (PST)
In-Reply-To: <4AF24321.7070303@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 5, 2009 at 12:14 PM, Joonyoung Shim <jy0922.shim@samsung.com> wrote:
> On 11/5/2009 10:34 AM, Jassi Brar wrote:
>> The s3c24xx_pcm prefix for the soc_platform is inappropriate when
>> some Samsung SoCs have PCM controllers which will eventually have
>> drivers and hence namespace ambiguities.
>>
>> To resolve naming ambiguities in future the following have been
>> renamed in order
>> 1) s3c24xx_pcm_dma_params -> s3c_audio_dma_params
>> 2) s3c24xx_pcm_preallocate_dma_buffer -> s3c_preallocate_dma_buffer
>> 3) s3c24xx_pcm_dmamask -> s3c_dmamask
>> 4) s3c24xx_pcm_XXX -> s3c_dma_XXX
>>
>
> I think that it should have a consistent prefix: s3c_audio_dma_ or
> other prefix.
Ideally, Yes.
but if we try so, we have the following
 1) s3c24xx_pcm_dma_params -> s3c_dma_dma_params
 2) s3c24xx_pcm_preallocate_dma_buffer -> s3c_dma_preallocate_dma_buffer
 3) s3c24xx_pcm_dmamask -> s3c_dma_dmamask

none of which seem very nice.

> BTW, should we keep up s3c prefix? If we will change the prefix now, it
> is a chance alterable from s3c prefix to other prefix because there is a
> variety of samsung SoCs unused s3c prefix.
These patches is not about changing naming conventions. Only changes, necessary
to have a clean and consistent namespace after integrating PCM driver, have
been made.
About changing the s3c prefix is a valid discussion, though.
