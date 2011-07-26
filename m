From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/3] OMAP4: hwmod: enable mcpdm hwmod device.
Date: Tue, 26 Jul 2011 15:46:43 +0200
Message-ID: <4E2EC543.6080702@ti.com>
References: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com> <1310041672-18634-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1310041672-18634-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Peter,

That might be a little bit too late for this merge window, but since 
that patch should not conflict with all the changes we are doing in l-o, 
you should be able to merge it from alsa.

On 7/7/2011 2:27 PM, Ujfalusi, Peter wrote:
> Signed-off-by: Peter Ujfalusi<peter.ujfalusi@ti.com>
> Signed-off-by: Jorge Eduardo Candelaria
> Signed-off-by: Margarita Olaya Cabrera
> Signed-off-by: Liam Girdwood<lrg@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

Regards,
Benoit


> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index e1c69ff..63e7c41 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -5121,7 +5121,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>   	&omap44xx_mcbsp4_hwmod,
>
>   	/* mcpdm class */
> -/*	&omap44xx_mcpdm_hwmod, */
> +	&omap44xx_mcpdm_hwmod,
>
>   	/* mcspi class */
>   	&omap44xx_mcspi1_hwmod,

