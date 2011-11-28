From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: convert sound/soc/codecs/* to use
	module_platform_driver()
Date: Mon, 28 Nov 2011 13:06:09 +0200
Message-ID: <9272741.UCRmmteVYg@barack>
References: <1322477274.1939.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog118.obsmtp.com (na3sys009aog118.obsmtp.com
	[74.125.149.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FCF7243BD
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 12:06:00 +0100 (CET)
Received: by bkbzv3 with SMTP id zv3so11814823bkb.39
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 03:05:57 -0800 (PST)
In-Reply-To: <1322477274.1939.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Marek Belisko <marek.belisko@open-nandra.com>, Bas Vermeulen <bas.vermeulen@novero.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@linux.intel.com>, "Manjunathappa,
	Prakash" <prakash.pm@ti.com>, "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Monday 28 November 2011 18:47:54 Axel Lin wrote:
> This patch converts the drivers in sound/soc/codecs/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.
> 
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Bas Vermeulen <bas.vermeulen@novero.com>
> Cc: "Manjunathappa, Prakash" <prakash.pm@ti.com>
> Cc: Misael Lopez Cruz <misael.lopez@ti.com>
> Cc: Vinod Koul <vinod.koul@linux.intel.com>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>
> Cc: Marek Belisko <marek.belisko@open-nandra.com>
> Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---

...

>  sound/soc/codecs/twl4030.c           |   15 ++-------------
>  sound/soc/codecs/twl6040.c           |   12 +-----------

For these:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
