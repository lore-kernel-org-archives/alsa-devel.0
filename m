From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: imx-sdma: advertise all
 supported slave bus widths
Date: Tue, 31 Oct 2017 17:43:15 +0530
Message-ID: <20171031121315.GT3187@localhost>
References: <20171013104346.16818-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 797D426727C
 for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2017 13:10:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171013104346.16818-1-l.stach@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: alsa-devel@alsa-project.org, patchwork-lst@pengutronix.de, broonie@kernel.org, kernel@pengutronix.de, peter.seiderer.ext@zeiss.com, dmaengine@vger.kernel.org, LW@KARO-electronics.de
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 13, 2017 at 12:43:46PM +0200, Lucas Stach wrote:
> The commit [1] which changed imx-pcm-dma to derive the pcm_config from the
> attached dmaengine introduced a regression on the supported sample formats,
> as imx-sdma doesn't properly advertise all the supported slave bus widths.
> 
> Fix this to restore full functionality of the imx sound subsystem.
> 
> [1] 70d435ba1cd6 ("ASoC: imx-pcm-dma: simplify pcm_config")
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

This doesnt apply for me, please rebase and resend. While at it please fix
the stuff flagged by checkpatch

-- 
~Vinod
