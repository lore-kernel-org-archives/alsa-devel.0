From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: bells: Up clock rate to 48kHz and 512fs
Date: Fri,  2 Nov 2012 10:44:36 +0000
Message-ID: <1351853076-3936-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 96E84264FFA
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 11:46:25 +0100 (CET)
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

The current WM0010 firmware images expect a 48kHz * 512fs
clkin.

Change-Id: I46f3f030175ebcbe9be75d01482379021510f459
Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/bells.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index 3d7ace7..c8ac240 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -27,8 +27,8 @@
  */
 #define MCLK_RATE 24576000
 
-#define SYS_AUDIO_RATE 44100
-#define SYS_MCLK_RATE  (SYS_AUDIO_RATE * 256)
+#define SYS_AUDIO_RATE 48000
+#define SYS_MCLK_RATE  (SYS_AUDIO_RATE * 512)
 
 #define DAI_AP_DSP    0
 #define DAI_DSP_CODEC 1
-- 
1.8.0
