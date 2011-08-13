From: Axel Lin <axel.lin@gmail.com>
Subject: [linux-next] ASoC: build failure with make eseries_pxa_defconfig
Date: Sat, 13 Aug 2011 10:12:01 +0800
Message-ID: <1313201521.12790.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi Mark,
In the case of build with "make eseries_pxa_defconfig;make",
both i2c and spi support are not configured.
Thus CONFIG_REGMAP is default to disable.

Then I got below build error:

ERROR: "regmap_raw_write" [sound/soc/snd-soc-core.ko] undefined!
ERROR: "regmap_read" [sound/soc/snd-soc-core.ko] undefined!
ERROR: "regmap_write" [sound/soc/snd-soc-core.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Regards,
Axel
