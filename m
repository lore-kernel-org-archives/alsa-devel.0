From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc/sh: Fix I2C dependency for
	SND_FSI_AK4642
Date: Mon, 14 Jun 2010 17:10:34 +0100
Message-ID: <20100614161034.GF14604@rakim.wolfsonmicro.main>
References: <201006141739.42346.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95C63246E6
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 18:10:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201006141739.42346.PeterHuewe@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Huewe <PeterHuewe@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 14, 2010 at 05:39:41PM +0200, Peter Huewe wrote:

>  	bool "FSI-AK4642 sound support"
>  	depends on SND_SOC_SH4_FSI
>  	select SND_SOC_AK4642
> +	select I2C

I'd have thought a depends was more appropriate.  Arguably you want to
depend on the SH I2C driver since the driver is useless without the
relevant I2C controller.
