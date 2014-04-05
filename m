From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5110: Add in OSR controls for OUT5/6
Date: Sat,  5 Apr 2014 12:11:48 +0100
Message-ID: <1396696308-1814-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A62CB2615B6
 for <alsa-devel@alsa-project.org>; Sat,  5 Apr 2014 13:20:02 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

There are no OSR controls on outputs 1-4 on wm5110, however when these
were removed the ones on output 5 and 6 were also accidentally removed,
but those actually exist. This patch adds these controls back in.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index df5a38d..83a7e2f 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -367,6 +367,11 @@ SOC_SINGLE("HPOUT2 SC Protect Switch", ARIZONA_HP2_SHORT_CIRCUIT_CTRL,
 SOC_SINGLE("HPOUT3 SC Protect Switch", ARIZONA_HP3_SHORT_CIRCUIT_CTRL,
 	   ARIZONA_HP3_SC_ENA_SHIFT, 1, 0),
 
+SOC_SINGLE("SPKDAT1 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_5L,
+	   ARIZONA_OUT5_OSR_SHIFT, 1, 0),
+SOC_SINGLE("SPKDAT2 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_6L,
+	   ARIZONA_OUT6_OSR_SHIFT, 1, 0),
+
 SOC_DOUBLE_R("HPOUT1 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_1L,
 	     ARIZONA_DAC_DIGITAL_VOLUME_1R, ARIZONA_OUT1L_MUTE_SHIFT, 1, 1),
 SOC_DOUBLE_R("HPOUT2 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_2L,
-- 
1.7.2.5
