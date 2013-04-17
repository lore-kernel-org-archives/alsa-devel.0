From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 10/17] ASoC: mxs: Use generic dmaengine PCM
Date: Wed, 17 Apr 2013 16:43:06 +0800
Message-ID: <20130417084304.GK11245@S2101-09.ap.freescale.net>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-11-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 22DBA265B8D
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 10:43:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1366046404-8759-11-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 15, 2013 at 07:19:57PM +0200, Lars-Peter Clausen wrote:
> Use the generic dmaengine PCM driver instead of a custom implementation.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/mxs/Kconfig   |   2 +-
>  sound/soc/mxs/mxs-pcm.c | 135 ++++--------------------------------------------
>  2 files changed, 11 insertions(+), 126 deletions(-)

After applying the patch, mxs audio is broken as below.

[    2.003200] mxs-saif 80042000.saif: Missing dma channel for stream: 1
[    2.010220] mmc0: new high speed SDHC card at address e624
[    2.016453] mxs-saif 80042000.saif: ASoC: pcm constructor failed: -22
[    2.022964] mxs-sgtl5000 sound.12: ASoC: can't create pcm HiFi Playback :-22
[    2.030310] mxs-sgtl5000 sound.12: ASoC: failed to instantiate card -22

It's caused by that dmaengine_pcm_new() will call
dmaengine_pcm_compat_request_channel() twice to request the same mxs-dma
channel, and the second call will fail.

Shawn
