From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: fsl_spdif: Remove redundant semicolon
Date: Fri, 13 Sep 2013 15:52:42 +0530
Message-ID: <1379067762-4881-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id B5BAD2608ED
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 12:40:53 +0200 (CEST)
Received: by mail-pa0-f54.google.com with SMTP id kx10so2373628pab.13
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 03:40:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sachin.kamat@linaro.org, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

Redundant semicolon at the end of brace is removed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/fsl/fsl_spdif.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 3920c3e..c0fea02 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -963,7 +963,7 @@ static bool fsl_spdif_readable_reg(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static bool fsl_spdif_writeable_reg(struct device *dev, unsigned int reg)
@@ -982,7 +982,7 @@ static bool fsl_spdif_writeable_reg(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static const struct regmap_config fsl_spdif_regmap_config = {
-- 
1.7.9.5
