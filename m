From: "Porter, Matt" <mporter@ti.com>
Subject: Re: [alsa-devel] DT support for Davinci ASoC platform
Date: Wed, 8 Aug 2012 14:48:19 +0000
Message-ID: <7AF83341-20F2-4714-A4BB-8A2D4D7238F5@ti.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA35352@DBDE01.ent.ti.com>
 <4FF5733E.6000604@gmail.com> <501AE3C6.8040708@gmail.com>
 <501B954C.3070606@ti.com> <50226B65.4090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50226B65.4090804@gmail.com>
Content-Language: en-US
Content-ID: <C687D38767067845B8E6116B225CB18E@owa.mail.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
 Sudhakar" <sudhakar.raj@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Nori, Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "Girdwood,
 Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


On Aug 8, 2012, at 9:36 AM, Daniel Mack wrote:

> Hi Serkar,
> 
> On 03.08.2012 11:09, Sekhar Nori wrote:
>> On 8/3/2012 2:02 AM, Daniel Mack wrote:
>>> On 05.07.2012 12:58, Daniel Mack wrote:
>>>> Hi Gururaja,
>>>> 
>>>> On 04.07.2012 14:48, Hebbar, Gururaja wrote:
>>>>> All,
>>>>> 
>>>>> Are there any plans or work going on for providing Device Tree Support for Davinci
>>>>> ASoC?
>>>>> 
>>>>> I am planning to add DT support for TI AM335x (McASP) and I don't want to do duplicate
>>>>> task.
>>>> 
>>>> That's good to know. But isn't there a dependency on the EDMA engine? Is
>>>> that part ported yet?
>>> 
>>> May I ask whether you made any progress on that yet?
>> 
>> Matt Porter from TI is working on DMA engine migration. This would still
>> be some time away since there is a bunch of work involved here.
>> 
>> To make progress on Audio DT conversion Gururaja is doing an up port of
>> AM335x EDMA support from TI release to mainline kernel. If you are
>> interested in it, he can probably share that with you once he posts his
>> DT patches.
> 
> As the DMA engine is also a requirement for the MMC controller, I would
> be interested in helping, in case help is required. Is there any
> repository with code that I can have a look at?

I'm just getting to the point now where I *almost* have something to push
to my github repo and post. It'll be Davinci-specific to start since it's
a wrapper around mach-davinci/dma.c and includes only memcpy and SG transfer
type support initially...plus conversions of davinci spi/mmc drivers.

There'll be a bit of work to get the omap-dma.c-dependent channel filtering
removed from the omap hsmmc and mcspi drivers so they can provide a filter
that works with either dmaengine driver. Also, that means DT support for
the actual dmaengine driver too and some glue to configure the crossbar.

I'll copy you when I get this RFC series posted and we can go from there.

-Matt
