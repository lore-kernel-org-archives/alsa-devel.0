From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] ASoC: atmel: fix build failure
Date: Mon, 06 Jun 2016 21:58:41 +0100
Message-ID: <5755E401.4050008@gmail.com>
References: <1465149621-4493-1-git-send-email-sudipm.mukherjee@gmail.com> <20160606101747.GA7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606101747.GA7510@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 06 June 2016 11:17 AM, Mark Brown wrote:
> On Sun, Jun 05, 2016 at 07:00:21PM +0100, Sudip Mukherjee wrote:
>> m32r allmodconfig build is failing with the error:
>> ERROR: "bad_dma_ops" [sound/soc/atmel/snd-soc-atmel-pcm-pdc.ko] undefined!
>>
>> The code is using DMA but the related dependency is not mentioned in the
>> Kconfig.
>
> Rather than going through every single driver using DMA adding the
> dependency might it not be simpler to provide at least a stub DMA
> implementation for the architectures that don't have it?
>

Yes, i can add them for m32r. but since m32r is orphan i send all m32r 
patches to Andrew.
So, Andrew, do you have any objection to it?

Regards
Sudip
