From: Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 01/30] mfd: cros_ec: Update license term
Date: Mon,  3 Jun 2019 11:33:32 -0700
Message-ID: <20190603183401.151408-2-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: enric.balletbo@collabora.com, bleung@chromium.org, groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org, broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com, fabien.lahoudere@collabora.com
Cc: linux-iio@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
List-Id: alsa-devel@alsa-project.org

Update to SPDX-License-Identifier, GPL-2.0

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
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
