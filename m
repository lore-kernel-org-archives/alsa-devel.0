From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH 2/2] ASoC: tlv320aic32x4: Update copyright and
	use SPDX identifier
Date: Wed,  3 Apr 2019 21:17:16 -0700
Message-ID: <20190404041716.29896-2-nh6z@nh6z.net>
References: <20190404041716.29896-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp121.iad3b.emailsrvr.com (smtp121.iad3b.emailsrvr.com
 [146.20.161.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0084F89631
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 06:17:25 +0200 (CEST)
In-Reply-To: <20190404041716.29896-1-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: team@nwdigitalradio.com
List-Id: alsa-devel@alsa-project.org

Update the copyright dates and use the SPDX identifier instead
of reciting the license.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4-i2c.c | 14 ++------------
 sound/soc/codecs/tlv320aic32x4-spi.c | 14 ++------------
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-i2c.c b/sound/soc/codecs/tlv320aic32x4-i2c.c
index 22c3a6bc0b6c..6d54cbf70a0b 100644
--- a/sound/soc/codecs/tlv320aic32x4-i2c.c
+++ b/sound/soc/codecs/tlv320aic32x4-i2c.c
@@ -1,21 +1,11 @@
-/*
- * linux/sound/soc/codecs/tlv320aic32x4-i2c.c
+/* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2011 NW Digital Radio
+ * Copyright 2011-2019 NW Digital Radio
  *
  * Author: Annaliese McDermond <nh6z@nh6z.net>
  *
  * Based on sound/soc/codecs/wm8974 and TI driver for kernel 2.6.27.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/i2c.h>
diff --git a/sound/soc/codecs/tlv320aic32x4-spi.c b/sound/soc/codecs/tlv320aic32x4-spi.c
index aa5b7ba0254b..a22e7700bfc8 100644
--- a/sound/soc/codecs/tlv320aic32x4-spi.c
+++ b/sound/soc/codecs/tlv320aic32x4-spi.c
@@ -1,21 +1,11 @@
-/*
- * linux/sound/soc/codecs/tlv320aic32x4-spi.c
+/* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2011 NW Digital Radio
+ * Copyright 2011-2019 NW Digital Radio
  *
  * Author: Annaliese McDermond <nh6z@nh6z.net>
  *
  * Based on sound/soc/codecs/wm8974 and TI driver for kernel 2.6.27.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/spi/spi.h>
-- 
2.19.1
