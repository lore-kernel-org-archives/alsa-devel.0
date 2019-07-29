From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 1/7] ASoC: fsl_sai: Add registers
 definition for multiple datalines
Date: Mon, 29 Jul 2019 12:42:15 -0700
Message-ID: <20190729194214.GA20594@Asurada-Nvidia.nvidia.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-2-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0295FF803D5
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2019 21:41:31 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id r7so28544241pfl.3
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2019 12:41:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190728192429.1514-2-daniel.baluta@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de, timur@kernel.org, robh@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com, linux-kernel@vger.kernel.org, broonie@kernel.org, linux-imx@nxp.com, viorel.suman@nxp.com, festevam@gmail.com, mihai.serban@gmail.com, l.stach@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 28, 2019 at 10:24:23PM +0300, Daniel Baluta wrote:
> SAI IP supports up to 8 data lines. The configuration of
> supported number of data lines is decided at SoC integration
> time.
> 
> This patch adds definitions for all related data TX/RX registers:
> 	* TDR0..7, Transmit data register
> 	* TFR0..7, Transmit FIFO register
> 	* RDR0..7, Receive data register
> 	* RFR0..7, Receive FIFO register
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 76 +++++++++++++++++++++++++++++++++++------
>  sound/soc/fsl/fsl_sai.h | 36 ++++++++++++++++---
>  2 files changed, 98 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 6d3c6c8d50ce..17b0aff4ee8b 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c

> @@ -704,7 +711,14 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
>  	case FSL_SAI_TCR3:
>  	case FSL_SAI_TCR4:
>  	case FSL_SAI_TCR5:
> -	case FSL_SAI_TFR:
> +	case FSL_SAI_TFR0:
> +	case FSL_SAI_TFR1:
> +	case FSL_SAI_TFR2:
> +	case FSL_SAI_TFR3:
> +	case FSL_SAI_TFR4:
> +	case FSL_SAI_TFR5:
> +	case FSL_SAI_TFR6:
> +	case FSL_SAI_TFR7:
>  	case FSL_SAI_TMR:
>  	case FSL_SAI_RCSR:
>  	case FSL_SAI_RCR1:

A tricky thing here is that those SAI instances on older SoC don't
support multi data lines physically, while seemly having registers
pre-defined. So your change doesn't sound doing anything wrong to
them at all, I am still wondering if it is necessary to apply them
to newer compatible only though, as for older compatibles of SAI,
these registers would be useless and confusing if being exposed.

What do you think?
