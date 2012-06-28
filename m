From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: snd_dmaengine: add common api for
 pcm_mmap
Date: Thu, 28 Jun 2012 14:32:33 +0200
Message-ID: <4FEC4EE1.1030001@ladisch.de>
References: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com> <4FEC3B70.5030902@metafoo.de> <s5hobo3zl79.wl%tiwai@suse.de> <20120628121816.GB21029@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120628121816.GB21029@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, swarren@nvidia.com, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Jun 28, 2012 at 02:15:38PM +0200, Takashi Iwai wrote:
>> So far, only ARM has dma_mmap_writecombine(), thus the build on other
>> arch would fail as is.
>
> Oh, dear - this means we don't actually have a generic API at all.  Is
> there any effort being made to make this generally available?

http://lkml.org/lkml/2012/6/15/27:
| Commit 9adc5374 ('common: dma-mapping: introduce mmap method') added a
| generic method for implementing mmap user call to dma_map_ops structure.
|
| This patch converts ARM and PowerPC architectures (the only providers of
| dma_mmap_coherent/dma_mmap_writecombine calls) to use this generic
| dma_map_ops based call and adds a generic cross architecture
| definition for dma_mmap_attrs, dma_mmap_coherent, dma_mmap_writecombine
| functions.
|
| The generic mmap virt_to_page-based fallback implementation is provided for
| architectures which don't provide their own implementation for mmap method.
|
| Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
| Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
| ---
| Hello,
| This patch is a continuation of my works on dma-mapping cleanup and
| unification. Previous works (commit 58bca4a8fa ('Merge branch
| 'for-linus' of git://git.linaro.org/people/mszyprowski/linux-dma-mapping')
| has been merged to v3.4-rc2. Now I've focuses on providing implementation
| for all architectures so the drivers and some cross-architecture common
| helpers (like for example videobuf2) can start using this new api.
|
| I'm not 100% sure if the PowerPC changes are correct. The cases of
| dma_iommu_ops and vio_dma_mapping_ops are a bit suspicious for me, but I
| have no way to test and check if my changes works for that hardware.
|
| Best regards
| Marek Szyprowski
| Samsung Poland R&D Center


Regards,
Clemens
