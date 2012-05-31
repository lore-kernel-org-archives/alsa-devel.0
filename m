From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add platform driver
	for ML7213
Date: Thu, 31 May 2012 14:38:30 +0900
Message-ID: <CANKRQni4uqQJ99ycOScHmn-g1kz2_XH7ePL+n1taG5jAbDSubw@mail.gmail.com>
References: <CANKRQnjoGN=uvej8B1BxPHAx7NQtOORD9yJRPUc134DrVmPzNg@mail.gmail.com>
	<20120326154009.GA17506@sirena.org.uk>
	<CANKRQnhn=ALR0ucv5gnvwnxwxBQX4ajm9Jo5qC0fL-EFjDdoZg@mail.gmail.com>
	<20120523093857.GC4085@opensource.wolfsonmicro.com>
	<CANKRQnhNWC2F6zKgBMJY7HnipJbA5p-=6Lz4uGZqBKNQ688Z3w@mail.gmail.com>
	<20120524100742.GH5361@opensource.wolfsonmicro.com>
	<CANKRQnj_LdGQPYPV7d5NNZBx8oM5aAGHu4qZidiiS6C4eNtNJQ@mail.gmail.com>
	<1337941231.1580.19.camel@vkoul-udesk3>
	<20120527221956.GB25019@opensource.wolfsonmicro.com>
	<CANKRQnhwkhGUHi6WQhw-sRJuKari3SLcipCJXVp27OZ29=Vxkw@mail.gmail.com>
	<20120530121449.GI9947@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id E044724396
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 07:38:31 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so1139650pbb.38
	for <alsa-devel@alsa-project.org>; Wed, 30 May 2012 22:38:30 -0700 (PDT)
In-Reply-To: <20120530121449.GI9947@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, lars@metafoo.de, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 30, 2012 at 9:14 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>> >> First you should not be writing your own dma driver, it *needs* to use
>> >> dmaenegine. We already have bunch of driver supported, so there may b=
e a
>> > He's already done that, their current code is all open coded dmaengine
>> > stuff.
>> I don't understand why you say so ?
>> I don't use any own dma driver, right ? I use only dmaengine's.
>> If there is own, let me show.
> Please re-read what I wrote.

Let me clarify.
Do you say native DMA driver API like dmaengine_prep_slave_sg(),
dmaengine_submit() shouldn't be used from ASoC driver, right ?

>> > The existing code is far from nothing, there is a fairly substantial
>> > dmaengine library there already which should share a big chunk of code
>> > with any cyclic support. =A0If you were saying "this is too hard for
>> > $REASON" that'd be one thing but that's not what you're saying here.
>
>> If our ASoC supports cyclic dma mode, we must modify both pch_dma
>> driver and our ASoC driver.
>
> No, all current mainline drivers using the library use cyclic DMA.

I can't see any driver uses cyclic DMA. (I saw linux-next's tree from
kernel.org.)
Where is your saying "current mainline" ?

>> I don't want to do this.
>> Because I can't understand the merit. In plain words, to me, this
>> looks insignificant things.
> The purpose of this change is to factor code out of individual drivers
> into generic code rather than having lots of people writing exactly the
> same code. =A0Code duplication at this level is pointless and makes more
> work for everyone who will have to maintain the code going forward.

I understand your saying "merit".

However I think it seems difficult for supporting all devices.
Because hardware dependency control code can't be added.
For example, for ML7213, needs interrupt control both before/after DMA tran=
sfer.
However,  in case of using soc-dmaengine, the control can't be done.
Because the processing is in soc-dmaengine.

> Having looked at Russell's out of tree code I'm even more convinced that
> the amount of new code needed for non-cyclic DMA should be pretty
> trivial.

I don't know what you are talking about.


thanks.
-- =

ROHM Co., Ltd.
tomoya
