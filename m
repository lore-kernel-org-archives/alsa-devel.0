From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: OMAP: Don't try to set unsupported
 OMAP_DMA_DATA_BURST_16 on OMAP1
Date: Wed, 21 Oct 2009 22:16:07 +0300
Message-ID: <20091021221607.c46f60e3.jhnikula@gmail.com>
References: <200910212035.42245.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f214.google.com (mail-fx0-f214.google.com
	[209.85.220.214])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B3F4243B3
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Oct 2009 21:15:23 +0200 (CEST)
Received: by fxm10 with SMTP id 10so17819660fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2009 12:15:22 -0700 (PDT)
In-Reply-To: <200910212035.42245.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, e3-hacking@earth.li
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Oct 2009 20:35:40 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

>  
> +	if (cpu_class_is_omap1())
> +		return 0;
> +
>  	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
>  	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
>  
I would have implemented this by "if (!cpu_class_is_omap1())
{..._burst_mode}" for making sure that no new OMAP1 error is introduced
in the future if there is need to add some common stuff after those
burst_mode calls and probably compiler can better optimize away those
burst_mode calls for OMAP1 builds.

-- 
Jarkko
