From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 15/47] ASoC: remove blackfin drivers
Date: Wed, 14 Mar 2018 16:35:28 +0100
Message-ID: <20180314153603.3127932-16-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by alsa0.perex.cz (Postfix) with ESMTP id B5147267338
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 16:42:18 +0100 (CET)
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The blackfin architecture is getting removed, so the ASoC drivers
are all obsolete as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                             |    7 -
 sound/soc/Kconfig                       |    1 -
 sound/soc/Makefile                      |    1 -
 sound/soc/blackfin/Kconfig              |  205 ------
 sound/soc/blackfin/Makefile             |   40 --
 sound/soc/blackfin/bf5xx-ac97-pcm.c     |  480 --------------
 sound/soc/blackfin/bf5xx-ac97.c         |  388 -----------
 sound/soc/blackfin/bf5xx-ac97.h         |   57 --
 sound/soc/blackfin/bf5xx-ad1836.c       |  109 ---
 sound/soc/blackfin/bf5xx-ad193x.c       |  131 ----
 sound/soc/blackfin/bf5xx-ad1980.c       |  109 ---
 sound/soc/blackfin/bf5xx-ad73311.c      |  212 ------
 sound/soc/blackfin/bf5xx-i2s-pcm.c      |  373 -----------
 sound/soc/blackfin/bf5xx-i2s-pcm.h      |   17 -
 sound/soc/blackfin/bf5xx-i2s.c          |  391 -----------
 sound/soc/blackfin/bf5xx-sport.c        | 1102 -------------------------------
 sound/soc/blackfin/bf5xx-sport.h        |  174 -----
 sound/soc/blackfin/bf5xx-ssm2602.c      |  126 ----
 sound/soc/blackfin/bf6xx-i2s.c          |  239 -------
 sound/soc/blackfin/bf6xx-sport.c        |  425 ------------
 sound/soc/blackfin/bf6xx-sport.h        |   82 ---
 sound/soc/blackfin/bfin-eval-adau1373.c |  173 -----
 sound/soc/blackfin/bfin-eval-adau1701.c |  113 ----
 sound/soc/blackfin/bfin-eval-adau1x61.c |  142 ----
 sound/soc/blackfin/bfin-eval-adau1x81.c |  129 ----
 sound/soc/blackfin/bfin-eval-adav80x.c  |  145 ----
 26 files changed, 5371 deletions(-)
 delete mode 100644 sound/soc/blackfin/Kconfig
 delete mode 100644 sound/soc/blackfin/Makefile
 delete mode 100644 sound/soc/blackfin/bf5xx-ac97-pcm.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ac97.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ac97.h
 delete mode 100644 sound/soc/blackfin/bf5xx-ad1836.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ad193x.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ad1980.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ad73311.c
 delete mode 100644 sound/soc/blackfin/bf5xx-i2s-pcm.c
 delete mode 100644 sound/soc/blackfin/bf5xx-i2s-pcm.h
 delete mode 100644 sound/soc/blackfin/bf5xx-i2s.c
 delete mode 100644 sound/soc/blackfin/bf5xx-sport.c
 delete mode 100644 sound/soc/blackfin/bf5xx-sport.h
 delete mode 100644 sound/soc/blackfin/bf5xx-ssm2602.c
 delete mode 100644 sound/soc/blackfin/bf6xx-i2s.c
 delete mode 100644 sound/soc/blackfin/bf6xx-sport.c
 delete mode 100644 sound/soc/blackfin/bf6xx-sport.h
 delete mode 100644 sound/soc/blackfin/bfin-eval-adau1373.c
 delete mode 100644 sound/soc/blackfin/bfin-eval-adau1701.c
 delete mode 100644 sound/soc/blackfin/bfin-eval-adau1x61.c
 delete mode 100644 sound/soc/blackfin/bfin-eval-adau1x81.c
 delete mode 100644 sound/soc/blackfin/bfin-eval-adav80x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 64cd083b60ef..6eb7387bb1e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -841,13 +841,6 @@ F:	sound/soc/codecs/ad7*
 F:	sound/soc/codecs/ssm*
 F:	sound/soc/codecs/sigmadsp.*
 
