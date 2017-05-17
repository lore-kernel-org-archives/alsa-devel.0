From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 2/2] dmaengine: dw: Remove AVR32 bits from
 the driver
Date: Wed, 17 May 2017 11:20:28 +0300
Message-ID: <CAHp75VeF9uJfiBrOAUjEb=FpMT-GStqCHfMo+XwAra+Nd31kOA@mail.gmail.com>
References: <20170509161837.48301-1-andriy.shevchenko@linux.intel.com>
 <20170509161837.48301-3-andriy.shevchenko@linux.intel.com>
 <20170514130457.GK6263@localhost> <1494837791.6967.44.camel@linux.intel.com>
 <20170515144939.GC15061@localhost> <s5hk25i88di.wl-tiwai@suse.de> <20170516042803.GF15061@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170516042803.GF15061@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
List-Id: alsa-devel@alsa-project.org

On Tue, May 16, 2017 at 7:28 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Mon, May 15, 2017 at 05:09:13PM +0200, Takashi Iwai wrote:
>> On Mon, 15 May 2017 16:49:40 +0200,
>> Vinod Koul wrote:

>> > > Sorry, I forgot to mention that it's supposed to go via either tree,
>> > > though together. Since first we remove users of non-standard DMA
>> > > callbacks.
>> >
>> > Okay dropped it, anyway the kbuild complained due to dependency
>> >
>> > SO if you want this to be merged thru sound tree:
>> >
>> > Acked-by: Vinod Koul <vinod.koul@intel.com>
>>
>> OK, I merged two patches in topic/avr32-removal branch.  It's based on
>> 4.12-rc1, so it should be mergeable to your tree cleanly.
>
> Thanks Takashi,
>
> I have pulled and this is also in dmaengine-next now

Thanks, everybody!

-- 
With Best Regards,
Andy Shevchenko
