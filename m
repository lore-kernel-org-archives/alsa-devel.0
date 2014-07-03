From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 0/5] ALSA/ASoC/dmaengine: Fix 3 bytes physical sample
 support
Date: Thu, 03 Jul 2014 10:33:34 +0200
Message-ID: <53B5155E.7050103@metafoo.de>
References: <1404363116-10538-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404363116-10538-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, vinod.koul@intel.com, dan.j.williams@intel.com, tiwai@suse.de, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, joelf@ti.com, nsekhar@ti.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, dmaengine@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 07/03/2014 06:51 AM, Peter Ujfalusi wrote:
[...]
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

The whole series looks good to me. Since both the DMA and ALSA bits changed 
in this series are fairly trivial I think it is best to merge the whole 
series through the ASoC tree.

- Lars
