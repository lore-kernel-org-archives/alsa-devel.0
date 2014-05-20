From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: samsung: s3c24{xx,
 12}-i2s: port to use generic dmaengine API
Date: Tue, 20 May 2014 11:31:34 +0200
Message-ID: <537B20F6.1010108@metafoo.de>
References: <1400519509-5940-1-git-send-email-anarsoul@gmail.com>
 <CA+E=qVdvrp4m2Z8NcSL2p8GKubGEsVLs2baHr24rp-sQmRohUQ@mail.gmail.com>
 <537A6ABE.7030304@metafoo.de>
 <CA+E=qVddxDAZ6Fkx5aBy1AL7xbpe64Yet4utTqfsSScQUxpXLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-128.synserver.de
 [212.40.185.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 78F25265007
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 11:31:52 +0200 (CEST)
In-Reply-To: <CA+E=qVddxDAZ6Fkx5aBy1AL7xbpe64Yet4utTqfsSScQUxpXLA@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 05/20/2014 11:25 AM, Vasily Khoruzhick wrote:
> On Mon, May 19, 2014 at 11:34 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 05/19/2014 10:18 PM, Vasily Khoruzhick wrote:
>>>
>>> On Mon, May 19, 2014 at 8:11 PM, Vasily Khoruzhick <anarsoul@gmail.com>
>>> wrote:
>>>>
>>>> Use dmaengine instead of legacy s3c24xx DMA API for s3c24xx and s3c2412
>>>
>>>
>>> Please discard this series, I'd like to use
>>> dma_request_slave_channel_compat() to request a dma channel here,
>>> to simpify migration to DT later.
>>
>>
>> When you use the generic DMAengine PCM driver, migration to DT essentially
>> comes for free, you don't need to do anything special other than not
>> specifying the NO_DT flag.
>>
>> - Lars
>
> Hi Lars, all,
>
> But how do I have to pass DMA channel number for non-DT boot? I've
> seen that s3c64xx uses DMA resources at least for I2S and SPI,
> but Arnd suggested to use platform data. What's preffered way?

I don't think it matters, both isn't really that nice, but we currently do 
not have a nice way to specify the DMA channel on non-DT platforms. What's 
missing the a equivalent of the GPIO descriptor lookup tables, but for DMA 
channels.

- Lars
