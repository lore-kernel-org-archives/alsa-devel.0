From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 2/6] ASoC: sgtl5000: add ADC mute control
Date: Thu, 13 Jun 2019 09:05:28 +0000
Message-ID: <063a08453c5d0c1c88ccb1bc8f4b1512e99ab138.camel@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
 <20190521103619.4707-3-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50133.outbound.protection.outlook.com [40.107.5.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59833F80794
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 11:05:30 +0200 (CEST)
In-Reply-To: <20190521103619.4707-3-oleksandr.suvorov@toradex.com>
Content-Language: en-US
Content-ID: <028F4CD25C14B6478349B18E20D4F554@eurprd05.prod.outlook.com>
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
> This control mute/unmute the ADC input of SGTL5000
> using its CHIP_ANA_CTRL register.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

> ---
> 
>  sound/soc/codecs/sgtl5000.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git sound/soc/codecs/sgtl5000.c sound/soc/codecs/sgtl5000.c
> index 5e49523ee0b6..bb58c997c691 100644
> --- sound/soc/codecs/sgtl5000.c
> +++ sound/soc/codecs/sgtl5000.c
> @@ -556,6 +556,7 @@ static const struct snd_kcontrol_new
> sgtl5000_snd_controls[] = {
>  			SGTL5000_CHIP_ANA_ADC_CTRL,
>  			8, 1, 0, capture_6db_attenuate),
>  	SOC_SINGLE("Capture ZC Switch", SGTL5000_CHIP_ANA_CTRL, 1, 1,
> 0),
> +	SOC_SINGLE("Capture Switch", SGTL5000_CHIP_ANA_CTRL, 0, 1, 1),
>  
>  	SOC_DOUBLE_TLV("Headphone Playback Volume",
>  			SGTL5000_CHIP_ANA_HP_CTRL,
> -- 
> 2.20.1
