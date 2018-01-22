From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98373 Changed SPDX header in C++ comments style" to the asoc tree
Date: Mon, 22 Jan 2018 12:26:27 +0000
Message-ID: <E1edbBD-0004br-F9@debutante>
References: <1516311423-3148-1-git-send-email-ryans.lee@maximintegrated.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516311423-3148-1-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc: Ryan Lee <ryans.lee@maximintegrated.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.comryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ryan.lee.maxim@gmail.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98373 Changed SPDX header in C++ comments style

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

>From 180cad3c58ac435cc96f11b7f9d65b4886d62e30 Mon Sep 17 00:00:00 2001
From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Date: Thu, 18 Jan 2018 13:37:03 -0800
Subject: [PATCH] ASoC: max98373 Changed SPDX header in C++ comments style

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 4 ++--
 sound/soc/codecs/max98373.h | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 31b0864583e8..562e88765129 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2017, Maxim Integrated */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017, Maxim Integrated
 
 #include <linux/acpi.h>
 #include <linux/i2c.h>
diff --git a/sound/soc/codecs/max98373.h b/sound/soc/codecs/max98373.h
index d0b359d0cf8c..f6a37aa02f26 100644
--- a/sound/soc/codecs/max98373.h
+++ b/sound/soc/codecs/max98373.h
@@ -1,5 +1,6 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2017, Maxim Integrated */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017, Maxim Integrated
+
 #ifndef _MAX98373_H
 #define _MAX98373_H
 
-- 
2.15.1
