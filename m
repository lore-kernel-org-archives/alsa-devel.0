From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2 2/3] ASoC: dmaengine-pcm: Rename and
 deprecate snd_dmaengine_pcm_pointer
Date: Wed, 20 Jun 2012 16:25:01 +0530
Message-ID: <1340189701.1927.1650.camel@vkoul-udesk3>
References: <1339438302-12417-1-git-send-email-lars@metafoo.de>
	<1339438302-12417-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id B58AE24519
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2012 13:02:50 +0200 (CEST)
In-Reply-To: <1339438302-12417-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Mika Westerberg <mika.westerberg@iki.fi>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-06-11 at 20:11 +0200, Lars-Peter Clausen wrote:
> Currently the sound dmaengine pcm helper functions implement the pcm_pointer
> callback by trying to count the number of elapsed periods. This is done by
> advancing the stream position in the dmaengine callback by one period.
> Unfortunately there is no guarantee that the callback will be called for each
> elapsed period. It may be possible that under high system load it is only called
> once for multiple elapsed periods. This patch renames the current implementation
> and documents its shortcomings and that it should not be used anymore in new
> drivers.
> 
> The next patch will introduce a new snd_dmaengine_pcm_pointer which will be
> implemented based on querying the current stream position from the dma device.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
