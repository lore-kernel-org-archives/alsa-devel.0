From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add Phytec i.MX sound support for AC97
Date: Tue, 9 Feb 2010 19:53:22 +0000
Message-ID: <20100209195322.GA13437@opensource.wolfsonmicro.com>
References: <20100209101428.GG17643@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 02AEB10381C
	for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2010 20:53:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100209101428.GG17643@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 09, 2010 at 11:14:28AM +0100, Sascha Hauer wrote:

>  config SND_IMX_SOC
>  	tristate "SoC Audio for Freecale i.MX CPUs"
> -	depends on ARCH_MXC && BROKEN
> +	depends on ARCH_MXC

BTW, this should not be here - we still need to wait for the arch/arm
side of things to merge in before the drivers will work.
