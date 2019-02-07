From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] ASoC: msm8916-wcd-digital: convert license
	header to SPDX
Date: Thu,  7 Feb 2019 17:57:54 +0100
Message-ID: <20190207165755.1548-3-johan@kernel.org>
References: <20190207165755.1548-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by alsa0.perex.cz (Postfix) with ESMTP id E9847267486
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2019 17:58:42 +0100 (CET)
Received: by mail-lf1-f68.google.com with SMTP id q11so431015lfd.3
 for <alsa-devel@alsa-project.org>; Thu, 07 Feb 2019 08:58:42 -0800 (PST)
In-Reply-To: <20190207165755.1548-1-johan@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

Convert the GPLv2-only license header to SPDX.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 3063dedd21cf..5273996b40d5 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -1,13 +1,6 @@
-/* Copyright (c) 2016, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/module.h>
-- 
2.20.1
