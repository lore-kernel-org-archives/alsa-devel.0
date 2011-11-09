From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Mark WM5100 MISC CONTROL as readable
Date: Wed,  9 Nov 2011 16:31:53 +0000
Message-ID: <1320856314-23012-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320856314-23012-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5046324397
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 17:31:58 +0100 (CET)
In-Reply-To: <1320856314-23012-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100-tables.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5100-tables.c b/sound/soc/codecs/wm5100-tables.c
index 8c6f3a7..48f957c 100644
--- a/sound/soc/codecs/wm5100-tables.c
+++ b/sound/soc/codecs/wm5100-tables.c
@@ -85,6 +85,7 @@ bool wm5100_readable_register(struct device *dev, unsigned int reg)
 	case WM5100_MIC_DETECT_1:
 	case WM5100_MIC_DETECT_2:
 	case WM5100_MIC_DETECT_3:
+	case WM5100_MISC_CONTROL:
 	case WM5100_INPUT_ENABLES:
 	case WM5100_INPUT_ENABLES_STATUS:
 	case WM5100_IN1L_CONTROL:
-- 
1.7.7.2
