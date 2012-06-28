From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: snd_dmaengine: add common api for
 pcm_mmap
Date: Thu, 28 Jun 2012 19:06:07 +0530
Message-ID: <4FEC5DC7.5060600@nvidia.com>
References: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com>	<4FEC3B70.5030902@metafoo.de>	<s5hobo3zl79.wl%tiwai@suse.de>	<20120628121816.GB21029@sirena.org.uk>	<4FEC4E62.3020101@metafoo.de>	<20120628122830.GJ28922@opensource.wolfsonmicro.com>	<4FEC4FA9.20004@nvidia.com>	<s5hlij7zja0.wl%tiwai@suse.de>	<4FEC5642.9080908@nvidia.com> <s5hk3yrzhte.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk3yrzhte.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lrg@ti.com" <lrg@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 28 June 2012 06:58 PM, Takashi Iwai wrote:
> At Thu, 28 Jun 2012 18:34:02 +0530,
> Laxman Dewangan wrote:
>> On Thursday 28 June 2012 06:27 PM, Takashi Iwai wrote:
>>> At Thu, 28 Jun 2012 18:05:53 +0530,
>>> Laxman Dewangan wrote:
>>>> On Thursday 28 June 2012 05:58 PM, Mark Brown wrote:
>>>>> * PGP Signed by an unknown key
>>>>>
>>>>> On Thu, Jun 28, 2012 at 02:30:26PM +0200, Lars-Peter Clausen wrote:
>>>>>> On 06/28/2012 02:18 PM, Mark Brown wrote:
>>>>>>> Oh, dear - this means we don't actually have a generic API at all.  Is
>>>>>>> there any effort being made to make this generally available?
>>>>>> Yes there is, and in fact in next/master there is generic
>>>>>> dma_mmap_writecombine. I'm not quite sure how it behaves on non ARM archs
>>>>>> though. But in theory it should fallback to a normal coherent mapping. Marek
>>>>>> did a lot of work on this, I've put him on Cc.
>>>> So can we put the function snd_pcm_lib_writecombine_mmap() in the
>>>> pcm_native.c and only export this api for ARM i.e.  under macro  #ifdef
>>>> CONFIG_ARM so that ARM based SOCs like Tegra/epa3xx/mxs/spear can
>>>> directly use that one?
>>>> Or, wait for this common API until all ARCH support it?
>>> I think it's fine to put it first in ALSA side with some ifdef.
>>> A similar trick is already found for snd_pcm_lib_mmap_iomem.
>>> See include/sound/pcm.h.
>>>
>>> But, actually it's a still question what if an architecture doesn't
>>> support the mmap of writecombine at all.  The proposed patch doesn't
>>> allow you to know whether writecombine-mmap is possible or not on the
>>> running architecture until you really try to call it and fail.
>>> It's a missing piece, IMO.
>> Lars wanted to move the buffer allocation also to common place.
> Which common place?

He wanted to refactor allocation part also at same time and so I guessed 
that it will be in some common place and though about the sound/core.

>> Then how about this?
>> create new file and header for snd-pcm-writecombine-buffer.c/.h and put
>> this in sound/core.
>> Select this file compilation through config SND_PCM_WRITECOMBINE_BUFFER
>> which will be select this config through sound/soc/xxx/Kconfig if they
>> want to use.
>> This will provide three apis: new, free and mmap.
> Way too much hustles than necessary...
Ooh no. :-(  I had taken the idea from snd_dmaengine_pcm driver.
Bit I like to hear simple way which solves the purpose.
