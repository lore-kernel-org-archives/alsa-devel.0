From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: bells: Up to 512fs
Date: Thu, 15 Nov 2012 13:56:35 +0000
Message-ID: <1352987795-20780-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 496D1265B6A
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 14:58:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Optimize performance by providing a 512fs based clkin.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/bells.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index 3d7ace7..b5065ee 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -28,7 +28,7 @@
 #define MCLK_RATE 24576000
 
 #define SYS_AUDIO_RATE 44100
-#define SYS_MCLK_RATE  (SYS_AUDIO_RATE * 256)
+#define SYS_MCLK_RATE  (SYS_AUDIO_RATE * 512)
 
 #define DAI_AP_DSP    0
 #define DAI_DSP_CODEC 1
-- 
1.8.0
