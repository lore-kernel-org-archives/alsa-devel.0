From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-io: Add
 CONFIG_REGMAP_I2C/CONFIG_REGMAP_SPI guards for
 regmap_init_i2c/regmap_init_spi
Date: Thu, 11 Aug 2011 00:37:06 +0900
Message-ID: <20110810153705.GH5724@opensource.wolfsonmicro.com>
References: <1312964652.11589.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7CB17103813
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 17:37:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1312964652.11589.1.camel@phoenix>
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

On Wed, Aug 10, 2011 at 04:24:12PM +0800, Axel Lin wrote:
> In the case of "make da8xx_omapl_defconfig;make", the SPI support is disabled.
> Thus calling regmap_init_spi in soc-io.c has below build error.

Applied, thanks.
