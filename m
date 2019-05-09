From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 01/30] mfd: cros_ec: Update license term
Date: Thu,  9 May 2019 14:13:24 -0700
Message-ID: <20190509211353.213194-2-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE3FFF89673
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2019 23:14:05 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id v80so1963243pfa.3
 for <alsa-devel@alsa-project.org>; Thu, 09 May 2019 14:14:05 -0700 (PDT)
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: enric.balletbo@collabora.com, bleung@chromium.org, groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org, broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc: linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Update to SPDX-License-Identifier, GPL-2.0

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index dcec96f01879..48292d449921 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1,25 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Host communication command constants for ChromeOS EC
  *
  * Copyright (C) 2012 Google, Inc
  *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * The ChromeOS EC multi function device is used to mux all the requests
- * to the EC device for its multiple features: keyboard controller,
- * battery charging and regulator control, firmware update.
- *
- * NOTE: This file is copied verbatim from the ChromeOS EC Open Source
- * project in an attempt to make future updates easy to make.
+ * NOTE: This file is auto-generated from ChromeOS EC Open Source code from
+ * https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
  */
 
+/* Host communication command constants for Chrome EC */
+
 #ifndef __CROS_EC_COMMANDS_H
 #define __CROS_EC_COMMANDS_H
 
-- 
2.21.0.1020.gf2820cf01a-goog
