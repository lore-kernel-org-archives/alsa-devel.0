From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH] ASoC: max98373 Changed SPDX header in C++ comments style
Date: Thu, 18 Jan 2018 13:37:03 -0800
Message-ID: <1516311423-3148-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Chagelog:
    Changed SPDX header in C comment-style to C++ comment style

 sound/soc/codecs/max98373.c | 4 ++--
 sound/soc/codecs/max98373.h | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 31b0864..562e887 100644
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
index d0b359d..f6a37aa 100644
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
2.7.4
