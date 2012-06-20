From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2 3/3] ASoC: dmaengine-pcm: Add support for querying
 stream position from DMA driver
Date: Wed, 20 Jun 2012 16:25:33 +0530
Message-ID: <1340189733.1927.1651.camel@vkoul-udesk3>
References: <1339438302-12417-1-git-send-email-lars@metafoo.de>
	 <1339438302-12417-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339438302-12417-3-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Russell King <linux@arm.linux.org.uk>, Ola Lilja <ola.o.lilja@stericsson.com>, Shawn Guo <shawn.guo@linaro.org>, Mika Westerberg <mika.westerberg@iki.fi>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-06-11 at 20:11 +0200, Lars-Peter Clausen wrote:
> Currently the sound dmaengine pcm helper functions implement the pcm_pointer
> callback by trying to count the number of elapsed periods. This is done by
> advancing the stream position in the dmaengine callback by one period.
> Unfortunately there is no guarantee that the callback will be called for each
> elapsed period. It may be possible that under high system load it is only called
> once for multiple elapsed periods. This patch addresses the issue by
> implementing support for querying the current stream position directly from the
> dmaengine driver. Since not all dmaengine drivers support reporting the stream
> position yet the old period counting implementation is kept for now.
> 
> Furthermore the new mechanism allows to report the stream position with a
> sub-period granularity, given that the dmaengine driver supports this.
> 
Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