-ANALOG DEVICES INC ASOC DRIVERS
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org/
-S:	Supported
-F:	sound/soc/blackfin/*
-
 ANALOG DEVICES INC DMA DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 W:	http://ez.analog.com/community/linux-device-drivers
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 84c3582f3982..41af6b9cc350 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -45,7 +45,6 @@ source "sound/soc/amd/Kconfig"
 source "sound/soc/atmel/Kconfig"
 source "sound/soc/au1x/Kconfig"
 source "sound/soc/bcm/Kconfig"
-source "sound/soc/blackfin/Kconfig"
 source "sound/soc/cirrus/Kconfig"
 source "sound/soc/davinci/Kconfig"
 source "sound/soc/dwc/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 74cd1858d38b..8d92492183d2 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_SND_SOC)	+= amd/
 obj-$(CONFIG_SND_SOC)	+= atmel/
 obj-$(CONFIG_SND_SOC)	+= au1x/
 obj-$(CONFIG_SND_SOC)	+= bcm/
-obj-$(CONFIG_SND_SOC)	+= blackfin/
 obj-$(CONFIG_SND_SOC)	+= cirrus/
 obj-$(CONFIG_SND_SOC)	+= davinci/
 obj-$(CONFIG_SND_SOC)	+= dwc/
diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
deleted file mode 100644
index 6410aa2cc2cf..000000000000
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
deleted file mode 100644
index ebeb6a9cedd2..000000000000
diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
deleted file mode 100644
index 08bceb519c29..000000000000
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
deleted file mode 100644
index a040cfe29fc0..000000000000
diff --git a/sound/soc/blackfin/bf5xx-ac97.h b/sound/soc/blackfin/bf5xx-ac97.h
deleted file mode 100644
index a680fdc9bb42..000000000000
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
deleted file mode 100644
index 864df2616e10..000000000000
diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
deleted file mode 100644
index 603ad1f2b9b9..000000000000
diff --git a/sound/soc/blackfin/bf5xx-ad1980.c b/sound/soc/blackfin/bf5xx-ad1980.c
deleted file mode 100644
index 0fa81a523b8a..000000000000
diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
deleted file mode 100644
index 786bbdd96e7c..000000000000
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
deleted file mode 100644
index 6712b01dabd1..000000000000
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.h b/sound/soc/blackfin/bf5xx-i2s-pcm.h
deleted file mode 100644
index 1f0435249f88..000000000000
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
deleted file mode 100644
index b69aeef6418e..000000000000
diff --git a/sound/soc/blackfin/bf5xx-sport.c b/sound/soc/blackfin/bf5xx-sport.c
deleted file mode 100644
index 9dfa1241ea66..000000000000
diff --git a/sound/soc/blackfin/bf5xx-sport.h b/sound/soc/blackfin/bf5xx-sport.h
deleted file mode 100644
index 9fc2192feb3b..000000000000
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
deleted file mode 100644
index 9c19ccc936e2..000000000000
diff --git a/sound/soc/blackfin/bf6xx-i2s.c b/sound/soc/blackfin/bf6xx-i2s.c
deleted file mode 100644
index 819cff149a25..000000000000
diff --git a/sound/soc/blackfin/bf6xx-sport.c b/sound/soc/blackfin/bf6xx-sport.c
deleted file mode 100644
index d2caadfe7b6d..000000000000
diff --git a/sound/soc/blackfin/bf6xx-sport.h b/sound/soc/blackfin/bf6xx-sport.h
deleted file mode 100644
index 307d193cfcef..000000000000
diff --git a/sound/soc/blackfin/bfin-eval-adau1373.c b/sound/soc/blackfin/bfin-eval-adau1373.c
deleted file mode 100644
index 64b88fdc1f6c..000000000000
diff --git a/sound/soc/blackfin/bfin-eval-adau1701.c b/sound/soc/blackfin/bfin-eval-adau1701.c
deleted file mode 100644
index 5c67f72cf9a9..000000000000
diff --git a/sound/soc/blackfin/bfin-eval-adau1x61.c b/sound/soc/blackfin/bfin-eval-adau1x61.c
deleted file mode 100644
index fddfe00c9d69..000000000000
diff --git a/sound/soc/blackfin/bfin-eval-adau1x81.c b/sound/soc/blackfin/bfin-eval-adau1x81.c
deleted file mode 100644
index 3e01cbe53fc7..000000000000
diff --git a/sound/soc/blackfin/bfin-eval-adav80x.c b/sound/soc/blackfin/bfin-eval-adav80x.c
deleted file mode 100644
index 99e5ecabdcda..000000000000
-- 
2.9.0
