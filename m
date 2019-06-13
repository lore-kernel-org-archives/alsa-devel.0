From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 4/6] ASoC: sgtl5000: Fix charge pump
	source assignment
Date: Thu, 13 Jun 2019 09:06:07 +0000
Message-ID: <15af220ffe1bcd36bd0cf178ed9f8d09a332d447.camel@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
 <20190521103619.4707-5-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00097.outbound.protection.outlook.com [40.107.0.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F4E1F8076F
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 11:06:08 +0200 (CEST)
In-Reply-To: <20190521103619.4707-5-oleksandr.suvorov@toradex.com>
Content-Language: en-US
Content-ID: <DE33956761B04E468ED912869CCE356D@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "festevam@gmail.com" <festevam@gmail.com>, Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: Igor Opaniuk <igor.opaniuk@toradex.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2019-05-21 at 13:36 +0300, Oleksandr Suvorov wrote:
> If VDDA != VDDIO and any of them is greater than 3.1V, charge pump
> source can be assigned automatically.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

> ---
> 
>  sound/soc/codecs/sgtl5000.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git sound/soc/codecs/sgtl5000.c sound/soc/codecs/sgtl5000.c
> index e813a37910af..ee1e4bf61322 100644
> --- sound/soc/codecs/sgtl5000.c
> +++ sound/soc/codecs/sgtl5000.c
> @@ -1174,12 +1174,16 @@ static int sgtl5000_set_power_regs(struct
> snd_soc_component *component)
>  					SGTL5000_INT_OSC_EN);
>  		/* Enable VDDC charge pump */
>  		ana_pwr |= SGTL5000_VDDC_CHRGPMP_POWERUP;
> -	} else if (vddio >= 3100 && vdda >= 3100) {
> +	} else {
>  		ana_pwr &= ~SGTL5000_VDDC_CHRGPMP_POWERUP;
> -		/* VDDC use VDDIO rail */
> -		lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
> -		lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
> -			    SGTL5000_VDDC_MAN_ASSN_SHIFT;
> +		/* if vddio == vdda the source of charge pump should be
> +		 * assigned manually to VDDIO
> +		 */
> +		if (vddio == vdda) {
> +			lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
> +			lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
> +				    SGTL5000_VDDC_MAN_ASSN_SHIFT;
> +		}
>  	}
>  
>  	snd_soc_component_write(component, SGTL5000_CHIP_LINREG_CTRL,
> lreg_ctrl);
> -- 
> 2.20.1
