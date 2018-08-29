From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3060: Improve stylistics of file
	comments" to the asoc tree
Date: Wed, 29 Aug 2018 12:31:35 +0100 (BST)
Message-ID: <20180829113135.471B61124859@debutante.sirena.org.uk>
References: <20180828214231.10164-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DE4426784A
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 13:31:36 +0200 (CEST)
In-Reply-To: <20180828214231.10164-1-kmarinushkin@birdec.tech>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, Mark Brown <broonie@kernel.org>, M R Swami Reddy <mr.swami.reddy@ti.com>, Kevin Cernekee <cernekee@chromium.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3060: Improve stylistics of file comments

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From aec785f6a0dcd68c3d2ad4a7d5b48d5fc94d75e8 Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Date: Tue, 28 Aug 2018 23:42:30 +0200
Subject: [PATCH] ASoC: pcm3060: Improve stylistics of file comments

Modified the complete file comments in C++ style, to make them look more
intentional

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3060-i2c.c | 9 ++++-----
 sound/soc/codecs/pcm3060-spi.c | 9 ++++-----
 sound/soc/codecs/pcm3060.c     | 9 ++++-----
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/pcm3060-i2c.c b/sound/soc/codecs/pcm3060-i2c.c
index 03d2b4323626..cdc8314882bc 100644
--- a/sound/soc/codecs/pcm3060-i2c.c
+++ b/sound/soc/codecs/pcm3060-i2c.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * PCM3060 I2C driver
- *
- * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
- */
+//
+// PCM3060 I2C driver
+//
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
 
 #include <linux/i2c.h>
 #include <linux/module.h>
diff --git a/sound/soc/codecs/pcm3060-spi.c b/sound/soc/codecs/pcm3060-spi.c
index 8961e095ae73..f6f19fa80932 100644
--- a/sound/soc/codecs/pcm3060-spi.c
+++ b/sound/soc/codecs/pcm3060-spi.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * PCM3060 SPI driver
- *
- * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
- */
+//
+// PCM3060 SPI driver
+//
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
 
 #include <linux/module.h>
 #include <linux/spi/spi.h>
diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index ef7c627c9ac5..5b9718fa766d 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * PCM3060 codec driver
- *
- * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
- */
+//
+// PCM3060 codec driver
+//
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
 
 #include <linux/module.h>
 #include <sound/pcm_params.h>
-- 
2.18.0
