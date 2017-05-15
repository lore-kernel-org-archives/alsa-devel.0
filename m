From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/2] dmaengine: dw: Remove AVR32 bits from the driver
Date: Mon, 15 May 2017 11:25:49 +0200
Message-ID: <45cb3a0a-28b5-a64c-90ac-1abf0c59d70f@metafoo.de>
References: <20170509161837.48301-1-andriy.shevchenko@linux.intel.com>
 <20170509161837.48301-3-andriy.shevchenko@linux.intel.com>
 <20170514130457.GK6263@localhost> <1494837791.6967.44.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494837791.6967.44.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, dmaengine@vger.kernel.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: alsa-devel@alsa-project.org

On 05/15/2017 10:43 AM, Andy Shevchenko wrote:
> On Sun, 2017-05-14 at 18:34 +0530, Vinod Koul wrote:
>> On Tue, May 09, 2017 at 07:18:37PM +0300, Andy Shevchenko wrote:
>>> AVR32 is gone. Now it's time to clean up the driver by removing
>>> leftovers that was used by AVR32 related code.
>>
>> Since the cover didn't mention any dependency, I went ahead and
>> applied this
>> now
>>
> 
> Sorry, I forgot to mention that it's supposed to go via either tree,
> though together. Since first we remove users of non-standard DMA
> callbacks.
> 

Since there is no hurry maybe split it over multiple releases. Audio patch
now through the audio tree and once it has made it to a upstream release
apply the DMA patch through the DMA tree.
