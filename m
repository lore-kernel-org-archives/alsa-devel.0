From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] sound: Add dependency on DMA
Date: Thu, 17 Nov 2016 11:42:38 -0800
Message-ID: <03fdca9f-1e6f-54b7-18b8-74b8063cb4fb@gmail.com>
References: <20161117185237.7070-1-f.fainelli@gmail.com>
 <s5hbmxe9be0.wl-tiwai@suse.de>
 <20c84fff-13d0-e608-1237-6bc567014cc5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20c84fff-13d0-e608-1237-6bc567014cc5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, "moderated list:SOUND" <alsa-devel@alsa-project.org>, arnd@arndb.de, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

On 11/17/2016 11:14 AM, Florian Fainelli wrote:
> On 11/17/2016 11:03 AM, Takashi Iwai wrote:
>> On Thu, 17 Nov 2016 19:52:37 +0100,
>> Florian Fainelli wrote:
>>>
>>> Architectures like m32r do not have a proper DMA-API implementation,
>>> fixes COMPILE_TEST linking failures for the sounds subsystem.
>>
>> What error did you get exactly?
>> There are already CONFIG_HAS_DMA dependency in a few places, so I
>> wonder what's missing.
> 
> They looked like these:
> 
> sound/built-in.o: In function `snd_pcm_lib_default_mmap':
> (.text+0xbb14): undefined reference to `bad_dma_ops'
> sound/built-in.o: In function `snd_pcm_lib_default_mmap':
> (.text+0xbb1c): undefined reference to `bad_dma_ops'
> sound/built-in.o: In function `snd_pcm_lib_default_mmap':
> (.text+0xbb34): undefined reference to `dma_common_mmap'
> sound/built-in.o: In function `snd_pcm_lib_default_mmap':
> (.text+0xbb34): relocation truncated to fit: R_M32R_26_PCREL_RELA
> against undefined symbol `dma_common_mmap'
> Makefile:961: recipe for target 'vmlinux' failed
> 
> I could probably add an ifdef CONFIG_HAS_DMA just surrounding these
> snd_pcm_lib if you think this is more appropriate?

I can't reproduce this build failure reliably anyway now, it was due to
switching between x86/m32r configurations, the only offender was the
Broadcom Cygnus driver, and this has been fixed as well.

Sorry for the noise!
-- 
Florian
