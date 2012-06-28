From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: snd_dmaengine: add common api for
 pcm_mmap
Date: Thu, 28 Jun 2012 19:30:57 +0530
Message-ID: <4FEC6399.5050505@nvidia.com>
References: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com>	<4FEC3B70.5030902@metafoo.de>	<s5hobo3zl79.wl%tiwai@suse.de>	<20120628121816.GB21029@sirena.org.uk>	<4FEC4E62.3020101@metafoo.de>	<20120628122830.GJ28922@opensource.wolfsonmicro.com>	<4FEC4FA9.20004@nvidia.com>	<s5hlij7zja0.wl%tiwai@suse.de>	<4FEC5642.9080908@nvidia.com>	<s5hk3yrzhte.wl%tiwai@suse.de>	<4FEC5DC7.5060600@nvidia.com> <s5hd34jzgs0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hd34jzgs0.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lrg@ti.com" <lrg@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 28 June 2012 07:21 PM, Takashi Iwai wrote:
> At Thu, 28 Jun 2012 19:06:07 +0530,
> Laxman Dewangan wrote:
>
>>>> Then how about this?
>>>> create new file and header for snd-pcm-writecombine-buffer.c/.h and put
>>>> this in sound/core.
>>>> Select this file compilation through config SND_PCM_WRITECOMBINE_BUFFER
>>>> which will be select this config through sound/soc/xxx/Kconfig if they
>>>> want to use.
>>>> This will provide three apis: new, free and mmap.
>>> Way too much hustles than necessary...
>> Ooh no. :-(  I had taken the idea from snd_dmaengine_pcm driver.
>> Bit I like to hear simple way which solves the purpose.
> As Lars suggested, a simple ifdef should suffice for now.
> With the upcoming generic dma_mmap_writecombine() stuff, it'd be even
> simpler in future.
>
> But, still we need to be careful about this.  As mentioned, there is
> no flag to know the possibility of writecombine mmap beforehand.
> It'd be nice if we have either a compile-time or a run-time flag /
> function to check that.  Then the driver can also expose the mmap
> capability to user-space depending on the flag.

Yaah, this seems really simple. Thanks for suggestion.
If I understand it fully, the new apis will be declare in sound/pcm.h, 
implement it in pcm_native.c and use the config variable
CONFIG_SND_PCM_WRITECOMBINE_BUFFER for ifdef.

This will be selected in required sound/soc driver so they can use it 
like powerpc (for fsl) and ARM arch based soc.
