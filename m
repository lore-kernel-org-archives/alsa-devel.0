From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 6/6] MIPS: jz4740: Remove custom DMA API
Date: Thu, 30 May 2013 22:50:50 +0530
Message-ID: <20130530172050.GB3767@intel.com>
References: <1369931105-28065-1-git-send-email-lars@metafoo.de>
 <1369931105-28065-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1369931105-28065-7-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maarten ter Huurne <maarten@treewalker.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 30, 2013 at 06:25:05PM +0200, Lars-Peter Clausen wrote:
> Now that all users of the custom jz4740 DMA API have been converted to use
> the dmaengine API instead we can remove the custom API and move all the code
> talking to the hardware to the dmaengine driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> ---
> No changes since v1
> ---
>  arch/mips/include/asm/mach-jz4740/dma.h |  56 ------
>  arch/mips/jz4740/Makefile               |   2 +-
>  arch/mips/jz4740/dma.c                  | 307 --------------------------------
>  drivers/dma/dma-jz4740.c                | 258 +++++++++++++++++++++++----
>  4 files changed, 222 insertions(+), 401 deletions(-)
>  delete mode 100644 arch/mips/jz4740/dma.c
only dma.c, you should remove the dma.h or relocate it to linux/


rest of the series looks fine, and once we have acks from repsective subsystem
mainatiners, we should be good to merge

--
~Vinod
