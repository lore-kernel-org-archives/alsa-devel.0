From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH V2 3/4] Add ASoC support for Devkit8000
Date: Tue, 9 Feb 2010 18:33:16 +0200
Message-ID: <20100209183316.ebd62093.jhnikula@gmail.com>
References: <1265731728-5639-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 19854103816
	for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2010 17:29:05 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 4so1646881eyg.16
	for <alsa-devel@alsa-project.org>; Tue, 09 Feb 2010 08:29:03 -0800 (PST)
In-Reply-To: <1265731728-5639-1-git-send-email-weber@corscience.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thomas Weber <weber@corscience.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

On Tue,  9 Feb 2010 17:08:48 +0100
Thomas Weber <weber@corscience.de> wrote:

>  config SND_OMAP_SOC_OMAP3_BEAGLE
> -	tristate "SoC Audio support for OMAP3 Beagle"
> -	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_BEAGLE
> +	tristate "SoC Audio support for OMAP3 Beagle and Devkit8000"
> +	depends on TWL4030_CORE && SND_OMAP_SOC 
> +	depends on (MACH_OMAP3_BEAGLE || MACH_DEVKIT8000)
>  	select SND_OMAP_SOC_MCBSP
>  	select SND_SOC_TWL4030
>  	help
> -	  Say Y if you want to add support for SoC audio on the Beagleboard.
> +	  Say Y if you want to add support for SoC audio on the Beagleboard or 
> +	  the clone Devkit8000.
>  
I was thinking here that would it be better to have own Kconfig option
for the Devkit8000 already now? I don't know the Devkit8000 but it makes
easier to maintain e.g. defconfigs if there is ever need to separate
audio functionality, select statements, etc. of these two board.


-- 
Jarkko
