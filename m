From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [ASoC] list corruption during AC97 registration
Date: Fri, 27 Apr 2007 16:55:11 +0200
Message-ID: <46320ECF.4000609@roarinelk.homelinux.net>
References: <20070426171643.GA27510@roarinelk.homelinux.net>	
	<1177669283.11953.25.camel@llanelli.wolfsonmicro.main>	
	<20070427104717.GA29643@roarinelk.homelinux.net>
	<1177675602.11953.72.camel@llanelli.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F5AA2435E
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2007 16:55:42 +0200 (CEST)
In-Reply-To: <1177675602.11953.72.camel@llanelli.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lg@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> On Fri, 2007-04-27 at 12:47 +0200, Manuel Lauss wrote:
>> Hi Liam,
>>
>> On Fri, Apr 27, 2007 at 11:21:18AM +0100, Liam Girdwood wrote:
>>>> [<802ac0e4>] bus_attach_device+0x48/0x78
>>>> [<802aa4c4>] device_add+0x3d8/0x844
>>>> [<c00882a8>] snd_soc_register_card+0x1d0/0x2c8 [snd_soc_core]
>>>>
>>>> System.map says:
>>>> 80488e60 D ac97_bus_type
>>> Fwiw, I'd start by looking at soc_ac97_dev_register()
>> Do I need call a special ASoC function to create an AC97 bus,
>> like the snd_soc_new_ac97_codec() function, from board code?
> 
> ac97_bus_type is declared in ac97_bus.c, so there is no function to
> create it. The generic AC97 driver (codecs/ac97.c) does all the ac97
> init for you in ac97_soc_probe (e.g. create PCM's, register with AC97
> bus, create new AC97 mixer, register card), although I've never turned
> on the list debug here. 

the WM9712 code calls the above mentioned function, I concluded the
generic ac97 driver should do so too?

> Btw, is there anyway you can post your code ? It should make debugging a
> little easier and I can host it on my dev branch.

Sure, I'd be very happy if you could take a closer look:
for au1xxx:
http://mlau.at/files/asoc-au1xpsc-v1.patch
http://mlau.at/files/au1x-dbdma-audio-features.patch

for the SH7760:
http://mlau.at/files/asoc-sh7760-v1.patch
http://mlau.at/files/dmabrg.patch

I recorded the oopses here:
http://mlau.at/files/asoc-ac97-list-corruption.txt

Thanks!

-- 
 Manuel Lauss
