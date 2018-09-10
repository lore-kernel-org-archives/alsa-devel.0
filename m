From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ASoC: pxa: remove duplicated
	snd_soc_component_driver ops
Date: Mon, 10 Sep 2018 20:55:06 +0200
Message-ID: <87bm955gj9.fsf@belgarion.home>
References: <5110d62c9a1d266da0675cd11f196adad4b12cec.1536006242.git.petrcvekcz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr
 [80.12.242.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 17AB82676EB
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 20:55:10 +0200 (CEST)
In-Reply-To: <5110d62c9a1d266da0675cd11f196adad4b12cec.1536006242.git.petrcvekcz@gmail.com>
 (petrcvekcz@gmail.com's message of "Mon, 3 Sep 2018 22:25:01 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: petrcvekcz@gmail.com
Cc: alsa-devel@alsa-project.org, dbaryshkov@gmail.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, dirk@opfer-online.de, marek.vasut@gmail.com, zhouqiao@marvell.com, broonie@kernel.org, philipp.zabel@gmail.com, lost.distance@yahoo.com, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

petrcvekcz@gmail.com writes:

> From: Petr Cvek <petrcvekcz@gmail.com>
>
> The sound soc drivers which are using a platform driver pxa-pcm-audio and
> cpu dai drivers from the pxa tree have defined pxa2xx_soc_pcm_new() twice.
> The function will get called in soc_new_pcm() for two components (platform
> and cpu dai) which causes a double allocation of DMA resources and later
> during a close of the playback/capture a kernel warning:
>
>  WARNING: CPU: 0 PID: 892 at drivers/dma/dmaengine.c:788 dma_release_channel+0x44/0xa0
>  chan reference count 0 != 1
>  Modules linked in: snd_soc_magician snd_soc_pxa2xx snd_pxa2xx_lib ...
>  CPU: 0 PID: 892 Comm: aplay Tainted: G C 4.18.0-rc6-next-20180726-magician+ #16
>  Hardware name: HTC Magician
>  [<c0107d90>] (unwind_backtrace) from [<c010594c>] (show_stack+0x10/0x14)
>  [<c010594c>] (show_stack) from [<c0111680>] (__warn+0xd4/0xec)
>  [<c0111680>] (__warn) from [<c01112d0>] (warn_slowpath_fmt+0x44/0x6c)
>  [<c01112d0>] (warn_slowpath_fmt) from [<c034908c>] (dma_release_channel+0x44/0xa0)
>  [<c034908c>] (dma_release_channel) from [<bf330528>] (snd_dmaengine_pcm_close_release_chan+0x44/0xb1c [snd_pcm_dmaengine])
>  [<bf330528>] (snd_dmaengine_pcm_close_release_chan [snd_pcm_dmaengine]) from [<bf26c29c>] (soc_pcm_components_close+0x8c/0xac [snd_soc_core])
>  [<bf26c29c>] (soc_pcm_components_close [snd_soc_core]) from [<bf26c3a0>] (soc_pcm_close+0xe4/0xd44 [snd_soc_core])
>  [<bf26c3a0>] (soc_pcm_close [snd_soc_core]) from [<bf167254>] (snd_pcm_release_substream+0x88/0x108 [snd_pcm])
>  [<bf167254>] (snd_pcm_release_substream [snd_pcm]) from [<bf167330>] (snd_pcm_release+0x5c/0xd2c [snd_pcm])
>  [<bf167330>] (snd_pcm_release [snd_pcm]) from [<c01c39e4>] (__fput+0xdc/0x1e8)
>  [<c01c39e4>] (__fput) from [<c0129e7c>] (task_work_run+0xc4/0xd4)
>  [<c0129e7c>] (task_work_run) from [<c01053ac>] (do_work_pending+0xc0/0xc8)
>  [<c01053ac>] (do_work_pending) from [<c0101068>] (slow_work_pending+0xc/0x20)
>  Exception stack(0xc2fdffb0 to 0xc2fdfff8)
>  ffa0:                                     00000000 0154d1a0 01542a3c 00000000
>  ffc0: 0154d150 00000000 0009283c 00000006 000003f0 0154d4c8 00000000 0154d4c8
>  ffe0: b6ee7d70 bef13960 b6e547b8 b6cfe018 60000010 00000004
>
> The problem was found for cpu dai drivers: pxa-i2s and pxa-ssp and by
> a calltrace sent from Robert Jarzmik on pxa-ac97 (although there was no
> observed kernel warning). The git grep shows these 3 cpu dai drivers are
> the only one which assign the .pcm_new to pxa2xx_soc_pcm_new() and almost
> every machine which is using one of these cpu dai drivers is using the
> platform driver pxa-pcm-audio too. The only exception is TTC_DKB board
> which is using a platform driver mmp-pcm-audio. A quick look in the code
> of mmp-pcm-audio shows it allocates the DMA in the similar way as PXA.
>
> The solution is to remove one of pxa2xx_soc_pcm_new() assignments and the
> patch does it for 3 cpu dai drivers (SSP/I2S/AC97).
>
> The result was tested on HTC Magician board (SSP for playback, I2S for
> capture) and the DMA buffers are correctly allocated.
>
> Signed-off-by: Petr Cvek <petrcvekcz@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
