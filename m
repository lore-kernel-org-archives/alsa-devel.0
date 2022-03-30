Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75393C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Mar 2022 07:51:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B22E9172D;
	Wed, 30 Mar 2022 09:50:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B22E9172D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648626682;
	bh=BrNS4Ei8ANs0yiwJlbRHrAzqZ1IvcNfjPjwY0m3MfQU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SYzG+JNowggfIzVnbnFMasG3hg9BQ/uqxKrSTG+5ipWaP4taqZ9el771J1zI859bu
	 RpmgePt/byRezbdLX8Aike2pVBIW4Mg1/WAJAwhiDyZPWzJg9tS1JkGHCiaRSMmiOP
	 /pV8H7S+7w/OmMvVQOSLhIrl0YYPrI6dH4/ydRu4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57200F8025A;
	Wed, 30 Mar 2022 09:50:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 12E99F804B4; Wed, 30 Mar 2022 09:50:30 +0200 (CEST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D73D4F80155
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2022 09:50:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D73D4F80155
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1nZT5y-0005w4-Ou; Wed, 30 Mar 2022 09:50:22 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1nZT5y-0002Om-Ak; Wed, 30 Mar 2022 09:50:22 +0200
Date: Wed, 30 Mar 2022 09:50:22 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 11/19] ASoC: fsl_micfil: add multi fifo support
Message-ID: <20220330075022.GO22780@pengutronix.de>
References: <20220328112744.1575631-1-s.hauer@pengutronix.de>
 <20220328112744.1575631-12-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328112744.1575631-12-s.hauer@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:49:43 up 109 days, 16:35, 78 users,  load average: 0.02, 0.08,
 0.08
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Vinod Koul <vkoul@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 kernel@pengutronix.de, dmaengine@vger.kernel.org,
 Shengjiu Wang <shengjiu.wang@gmail.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, Mar 28, 2022 at 01:27:36PM +0200, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

This also lacks a commit message. Will add:

    The micfil hardware provides the microphone data on multiple successive
    FIFO registers, one register per stereo pair. Also to work properly the
    SDMA_DONE0_CONFIG_DONE_SEL bit in the SDMA engines SDMA_DONE0_CONFIG
    register must be set. This patch provides the necessary information to
    the SDMA engine driver.

Sascha

>  sound/soc/fsl/fsl_micfil.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> index ffca56d72562d..fe3e1319b35fd 100644
> --- a/sound/soc/fsl/fsl_micfil.c
> +++ b/sound/soc/fsl/fsl_micfil.c
> @@ -16,6 +16,7 @@
>  #include <linux/regmap.h>
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
> +#include <linux/platform_data/dma-imx.h>
>  #include <sound/dmaengine_pcm.h>
>  #include <sound/pcm.h>
>  #include <sound/soc.h>
> @@ -35,6 +36,7 @@ struct fsl_micfil {
>  	struct clk *busclk;
>  	struct clk *mclk;
>  	struct snd_dmaengine_dai_dma_data dma_params_rx;
> +	struct sdma_peripheral_config sdmacfg;
>  	unsigned int dataline;
>  	char name[32];
>  	int irq[MICFIL_IRQ_LINES];
> @@ -324,6 +326,10 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
>  		return ret;
>  	}
>  
> +	micfil->dma_params_rx.peripheral_config = &micfil->sdmacfg;
> +	micfil->dma_params_rx.peripheral_size = sizeof(micfil->sdmacfg);
> +	micfil->sdmacfg.n_fifos_src = channels;
> +	micfil->sdmacfg.sw_done = true;
>  	micfil->dma_params_rx.maxburst = channels * MICFIL_DMA_MAXBURST_RX;
>  
>  	return 0;
> -- 
> 2.30.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
