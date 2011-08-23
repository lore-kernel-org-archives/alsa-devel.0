From: Axel Lin <axel.lin@gmail.com>
Subject: [linux-next] ASoC: build failure if CONFIG_I2C=m && CONFIG_SPI=y
 && CONFIG_SND_SOC=y
Date: Tue, 23 Aug 2011 19:46:00 +0800
Message-ID: <1314099960.13722.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


hi,
I got below build failure if CONFIG_I2C=m && CONFIG_SPI=y && CONFIG_SND_SOC=y

  LD      .tmp_vmlinux1
sound/built-in.o: In function `snd_soc_codec_set_cache_io':
last.c:(.text+0x1cb80): undefined reference to `regmap_init_i2c'
make: *** [.tmp_vmlinux1] Error 1

Regards,
Axel
