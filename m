From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH] ASoC: convert sound/soc/codecs/* to use
 module_platform_driver()
Date: Tue, 29 Nov 2011 13:19:42 +0200
Message-ID: <1322565582.5588.4.camel@trdhcp003120.localdomain>
References: <1322477274.1939.2.camel@phoenix>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 34F1110395F
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 12:09:52 +0100 (CET)
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
To: ext Axel Lin <axel.lin@gmail.com>
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Marek Belisko <marek.belisko@open-nandra.com>, Bas Vermeulen <bas.vermeulen@novero.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Manjunathappa,
	Prakash" <prakash.pm@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, 2011-11-28 at 18:47 +0800, ext Axel Lin wrote:
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

>  sound/soc/codecs/wl1273.c            |   15 ++-------------

For the above mentioned wl1273 codec:

Acked-by: Matti J. Aaltonen <matti.j.aaltonen@nokia.com>
