From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] MAINTAINERS: add msm mailing list to sound/soc/qcom
Date: Wed, 10 Feb 2016 10:35:44 +0000
Message-ID: <1455100544-1147-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds msm mailing list to sound/soc/qcom so that
get_maintainers would return correct list to CC to.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f1fa4f..213be2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5820,6 +5820,7 @@ F:	include/uapi/linux/ipmi*
 QCOM AUDIO (ASoC) DRIVERS
 M:	Patrick Lai <plai@codeaurora.org>
 M:	Banajit Goswami <bgoswami@codeaurora.org>
+L:	linux-arm-msm@vger.kernel.org
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/qcom/
-- 
1.9.1
