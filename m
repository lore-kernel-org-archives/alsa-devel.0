From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: imx-audmux: add RXFS/RXCLK defines
 for 6-wire connections
Date: Sat, 19 May 2018 23:10:43 -0700
Message-ID: <20180520060954.GA3257@Asurada-CZ80>
References: <20180517142601.19587-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f66.google.com (mail-pl0-f66.google.com
 [209.85.160.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 7567C26705D
 for <alsa-devel@alsa-project.org>; Sun, 20 May 2018 08:10:53 +0200 (CEST)
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so6884330pld.13
 for <alsa-devel@alsa-project.org>; Sat, 19 May 2018 23:10:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180517142601.19587-1-m.felsch@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, timur@tabi.org, broonie@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 17, 2018 at 04:26:01PM +0200, Marco Felsch wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> In asynchronous mode, a RxFS and RxClk connection needs to be made between
> two ports. Add a define for the bit to be set in the *SEL fields.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  include/dt-bindings/sound/fsl-imx-audmux.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/sound/fsl-imx-audmux.h b/include/dt-bindings/sound/fsl-imx-audmux.h
> index 751fe1416f95..6120696abe63 100644
> --- a/include/dt-bindings/sound/fsl-imx-audmux.h
> +++ b/include/dt-bindings/sound/fsl-imx-audmux.h
> @@ -25,6 +25,10 @@
>  #define MX51_AUDMUX_PORT6		5
>  #define MX51_AUDMUX_PORT7		6
>  
> +/* TFSEL/TCSEL/RFSEL/RCSEL can be sourced from Rx/Tx clocks on i.MX51/53/6Q */

It's actually not confined to 51/53/6Q -- 21 and 35 should
also have it according to their Reference Manuals.

> +#define IMX_AUDMUX_RXFS			0x8
> +#define IMX_AUDMUX_RXCLK		0x8
> +
>  /* Register definitions for the i.MX21/27 Digital Audio Multiplexer */
>  #define IMX_AUDMUX_V1_PCR_INMMASK(x)	((x) & 0xff)
>  #define IMX_AUDMUX_V1_PCR_INMEN		(1 << 8)
> -- 
> 2.17.0
> 
