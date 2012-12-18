From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Correct FLL source definitions
Date: Tue, 18 Dec 2012 14:08:16 +0000
Message-ID: <1355839696-17029-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 18C83261615
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2012 15:08:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The FLL source constants were numbered as a simple enumeration but were
being used in the code as direct values to be written to the registers.
Renumber the constants to reflect the usage.

Reported-by: Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 7f22b4f..68dfae5 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -34,15 +34,15 @@
 
 #define ARIZONA_FLL_SRC_MCLK1      0
 #define ARIZONA_FLL_SRC_MCLK2      1
-#define ARIZONA_FLL_SRC_SLIMCLK    2
-#define ARIZONA_FLL_SRC_FLL1       3
-#define ARIZONA_FLL_SRC_FLL2       4
-#define ARIZONA_FLL_SRC_AIF1BCLK   5
-#define ARIZONA_FLL_SRC_AIF2BCLK   6
-#define ARIZONA_FLL_SRC_AIF3BCLK   7
-#define ARIZONA_FLL_SRC_AIF1LRCLK  8
-#define ARIZONA_FLL_SRC_AIF2LRCLK  9
-#define ARIZONA_FLL_SRC_AIF3LRCLK 10
+#define ARIZONA_FLL_SRC_SLIMCLK    3
+#define ARIZONA_FLL_SRC_FLL1       4
+#define ARIZONA_FLL_SRC_FLL2       5
+#define ARIZONA_FLL_SRC_AIF1BCLK   8
+#define ARIZONA_FLL_SRC_AIF2BCLK   9
+#define ARIZONA_FLL_SRC_AIF3BCLK  10
+#define ARIZONA_FLL_SRC_AIF1LRCLK 12
+#define ARIZONA_FLL_SRC_AIF2LRCLK 13
+#define ARIZONA_FLL_SRC_AIF3LRCLK 14
 
 #define ARIZONA_MIXER_VOL_MASK             0x00FE
 #define ARIZONA_MIXER_VOL_SHIFT                 1
-- 
1.7.10.4
