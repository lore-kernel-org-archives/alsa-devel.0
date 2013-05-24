From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5110: Correct DSP4R Mixer control name
Date: Fri, 24 May 2013 11:40:43 +0100
Message-ID: <1369392043-28932-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55EC62650C4
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 12:51:21 +0200 (CEST)
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

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index c00480b..ba38f06 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -190,7 +190,7 @@ ARIZONA_MIXER_CONTROLS("DSP2R", ARIZONA_DSP2RMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("DSP3L", ARIZONA_DSP3LMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("DSP3R", ARIZONA_DSP3RMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("DSP4L", ARIZONA_DSP4LMIX_INPUT_1_SOURCE),
-ARIZONA_MIXER_CONTROLS("DSP5R", ARIZONA_DSP4RMIX_INPUT_1_SOURCE),
+ARIZONA_MIXER_CONTROLS("DSP4R", ARIZONA_DSP4RMIX_INPUT_1_SOURCE),
 
 ARIZONA_MIXER_CONTROLS("Mic", ARIZONA_MICMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("Noise", ARIZONA_NOISEMIX_INPUT_1_SOURCE),
-- 
1.7.2.5
