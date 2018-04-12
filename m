From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 3/5] ASoC: max9860: switch to SPDX license tag
Date: Thu, 12 Apr 2018 23:14:35 +0200
Message-ID: <20180412211437.21599-4-peda@axentia.se>
References: <20180412161601.GI9929@sirena.org.uk>
 <20180412211437.21599-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180412211437.21599-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It's less overhead, clearer and generally neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/max9860.c | 10 +---------
 sound/soc/codecs/max9860.h | 10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 53448b7b7b28..21c70cd5dcf6 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for the MAX9860 Mono Audio Voice Codec
  *
@@ -8,15 +9,6 @@
  *
  * Author: Peter Rosin <peda@axentia.s>
  *         Copyright 2016 Axentia Technologies
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 #include <linux/init.h>
diff --git a/sound/soc/codecs/max9860.h b/sound/soc/codecs/max9860.h
index 22041bd67a7d..e07b905eaf50 100644
--- a/sound/soc/codecs/max9860.h
+++ b/sound/soc/codecs/max9860.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Driver for the MAX9860 Mono Audio Voice Codec
  *
  * Author: Peter Rosin <peda@axentia.s>
  *         Copyright 2016 Axentia Technologies
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 #ifndef _SND_SOC_MAX9860
-- 
2.11.0
