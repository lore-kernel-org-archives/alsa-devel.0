From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl: add imx-ssm2603 machine
	driver
Date: Thu, 30 Jan 2014 17:49:57 +0800
Message-ID: <20140130094956.GA5189@MrMyself>
References: <1391075058-3731-1-git-send-email-p.zabel@pengutronix.de>
 <1391075058-3731-2-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CD3C26532C
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 10:50:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1391075058-3731-2-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 30, 2014 at 10:44:18AM +0100, Philipp Zabel wrote:
> +static int imx_ssm2603_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

I think we can drop this remove() here right :)

Best regards,
Nicolin
