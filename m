From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 7/8] ASoC: fsl: Use common DAI DMA data
	struct
Date: Fri, 5 Apr 2013 13:19:05 +0800
Message-ID: <20130405051903.GA2667@S2101-09.ap.freescale.net>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 98DC9265F55
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 07:19:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1364979965-15776-3-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 03, 2013 at 11:06:04AM +0200, Lars-Peter Clausen wrote:
> Use the common DAI DMA data struct for fsl/imx, this allows us to use the common
> helper function to configure the DMA slave config based on the DAI DMA data.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Sorry for the delay.  On imx6q,

Tested-by: Shawn Guo <shawn.guo@linaro.org>
