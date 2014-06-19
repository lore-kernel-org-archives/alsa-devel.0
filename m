From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/5] ASoC: rcar: Fix dma direction type
Date: Thu, 19 Jun 2014 11:24:57 +0200
Message-ID: <53A2AC69.6080508@metafoo.de>
References: <1403163631-26215-1-git-send-email-lars@metafoo.de>
 <1403163631-26215-5-git-send-email-lars@metafoo.de>
 <87wqcdntzh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-101.synserver.de (smtp-out-101.synserver.de
 [212.40.185.101])
 by alsa0.perex.cz (Postfix) with ESMTP id B6381261A9B
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 11:25:05 +0200 (CEST)
In-Reply-To: <87wqcdntzh.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 06/19/2014 11:12 AM, Kuninori Morimoto wrote:
>
> Hi Lars
>
>> dmaengine_prep_slave_single() expects a enum dma_transfer_direction and not a
>> enum dma_data_direction. Since the integer representations of both DMA_TO_DEVICE
>> and DMA_MEM_TO_DEV aswell as DMA_FROM_DEVICE and DMA_DEV_TO_MEM have the same
>> value the code worked fine even though it was using the wrong type.
>>
>> Fixes the following warning from sparse:
>> 	sound/soc/sh/rcar/core.c:227:49: warning: mixing different enum types
>> 	sound/soc/sh/rcar/core.c:227:49:     int enum dma_data_direction  versus
>> 	sound/soc/sh/rcar/core.c:227:49:     int enum dma_transfer_direction
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Actually, ${LINUX}/sound/soc/sh/fsi.c :: fsi_dma_transfer()
> is using enum dma_data_direction to dmaengine_prep_dma_cyclic()
> Does it have same issue ?

Yes, but the fix for that should go in after your "ASoC: fsi: use 
SNDRV_DMA_TYPE_DEV for sound buffer" patch, because otherwise the fix just 
introduces a new warning because before that patch dir is also passed to 
dma_sync_single_xxx() which wants a enum dma_data_direction.

- Lars
