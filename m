From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 5/6] ASoC: Define a set of DAPM
	pre/post-up events
Date: Thu, 13 Jun 2019 09:06:23 +0000
Message-ID: <dbab9b60e46dde17a3dd0bd05a160d14e9e63860.camel@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
 <20190521103619.4707-6-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00105.outbound.protection.outlook.com [40.107.0.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F218EF80794
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 11:06:25 +0200 (CEST)
In-Reply-To: <20190521103619.4707-6-oleksandr.suvorov@toradex.com>
Content-Language: en-US
Content-ID: <D5430796D926C44B9A1666479D72A936@eurprd05.prod.outlook.com>
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
Cc: Igor Opaniuk <igor.opaniuk@toradex.com>, "tiwai@suse.com" <tiwai@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2019-05-21 at 13:36 +0300, Oleksandr Suvorov wrote:
> Prepare to use SND_SOC_DAPM_PRE_POST_PMU definition to
> reduce coming code size and make it more readable.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

> ---
> 
>  include/sound/soc-dapm.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git include/sound/soc-dapm.h include/sound/soc-dapm.h
> index c00a0b8ade08..6c6694160130 100644
> --- include/sound/soc-dapm.h
> +++ include/sound/soc-dapm.h
> @@ -353,6 +353,8 @@ struct device;
>  #define SND_SOC_DAPM_WILL_PMD   0x80    /* called at start of
> sequence */
>  #define SND_SOC_DAPM_PRE_POST_PMD \
>  				(SND_SOC_DAPM_PRE_PMD |
> SND_SOC_DAPM_POST_PMD)
> +#define SND_SOC_DAPM_PRE_POST_PMU \
> +				(SND_SOC_DAPM_PRE_PMU |
> SND_SOC_DAPM_POST_PMU)
>  
>  /* convenience event type detection */
>  #define SND_SOC_DAPM_EVENT_ON(e)	\
> -- 
> 2.20.1
