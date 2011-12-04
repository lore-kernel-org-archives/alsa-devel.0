From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix dependency for SND_SOC_RAUMFELD
 and SND_PXA2XX_SOC_HX4700
Date: Sun, 4 Dec 2011 23:40:19 +0000
Message-ID: <20111204234018.GC4346@opensource.wolfsonmicro.com>
References: <1322987418.22605.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F038C103998
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 00:40:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322987418.22605.4.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 04, 2011 at 04:30:18PM +0800, Axel Lin wrote:
> SND_SOC_RAUMFELD selects SND_SOC_CS4270 which needs CONFIG_I2C,
> and also selects SND_SOC_AK4104 which needs SPI_MASTER.

Applied, thanks.
