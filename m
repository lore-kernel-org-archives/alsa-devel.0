From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v4 01/10] ASoc: mxs: add mxs-pcm driver
Date: Wed, 20 Jul 2011 17:17:33 +0100
Message-ID: <4E26FF9D.1070000@ti.com>
References: <1311133306-9496-1-git-send-email-b29396@freescale.com>
	<1311133306-9496-2-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id E3CB424519
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 18:17:43 +0200 (CEST)
In-Reply-To: <1311133306-9496-2-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On 20/07/11 04:41, Dong Aisheng wrote:
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  sound/soc/mxs/mxs-pcm.c |  359 +++++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/mxs/mxs-pcm.h |   43 ++++++
>  2 files changed, 402 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
> new file mode 100644
> index 0000000..f9063e7
> --- /dev/null
> +++ b/sound/soc/mxs/mxs-pcm.c
> @@ -0,0 +1,359 @@
> +/*

snip

> +
> +static u64 mxs_pcm_dmamask = DMA_BIT_MASK(32);
> +static int mxs_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
> +       struct snd_pcm *pcm)
> 

This API has been updated to pass in the runtime data only. Can you redo against -next.

Thanks

Liam
