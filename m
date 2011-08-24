From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-next] ASoC: build failure if CONFIG_I2C=m
 && CONFIG_SPI=y && CONFIG_SND_SOC=y
Date: Wed, 24 Aug 2011 10:29:41 +0100
Message-ID: <20110824092941.GC15687@opensource.wolfsonmicro.com>
References: <1314099960.13722.1.camel@phoenix>
	<20110823104253.d7768c82.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DFFD72497F
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 11:29:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110823104253.d7768c82.rdunlap@xenotime.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 23, 2011 at 10:42:53AM -0700, Randy Dunlap wrote:

> I don't know if this is the same failure or just similar:

> ERROR: "regmap_exit" [drivers/mfd/wm8400-core.ko] undefined!

No, that's totally unrelated.  Fixed now.
