From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v9 01/10] ASoC: imx-pcm-dma: DT support
Date: Sun, 23 Jun 2013 12:49:17 -0500
Message-ID: <51C7351D.9080004@tabi.org>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by alsa0.perex.cz (Postfix) with ESMTP id 7A8A8261A2E
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2013 19:49:25 +0200 (CEST)
In-Reply-To: <1371734429-6081-2-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Markus Pargmann wrote:
> This patch removes the NO_DT flag. The pdev pointer may have a proper
> of_node with the dmas property, so we can use it to request DMA
> channels.
>
> Signed-off-by: Markus Pargmann<mpa@pengutronix.de>
> Tested-by: Shawn Guo<shawn.guo@linaro.org>
> ---

I won't have access to functioning hardware for another month or two, so I 
can't test to see if this patchset breaks PowerPC, but at least it does 
compile.  I'm a little worried that the DMA changes won't actually run on 
PowerPC, but I can't test that now.

So for the time being:

Acked-by: Timur Tabi <timur@tabi.org>

-- 
Timur Tabi
