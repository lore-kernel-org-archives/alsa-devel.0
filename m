From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: OMAP: Kconfig string cleanup
Date: Tue, 13 Dec 2011 16:31:20 +0800
Message-ID: <20111213083119.GJ7148@opensource.wolfsonmicro.com>
References: <1323765017-31943-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A5EE103AF7
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 09:31:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323765017-31943-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 13, 2011 at 10:30:17AM +0200, Peter Ujfalusi wrote:

> -	tristate "SoC Audio for the Texas Instruments OMAP chips"
> +	tristate "SoC Audio for Texas Instruments OMAP based boards"
>  	depends on ARCH_OMAP

> -	tristate "SoC Audio support for Nokia N810"
> +	tristate "Audio support for Nokia N810"

You should probably make your mind up if it's SoC audio or just plain
audio.  I don't mind which, I just noticed the variation.
