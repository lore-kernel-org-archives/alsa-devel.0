From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 3/6] ASoC: WM8903: Fix mic detection issues
Date: Thu,  3 Feb 2011 13:56:15 -0700
Message-ID: <1296766578-13988-3-git-send-email-swarren@nvidia.com>
References: <1296766578-13988-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 744A4103863
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 21:56:28 +0100 (CET)
In-Reply-To: <1296766578-13988-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

wm8903.h:
* There is no hysteresis enable field in the current datasheet.
* Mic detection threshold field is only 2 bits wide.

wm8903.c:
* Mic detection HW should be enabled if SW wants either mic detection or
  short detection, rather than only when it wants both.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/sound/wm8903.h    |   10 +++-------
 sound/soc/codecs/wm8903.c |    2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/sound/wm8903.h b/include/sound/wm8903.h
index 86172cf..cf7ccb7 100644
--- a/include/sound/wm8903.h
+++ b/include/sound/wm8903.h
@@ -17,13 +17,9 @@
 /*
  * R6 (0x06) - Mic Bias Control 0
  */
-#define WM8903_MICDET_HYST_ENA                  0x0080  /* MICDET_HYST_ENA */
-#define WM8903_MICDET_HYST_ENA_MASK             0x0080  /* MICDET_HYST_ENA */
-#define WM8903_MICDET_HYST_ENA_SHIFT                 7  /* MICDET_HYST_ENA */
-#define WM8903_MICDET_HYST_ENA_WIDTH                 1  /* MICDET_HYST_ENA */
-#define WM8903_MICDET_THR_MASK                  0x0070  /* MICDET_THR - [6:4] */
-#define WM8903_MICDET_THR_SHIFT                      4  /* MICDET_THR - [6:4] */
-#define WM8903_MICDET_THR_WIDTH                      3  /* MICDET_THR - [6:4] */
+#define WM8903_MICDET_THR_MASK                  0x0030  /* MICDET_THR - [5:4] */
+#define WM8903_MICDET_THR_SHIFT                      4  /* MICDET_THR - [5:4] */
+#define WM8903_MICDET_THR_WIDTH                      2  /* MICDET_THR - [5:4] */
 #define WM8903_MICSHORT_THR_MASK                0x000C  /* MICSHORT_THR - [3:2] */
 #define WM8903_MICSHORT_THR_SHIFT                    2  /* MICSHORT_THR - [3:2] */
 #define WM8903_MICSHORT_THR_WIDTH                    2  /* MICSHORT_THR - [3:2] */
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 3d4c55f..dc96573 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1489,7 +1489,7 @@ int wm8903_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 			    WM8903_MICDET_EINT | WM8903_MICSHRT_EINT,
 			    irq_mask);
 
-	if (det && shrt) {
+	if (det || shrt) {
 		/* Enable mic detection, this may not have been set through
 		 * platform data (eg, if the defaults are OK). */
 		snd_soc_update_bits(codec, WM8903_WRITE_SEQUENCER_0,
-- 
1.7.1
