From: Axel Lin <axel.lin@gmail.com>
Subject: ASoC: Build error if CONFIG_I2C=m && CONFIG_SND_SOC=y
Date: Tue, 06 Dec 2011 20:43:24 +0800
Message-ID: <1323175404.30623.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DE4F21039FD
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 13:43:37 +0100 (CET)
Received: by ggnv5 with SMTP id v5so6272481ggn.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Dec 2011 04:43:35 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,
I got below build error if CONFIG_I2C=m && CONFIG_SND_SOC=y.

  LD      vmlinux
sound/built-in.o: In function `snd_soc_codec_set_cache_io':
last.c:(.text+0x2a0a8): undefined reference to `regmap_init_i2c'
make: *** [vmlinux] Error 1

( I test the build on linux-next 20111206 )

Regards,
Axel
