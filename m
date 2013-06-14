From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5110: Correct rate control for DSP4
Date: Fri, 14 Jun 2013 14:19:36 +0100
Message-ID: <1371215976-24616-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 33CD2261AF0
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 15:34:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Reported-by: Dennis May <dennis.may@wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3470b64..0a3c7f7 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -279,7 +279,7 @@ static const struct soc_enum wm_adsp2_rate_enum[] = {
 			      ARIZONA_DSP1_RATE_SHIFT, 0xf,
 			      ARIZONA_RATE_ENUM_SIZE,
 			      arizona_rate_text, arizona_rate_val),
-	SOC_VALUE_ENUM_SINGLE(ARIZONA_DSP3_CONTROL_1,
+	SOC_VALUE_ENUM_SINGLE(ARIZONA_DSP4_CONTROL_1,
 			      ARIZONA_DSP1_RATE_SHIFT, 0xf,
 			      ARIZONA_RATE_ENUM_SIZE,
 			      arizona_rate_text, arizona_rate_val),
-- 
1.7.2.5
