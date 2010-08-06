From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: multi-comp: OMAP2, 3,
 4 McBSP: register correct number of ports
Date: Fri, 6 Aug 2010 11:08:08 +0300
Message-ID: <20100806110808.8452ec7a.jhnikula@gmail.com>
References: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
	<1281080355-22589-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9414F103965
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 10:07:00 +0200 (CEST)
Received: by eye27 with SMTP id 27so2564176eye.38
	for <alsa-devel@alsa-project.org>; Fri, 06 Aug 2010 01:07:00 -0700 (PDT)
In-Reply-To: <1281080355-22589-4-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: jkrzyszt@tis.icnet.pl, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, arunks@mistralsolutions.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri,  6 Aug 2010 10:39:15 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

>  static void omap_init_audio(void)
>  {
>  	platform_device_register(&omap_mcbsp1);
>  	platform_device_register(&omap_mcbsp2);
> +#ifdef OMAP_HAS_4_MCBSP_PORTS
>  	platform_device_register(&omap_mcbsp3);
>  	platform_device_register(&omap_mcbsp4);
> +#endif
> +#ifdef OMAP_HAS_5_MCBSP_PORTS
>  	platform_device_register(&omap_mcbsp5);
> +#endif
>  	platform_device_register(&omap_pcm);
>  }
>  
This must be done at runtime since we can have multi omap builds now.
So use cpu_is_omapxxx instead of conditional compilation. Simplifies
patch too :-)


-- 
Jarkko
