From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: snd_dmaengine: add common api for
 pcm_mmap
Date: Thu, 28 Jun 2012 18:05:53 +0530
Message-ID: <4FEC4FA9.20004@nvidia.com>
References: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com> <4FEC3B70.5030902@metafoo.de> <s5hobo3zl79.wl%tiwai@suse.de> <20120628121816.GB21029@sirena.org.uk> <4FEC4E62.3020101@metafoo.de> <20120628122830.GJ28922@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120628122830.GJ28922@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lrg@ti.com" <lrg@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 28 June 2012 05:58 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Thu, Jun 28, 2012 at 02:30:26PM +0200, Lars-Peter Clausen wrote:
>> On 06/28/2012 02:18 PM, Mark Brown wrote:
>>> Oh, dear - this means we don't actually have a generic API at all.  Is
>>> there any effort being made to make this generally available?
>> Yes there is, and in fact in next/master there is generic
>> dma_mmap_writecombine. I'm not quite sure how it behaves on non ARM archs
>> though. But in theory it should fallback to a normal coherent mapping. Marek
>> did a lot of work on this, I've put him on Cc.

So can we put the function snd_pcm_lib_writecombine_mmap() in the 
pcm_native.c and only export this api for ARM i.e.  under macro  #ifdef 
CONFIG_ARM so that ARM based SOCs like Tegra/epa3xx/mxs/spear can 
directly use that one?
Or, wait for this common API until all ARCH support it?
