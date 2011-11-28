From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: convert sound/soc/codecs/* to use
 module_platform_driver()
Date: Mon, 28 Nov 2011 11:33:49 +0000
Message-ID: <20111128113348.GB2934@opensource.wolfsonmicro.com>
References: <1322477274.1939.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E907D245DC
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 12:33:51 +0100 (CET)
Content-Disposition: inline
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
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Marek Belisko <marek.belisko@open-nandra.com>, Bas Vermeulen <bas.vermeulen@novero.com>, Vinod Koul <vinod.koul@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Manjunathappa,
	Prakash" <prakash.pm@ti.com>, "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2011 at 06:47:54PM +0800, Axel Lin wrote:
> This patch converts the drivers in sound/soc/codecs/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.

I already did a patch for this.
