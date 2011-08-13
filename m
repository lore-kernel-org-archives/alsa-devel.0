From: Axel Lin <axel.lin@gmail.com>
Subject: [linux-next] ASoC: sound/soc/samsung/i2s.c build failure
Date: Sat, 13 Aug 2011 12:00:43 +0800
Message-ID: <1313208043.29596.11.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  CC      sound/soc/samsung/i2s.o
sound/soc/samsung/i2s.c:24:18: error: idma.h: No such file or directory
sound/soc/samsung/i2s.c: In function 'samsung_i2s_dai_probe':
sound/soc/samsung/i2s.c:883: error: implicit declaration of function 'idma_reg_addr_init'
make[3]: *** [sound/soc/samsung/i2s.o] Error 1
make[2]: *** [sound/soc/samsung] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

It is caused by commit a0c27ab2421c47dc7c53f797fffcc0d17cdb122c
ASoC: Revert "ASoC: SAMSUNG: Add I2S0 internal dma driver"

To fix the build error, I think we also need to revert
commit 61100f405de5c16a0866de7843ed442090436e6a
"ASoC: SAMSUNG: Modify I2S driver to support idma".


Regards,
Axel
