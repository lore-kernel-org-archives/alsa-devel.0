From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v3 1/2] ASoC: max9860: switch to SPDX license
	tag
Date: Fri, 13 Apr 2018 13:47:50 +0200
Message-ID: <20180413114751.6464-2-peda@axentia.se>
References: <20180413111927.GC6854@sirena.org.uk>
 <20180413114751.6464-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0100.outbound.protection.outlook.com [104.47.0.100])
 by alsa0.perex.cz (Postfix) with ESMTP id EFB3926732C
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 13:48:12 +0200 (CEST)
In-Reply-To: <20180413114751.6464-1-peda@axentia.se>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

It's less overhead, clearer and generally neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/max9860.c | 31 +++++++++++--------------------
 sound/soc/codecs/max9860.h | 10 +---------
 2 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 53448b7b7b28..00df9f4e4a23 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -1,23 +1,14 @@
-/*
- * Driver for the MAX9860 Mono Audio Voice Codec
- *
- * https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf
- *
- * The driver does not support sidetone since the DVST register field is
- * backwards with the mute near the maximum level instead of the minimum.
- *
- * Author: Peter Rosin <peda@axentia.s>
- *         Copyright 2016 Axentia Technologies
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Driver for the MAX9860 Mono Audio Voice Codec
+//
+// https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf
+//
+// The driver does not support sidetone since the DVST register field is
+// backwards with the mute near the maximum level instead of the minimum.
+//
+// Author: Peter Rosin <peda@axentia.s>
+//         Copyright 2016 Axentia Technologies
 
 #include <linux/init.h>
 #include <linux/module.h>
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
