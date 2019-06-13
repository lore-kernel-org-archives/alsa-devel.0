From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 3/6] ASoC: sgtl5000: Fix of unmute
	outputs on probe
Date: Thu, 13 Jun 2019 09:05:48 +0000
Message-ID: <fc1b98afcd1d243e035fddd9916241633b343404.camel@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
 <20190521103619.4707-4-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03on070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe09::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25A2CF8076F
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 11:05:49 +0200 (CEST)
In-Reply-To: <20190521103619.4707-4-oleksandr.suvorov@toradex.com>
Content-Language: en-US
Content-ID: <FBAE2C25A90D254DAE2D3621CFBE7757@eurprd05.prod.outlook.com>
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
> To enable "zero cross detect" for ADC/HP, change
> HP_ZCD_EN/ADC_ZCD_EN bits only instead of writing the whole
> CHIP_ANA_CTRL register.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

> ---
> 
>  sound/soc/codecs/sgtl5000.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git sound/soc/codecs/sgtl5000.c sound/soc/codecs/sgtl5000.c
> index bb58c997c691..e813a37910af 100644
> --- sound/soc/codecs/sgtl5000.c
> +++ sound/soc/codecs/sgtl5000.c
> @@ -1289,6 +1289,7 @@ static int sgtl5000_probe(struct
> snd_soc_component *component)
>  	int ret;
>  	u16 reg;
>  	struct sgtl5000_priv *sgtl5000 =
> snd_soc_component_get_drvdata(component);
> +	unsigned int zcd_mask = SGTL5000_HP_ZCD_EN |
> SGTL5000_ADC_ZCD_EN;
>  
>  	/* power up sgtl5000 */
>  	ret = sgtl5000_set_power_regs(component);
> @@ -1316,9 +1317,8 @@ static int sgtl5000_probe(struct
> snd_soc_component *component)
>  	       0x1f);
>  	snd_soc_component_write(component, SGTL5000_CHIP_PAD_STRENGTH,
> reg);
>  
> -	snd_soc_component_write(component, SGTL5000_CHIP_ANA_CTRL,
> -			SGTL5000_HP_ZCD_EN |
> -			SGTL5000_ADC_ZCD_EN);
> +	snd_soc_component_update_bits(component,
> SGTL5000_CHIP_ANA_CTRL,
> +		zcd_mask, zcd_mask);
>  
>  	snd_soc_component_update_bits(component,
> SGTL5000_CHIP_MIC_CTRL,
>  			SGTL5000_BIAS_R_MASK,
> -- 
> 2.20.1
