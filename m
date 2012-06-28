From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: snd_dmaengine: add common api for pcm_mmap
Date: Thu, 28 Jun 2012 14:44:43 +0200
Message-ID: <4FEC51BB.2040504@metafoo.de>
References: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com> <20120628105148.GD28922@opensource.wolfsonmicro.com> <4FEC468A.3080607@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FEC468A.3080607@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "lrg@ti.com" <lrg@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 06/28/2012 01:56 PM, Laxman Dewangan wrote:
> On Thursday 28 June 2012 04:21 PM, Mark Brown wrote:
>> * PGP Signed by an unknown key
>>
>> On Thu, Jun 28, 2012 at 12:31:26PM +0530, Laxman Dewangan wrote:
>>> The pcm mmap for the substream dma buffer is done using the
>>> dma_mmap_writecombine().
>>> Some of the chip sound driver like Spear, Tegra, Davinci,
>>> ep93xx,snd_imx, snd_mxs, NUC900, OMAP, Samsung are doing this
>>> mapping locally.
>>> Add api in the snd dmaengine driver so that different client of
>>> snd dmaengine can use this rather than implementing locally.
>> OK, but I'd expect this to come along with one or more patches
>> converting at least some of the users to the new API...
> 
> This is effort towards moving the Tegra pcm driver for dmangine based dma
> driver inplace of legacy dma driver for Tegra which have private API.
> 
> Currently, following 4 pcm driver can use this API directly keeping that
> they already using the generic snd dmaengine pcm driver.
> ep93xx,
> spear,
> fsl,
> mxs.
> And Tegra will be next.
> 
> Other driver which can use this API are davinci, OMAP, samsung but because
> they are not using the snd_dmaengine_pcm driver's api as of now so not be
> very much useful for them.

Btw. all these drivers basically use the same code for buffer preallocation.
Since how the buffer is mmaped is related to how it is allocated it might be
worth to factor this out at the same time as well.

- Lars
