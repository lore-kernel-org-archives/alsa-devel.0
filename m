From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 0/5] ALSA/ASoC/dmaengine: Fix 3 bytes physical
 sample support
Date: Thu, 3 Jul 2014 15:08:08 +0530
Message-ID: <20140703093808.GN2296@intel.com>
References: <1404363116-10538-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404363116-10538-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, lars@metafoo.de, tiwai@suse.de, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, joelf@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, dmaengine@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 03, 2014 at 07:51:51AM +0300, Peter Ujfalusi wrote:
 
> I have noticed while switching the daVinci audio to dmaengine_pcm that the _3LE
> and _3BE support is not working correctly via dmaengine_pcm:
> In case of _3LE/_3BE formats the samples are stored in 3 consecutive bytes
> without padding it to 4 bytes. This means that the DMA needs to be able to
> support 3 bytes word length in order to read/write the samples from memory
> correctly. Originally the code treated 24 bits physical length samples as
> they were 32 bits which leads to corruption when playing or recording audio.
> 
> To fix the support for 3 bytes physical samples the dma driver also need to have
> support for such data arrangement. eDMA does have support for it in HW and the
> legacy davinci-pcm platform driver w/o dmaengine was able to support such
> formats.
> 
> First step is to add DMA_SLAVE_BUSWIDTH_3_BYTES to dma_slave_buswidth for
> engines and users to select 3 bytes as bus width.
> 
> Followed by:
> In dmaengine_pcm_set_runtime_hwparams() we should check the slave_caps of the
> dma if it supports the give sample physical width of the sample. Based on this
> information we initialize the hw.formats: masking out all non supported formats
> based on the physical width.
> In case the dma driver does not implement the slave_caps the default assumption
> is that it supports 1, 2 and 4 bytes widths.

Whole series:
Acked-by Vinod Koul <vinod.koul@intel.com>

Yes makes sense to go thru ASoC tree. Mark can you keep this in immutable
branch, which I can merge to my tree for any future fixes...

-- 
~Vinod
