From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-next] ASoC: build failure with make
	eseries_pxa_defconfig
Date: Sat, 13 Aug 2011 11:51:40 +0900
Message-ID: <20110813025139.GA32506@opensource.wolfsonmicro.com>
References: <1313201521.12790.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C522D1037E3
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Aug 2011 04:51:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313201521.12790.2.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 13, 2011 at 10:12:01AM +0800, Axel Lin wrote:

> In the case of build with "make eseries_pxa_defconfig;make",
> both i2c and spi support are not configured.
> Thus CONFIG_REGMAP is default to disable.

Meh, right.  This is all due to Grant insisting on having direct
registration functions for each bus, previously we could just select
regmap.
