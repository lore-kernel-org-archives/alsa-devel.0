From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 1/2] ASoC: msm8916-wcd-analog: add missing
	license information
Date: Fri,  8 Feb 2019 16:16:55 +0100
Message-ID: <20190208151656.26735-2-johan@kernel.org>
References: <20190208151656.26735-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C5952674C9
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 16:17:16 +0100 (CET)
Received: by mail-lf1-f66.google.com with SMTP id n23so2804426lfl.4
 for <alsa-devel@alsa-project.org>; Fri, 08 Feb 2019 07:17:16 -0800 (PST)
In-Reply-To: <20190208151656.26735-1-johan@kernel.org>
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
Cc: alsa-devel@alsa-project.org, Johan Hovold <johan@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add the missing license and copyright information which never made it
into the analog driver when the original driver was split in two as part
of the review process.

Link: https://lkml.kernel.org/r/1465582725-30183-3-git-send-email-srinivas.kandagatla@linaro.org
Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index b7cf7cce95fe..368b6c09474b 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1,3 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2016, The Linux Foundation. All rights reserved.
+
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
-- 
2.20.1
