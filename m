From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 1/2] ASoC: omap-mcbsp: Use DMA packet mode
 for non mono streams on OMAP3+
Date: Fri, 16 Mar 2012 09:00:12 +0200
Message-ID: <4F62E4FC.1020303@bitmer.com>
References: <1331807834-25675-1-git-send-email-peter.ujfalusi@ti.com>
	<1331807834-25675-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A9A724336
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 08:00:07 +0100 (CET)
In-Reply-To: <1331807834-25675-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 03/15/2012 12:37 PM, Peter Ujfalusi wrote:
> Take the DMA packet mode into use when the McBSP is configured in element
> dma_op_mode if the stream is not mono.
> In this way we transfer one sample from/to McBSP FIFO upon DMA request.
> This change only affects OMAP3+ versions, where the McBSP ports have FIFO.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |   30 +++++++++++++++++-------------
>  1 files changed, 17 insertions(+), 13 deletions(-)
> 
Out of curiosity, I guess this will decrease a memory bus or DMA
controller load a bit. Can you see any difference with the SW tools
(top, etc) under some system load or do you need some on-chip
observability to be able to measure effect of this transfer pattern change?

Just willing to learn here :-)

-- 
Jarkko
