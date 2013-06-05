From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: arizona: Correct AEC loopback enable
Date: Wed,  5 Jun 2013 14:51:30 +0100
Message-ID: <1370440291-2876-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0F1F226535F
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 16:01:44 +0200 (CEST)
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
 sound/soc/codecs/wm5102.c |    3 ++-
 sound/soc/codecs/wm5110.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index e895d39..100fdad 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1120,7 +1120,8 @@ SND_SOC_DAPM_AIF_IN("AIF3RX2", NULL, 0,
 ARIZONA_DSP_WIDGETS(DSP1, "DSP1"),
 
 SND_SOC_DAPM_VALUE_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
-		       ARIZONA_AEC_LOOPBACK_ENA, 0, &wm5102_aec_loopback_mux),
+		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
+		       &wm5102_aec_loopback_mux),
 
 SND_SOC_DAPM_PGA_E("OUT1L", SND_SOC_NOPM,
 		   ARIZONA_OUT1L_ENA_SHIFT, 0, NULL, 0, arizona_hp_ev,
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index ba38f06..88ad7db 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -503,7 +503,8 @@ SND_SOC_DAPM_PGA("ASRC2R", ARIZONA_ASRC_ENABLE, ARIZONA_ASRC2R_ENA_SHIFT, 0,
 		 NULL, 0),
 
 SND_SOC_DAPM_VALUE_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
-		       ARIZONA_AEC_LOOPBACK_ENA, 0, &wm5110_aec_loopback_mux),
+		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
+		       &wm5110_aec_loopback_mux),
 
 SND_SOC_DAPM_AIF_OUT("AIF1TX1", NULL, 0,
 		     ARIZONA_AIF1_TX_ENABLES, ARIZONA_AIF1TX1_ENA_SHIFT, 0),
-- 
1.7.2.5
