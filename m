From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau17x1: Correct typos in file
	headers" to the asoc tree
Date: Wed, 24 Feb 2016 13:15:18 +0900
Message-ID: <E1aYQr8-0000qG-4l@finisterre>
References: <1454423510-1330-3-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1027793497512750398=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A7BE265E04
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 05:15:28 +0100 (CET)
In-Reply-To: <1454423510-1330-3-git-send-email-andire@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============1027793497512750398==
Content-Type: text/plain

The patch

   ASoC: adau17x1: Correct typos in file headers

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d6dde63e90cf0d34ae61e885a5eb254c59eb3358 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Date: Tue, 16 Feb 2016 13:56:42 +0100
Subject: [PATCH] ASoC: adau17x1: Correct typos in file headers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Andreas Irestål <andire@axis.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/platform_data/adau17x1.h | 2 +-
 sound/soc/codecs/adau1761-i2c.c        | 2 +-
 sound/soc/codecs/adau1761-spi.c        | 2 +-
 sound/soc/codecs/adau1761.c            | 2 +-
 sound/soc/codecs/adau1781.c            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/platform_data/adau17x1.h b/include/linux/platform_data/adau17x1.h
index a81766cae230..9db1b905df24 100644
--- a/include/linux/platform_data/adau17x1.h
+++ b/include/linux/platform_data/adau17x1.h
@@ -1,5 +1,5 @@
 /*
- * Driver for ADAU1761/ADAU1461/ADAU1761/ADAU1961/ADAU1781/ADAU1781 codecs
+ * Driver for ADAU1361/ADAU1461/ADAU1761/ADAU1961/ADAU1381/ADAU1781 codecs
  *
  * Copyright 2011-2014 Analog Devices Inc.
  * Author: Lars-Peter Clausen <lars@metafoo.de>
diff --git a/sound/soc/codecs/adau1761-i2c.c b/sound/soc/codecs/adau1761-i2c.c
index 348ccb17d3cc..a1b12671c307 100644
--- a/sound/soc/codecs/adau1761-i2c.c
+++ b/sound/soc/codecs/adau1761-i2c.c
@@ -1,5 +1,5 @@
 /*
- * Driver for ADAU1761/ADAU1461/ADAU1761/ADAU1961 codec
+ * Driver for ADAU1361/ADAU1461/ADAU1761/ADAU1961 codec
  *
  * Copyright 2014 Analog Devices Inc.
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
diff --git a/sound/soc/codecs/adau1761-spi.c b/sound/soc/codecs/adau1761-spi.c
index 8bc1fbd25fcc..188334928c23 100644
--- a/sound/soc/codecs/adau1761-spi.c
+++ b/sound/soc/codecs/adau1761-spi.c
@@ -1,5 +1,5 @@
 /*
- * Driver for ADAU1761/ADAU1461/ADAU1761/ADAU1961 codec
+ * Driver for ADAU1361/ADAU1461/ADAU1761/ADAU1961 codec
  *
  * Copyright 2014 Analog Devices Inc.
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index e7136b1956a3..b95d29dbd13d 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -1,5 +1,5 @@
 /*
- * Driver for ADAU1761/ADAU1461/ADAU1761/ADAU1961 codec
+ * Driver for ADAU1361/ADAU1461/ADAU1761/ADAU1961 codec
  *
  * Copyright 2011-2013 Analog Devices Inc.
  * Author: Lars-Peter Clausen <lars@metafoo.de>
diff --git a/sound/soc/codecs/adau1781.c b/sound/soc/codecs/adau1781.c
index fde9068550a6..bc1bb56dae63 100644
--- a/sound/soc/codecs/adau1781.c
+++ b/sound/soc/codecs/adau1781.c
@@ -1,5 +1,5 @@
 /*
- * Driver for ADAU1781/ADAU1781 codec
+ * Driver for ADAU1381/ADAU1781 codec
  *
  * Copyright 2011-2013 Analog Devices Inc.
  * Author: Lars-Peter Clausen <lars@metafoo.de>
-- 
2.7.0


--===============1027793497512750398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1027793497512750398==--
