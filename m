From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] ASoC: snd_dmaengine: add common api for pcm_mmap
Date: Thu, 28 Jun 2012 17:26:58 +0530
Message-ID: <4FEC468A.3080607@nvidia.com>
References: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com> <20120628105148.GD28922@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120628105148.GD28922@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "lrg@ti.com" <lrg@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 28 June 2012 04:21 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Thu, Jun 28, 2012 at 12:31:26PM +0530, Laxman Dewangan wrote:
>> The pcm mmap for the substream dma buffer is done using the
>> dma_mmap_writecombine().
>> Some of the chip sound driver like Spear, Tegra, Davinci,
>> ep93xx,snd_imx, snd_mxs, NUC900, OMAP, Samsung are doing this
>> mapping locally.
>> Add api in the snd dmaengine driver so that different client of
>> snd dmaengine can use this rather than implementing locally.
> OK, but I'd expect this to come along with one or more patches
> converting at least some of the users to the new API...

This is effort towards moving the Tegra pcm driver for dmangine based 
dma driver inplace of legacy dma driver for Tegra which have private API.

Currently, following 4 pcm driver can use this API directly keeping that 
they already using the generic snd dmaengine pcm driver.
ep93xx,
spear,
fsl,
mxs.
And Tegra will be next.

Other driver which can use this API are davinci, OMAP, samsung but 
because they are not using the snd_dmaengine_pcm driver's api as of now 
so not be very much useful for them.


Should I send one patch per driver change or squash all 4 file changes 
in one patch? Whatever will be easy or recommended?
