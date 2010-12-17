From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sh: fsi: remove unnecessary
 dependent from Kconfig
Date: Fri, 17 Dec 2010 12:55:52 +0000
Message-ID: <20101217125551.GE31453@rakim.wolfsonmicro.main>
References: <w3ptyidgioe.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A1D4824156
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 13:55:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <w3ptyidgioe.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 17, 2010 at 12:52:21PM +0900, Kuninori Morimoto wrote:

>  config SND_FSI_AK4642
>  	tristate "FSI-AK4642 sound support"
> -	depends on SND_SOC_SH4_FSI && I2C_SH_MOBILE
> +	depends on SND_SOC_SH4_FSI

Are you sure these boards work without I2C support in the kernel?
