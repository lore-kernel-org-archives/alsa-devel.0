From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv3 1/2] McBSP: OMAP3: Add sidetone feature
Date: Thu, 18 Feb 2010 15:24:13 +0200
Message-ID: <20100218152413.11d0189a.jhnikula@gmail.com>
References: <1266496635-31347-1-git-send-email-ilkka.koskinen@nokia.com>
	<1266496635-31347-2-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1266496635-31347-2-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, broonie@opensource.wolfsonmicro.com, tony@atomide.com, eduardo.valentin@nokia.com, ext-Eero.Nurkkala@nokia.com
List-Id: alsa-devel@alsa-project.org

On Thu, 18 Feb 2010 14:37:14 +0200
Ilkka Koskinen <ilkka.koskinen@nokia.com> wrote:

>  static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp)
>  {
> -	if (cpu_is_omap34xx())
> +	if (cpu_is_omap34xx()) {
>  		omap_additional_remove(mcbsp->dev);
> +
> +		if (mcbsp->id == 2 || mcbsp->id == 3)
> +			omap_st_remove(mcbsp);
> +	}
>  }

Are you sure about these ids? Same comment to the patch 2 as well.
Worth to check.


-- 
Jarkko
