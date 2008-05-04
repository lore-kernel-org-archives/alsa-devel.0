From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2.6.25.1] S3C2410 pcm audio broken
Date: Sun, 04 May 2008 15:30:00 +0100
Message-ID: <1209911400.3923.3.camel@odin>
References: <481DB2D6.4000304@elpa.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D1272454E
	for <alsa-devel@alsa-project.org>;
	Sun,  4 May 2008 16:30:02 +0200 (CEST)
In-Reply-To: <481DB2D6.4000304@elpa.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ing. Davide Rizzo" <davide@elpa.it>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Linux-arm <linux-arm-kernel@lists.arm.linux.org.uk>, ben-linux <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 2008-05-04 at 14:57 +0200, ing. Davide Rizzo wrote:
> S3C2410 pcm doesn't work.
> s3c2410_dma_request() now returns the channel number and not 0 if OK.
> Davide
> plain text document attachment (s3c24xx-pcm.patch)
> This patch to update to a s3c2410_dma_request return value change
> 
> Signed-off-by: Davide Rizzo <davide@elpa.it>
> ================================================================================
> --- linux-2.6.25.1/sound/soc/s3c24xx/s3c24xx-pcm.c	2008-04-17 04:49:44.000000000 +0200
> +++ linux-2.6.25.1.elpa/sound/soc/s3c24xx/s3c24xx-pcm.c	2008-05-04 09:27:46.000000000 +0200
> @@ -171,7 +171,7 @@ static int s3c24xx_pcm_hw_params(struct 
>  		ret = s3c2410_dma_request(prtd->params->channel,
>  					  prtd->params->client, NULL);
>  
> -		if (ret) {
> +		if (ret < 0) {
>  			DBG(KERN_ERR "failed to get dma channel\n");
>  			return ret;
>  		}
> -------------------------------------------------------------------

Acked-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
