From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 01/10] ASoC: tlv320aic32x4: Remove filename
	from header and switch to SPDX
Date: Tue, 12 Dec 2017 16:43:02 -0600
Message-ID: <20171212224311.24045-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id A13E22671EC
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 23:43:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F .
 Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The filename is often wrong after moves and adds nothing of value,
lets drop it. While already here, switch to SPDX.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic32x4-i2c.c | 13 +------------
 sound/soc/codecs/tlv320aic32x4-spi.c | 13 +------------
 sound/soc/codecs/tlv320aic32x4.c     | 18 +-----------------
 sound/soc/codecs/tlv320aic32x4.h     |  9 +--------
 4 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-i2c.c b/sound/soc/codecs/tlv320aic32x4-i2c.c
index 385fa2e9525a..106da31e9541 100644
--- a/sound/soc/codecs/tlv320aic32x4-i2c.c
+++ b/sound/soc/codecs/tlv320aic32x4-i2c.c
@@ -1,21 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * linux/sound/soc/codecs/tlv320aic32x4-i2c.c
- *
  * Copyright 2011 NW Digital Radio
  *
  * Author: Jeremy McDermond <nh6z@nh6z.net>
  *
  * Based on sound/soc/codecs/wm8974 and TI driver for kernel 2.6.27.
- *
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
index 07d78ae51e05..c4619f65d427 100644
--- a/sound/soc/codecs/tlv320aic32x4-spi.c
+++ b/sound/soc/codecs/tlv320aic32x4-spi.c
@@ -1,21 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * linux/sound/soc/codecs/tlv320aic32x4-spi.c
- *
  * Copyright 2011 NW Digital Radio
  *
  * Author: Jeremy McDermond <nh6z@nh6z.net>
  *
  * Based on sound/soc/codecs/wm8974 and TI driver for kernel 2.6.27.
- *
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
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e694f5f04eb9..c0ccf3f23a04 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -1,26 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * linux/sound/soc/codecs/tlv320aic32x4.c
- *
  * Copyright 2011 Vista Silicon S.L.
  *
  * Author: Javier Martin <javier.martin@vista-silicon.com>
  *
  * Based on sound/soc/codecs/wm8974 and TI driver for kernel 2.6.27.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index da7cec482bcb..86552343b752 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -1,11 +1,4 @@
-/*
- * tlv320aic32x4.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
+// SPDX-License-Identifier: GPL-2.0
 
 #ifndef _TLV320AIC32X4_H
 #define _TLV320AIC32X4_H
-- 
2.15.0
