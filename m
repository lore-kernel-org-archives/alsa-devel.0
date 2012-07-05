From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: fsl: remove unneeded AUDMUX register
 setting from imx-sgtl5000
Date: Thu, 5 Jul 2012 09:33:43 +0800
Message-ID: <20120705013341.GA10610@S2101-09.ap.freescale.net>
References: <1341387507-21015-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe001.messaging.microsoft.com [213.199.154.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 36F0A245A9
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 03:33:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1341387507-21015-1-git-send-email-jason77.wang@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hui Wang <jason77.wang@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 04, 2012 at 03:38:27PM +0800, Hui Wang wrote:
> If we don't set IMX_AUDMUX_V2_PTCR_TCLKDIR in the AUDMUX PTCR
> register (means Tx clock pin is input), we don't need to set
> IMX_AUDMUX_V2_PTCR_TCSEL as well. Since both i.MX35, i.MX51 and
> i.MX6 datasheet says "When Tx clock pin set as an input, the TCSEL
> settings are ignored".
> 
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  sound/soc/fsl/imx-sgtl5000.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 3a729ca..fb21b17 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -95,8 +95,7 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  	imx_audmux_v2_configure_port(ext_port,
> -			IMX_AUDMUX_V2_PTCR_SYN |
> -			IMX_AUDMUX_V2_PTCR_TCSEL(int_port),
> +			IMX_AUDMUX_V2_PTCR_SYN,
>  			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
>  	if (ret) {
>  		dev_err(&pdev->dev, "audmux external port setup failed\n");
> -- 
> 1.7.6
> 
