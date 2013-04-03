From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 8/8] ASoC: omap: Use common DAI DMA data
Date: Wed, 3 Apr 2013 15:12:36 +0300
Message-ID: <20130403151236.2a1e78b48d635d5dc82485e6@bitmer.com>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-4-git-send-email-lars@metafoo.de>
 <515BFF33.6070905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 29224265B5B
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 14:12:11 +0200 (CEST)
In-Reply-To: <515BFF33.6070905@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 3 Apr 2013 12:06:43 +0200
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> On 04/03/2013 11:06 AM, Lars-Peter Clausen wrote:
> > Use the common DAI DMA data struct for omap, this allows us to use the common
> > helper function to configure the DMA slave config based on the DAI DMA data.
> > 
> > For omap-dmic and omap-mcpdm also move the DMA data from a global variable to
> > the driver state struct.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Looks good, works fine.
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
