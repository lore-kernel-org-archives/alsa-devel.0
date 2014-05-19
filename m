From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: samsung: s3c24{xx,
 12}-i2s: port to use generic dmaengine API
Date: Mon, 19 May 2014 22:34:06 +0200
Message-ID: <537A6ABE.7030304@metafoo.de>
References: <1400519509-5940-1-git-send-email-anarsoul@gmail.com>
 <CA+E=qVdvrp4m2Z8NcSL2p8GKubGEsVLs2baHr24rp-sQmRohUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-079.synserver.de
 [212.40.185.79])
 by alsa0.perex.cz (Postfix) with ESMTP id DDA2F261683
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 22:34:12 +0200 (CEST)
In-Reply-To: <CA+E=qVdvrp4m2Z8NcSL2p8GKubGEsVLs2baHr24rp-sQmRohUQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/19/2014 10:18 PM, Vasily Khoruzhick wrote:
> On Mon, May 19, 2014 at 8:11 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>> Use dmaengine instead of legacy s3c24xx DMA API for s3c24xx and s3c2412
>
> Please discard this series, I'd like to use
> dma_request_slave_channel_compat() to request a dma channel here,
> to simpify migration to DT later.

When you use the generic DMAengine PCM driver, migration to DT essentially 
comes for free, you don't need to do anything special other than not 
specifying the NO_DT flag.

- Lars
