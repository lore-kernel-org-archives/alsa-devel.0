From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 0/2] dmaengine: Fix compillation issues in
 device_prep_dma_cyclic()
Date: Mon, 24 Sep 2012 14:10:09 +0530
Message-ID: <1348476009.1943.187.camel@vkoul-udesk3>
References: <20120924133923.130c4db72aa8105cb5647d7a@canb.auug.org.au>
	 <1348473485-5081-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1348473485-5081-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-09-24 at 10:58 +0300, Peter Ujfalusi wrote:
> Hello,
> 
> The reason for the breakage is the patch 1 got lost somewhere in the process.
> I also greped the whole tree for device_prep_dma_cyclic() and the second patch
> is the result of that.
> 
> PS: I did build tested the series on ARM (OMAP), x86_32, x86_64 but not for ppc
> for sure.
I though patch 1 was part of the series Mark was supposed to apply.

Anyway both look fine to me so:
Both Acked-By: Vinod Koul <vinod.koul@linux.intel.com>

-- 
~Vinod
