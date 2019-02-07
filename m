From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/3] ASoC: msm8916-wcd-analog: add missing license information
Date: Thu,  7 Feb 2019 17:57:53 +0100
Message-ID: <20190207165755.1548-2-johan@kernel.org>
References: <20190207165755.1548-1-johan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207165755.1548-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

Add the missing license and copyright information which never made it
into the analog driver when the original driver was split in two as part
of the review process.

Link: https://lkml.kernel.org/r/1465582725-30183-3-git-send-email-srinivas.kandagatla@linaro.org
Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index b7cf7cce95fe..1261ddff75eb 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1,3 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016, The Linux Foundation. All rights reserved.
+ */
+
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
-- 
2.20.1
