From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Add CS4271 codec support
Date: Wed, 6 Oct 2010 17:50:19 -0700
Message-ID: <20101007005018.GD30751@opensource.wolfsonmicro.com>
References: <4CAD16A5.1090501@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5FF2C1039DD
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 02:50:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CAD16A5.1090501@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, timur@freescale.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 07, 2010 at 01:39:01PM +1300, Ryan Mallon wrote:

> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -138,6 +138,9 @@ config SND_SOC_CS4270_VD33_ERRATA
>  	bool
>  	depends on SND_SOC_CS4270
>  
> +config SND_SOC_CS4271
> +	tristate
> +
>  config SND_SOC_CX20442
>  	tristate
>  

Oh, one actual problem: you should add the driver to SND_SOC_ALL_CODECS
too so we get build coverage for testing.
