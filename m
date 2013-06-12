From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5102: Expose controls for DRE
Date: Wed, 12 Jun 2013 17:44:08 +0100
Message-ID: <1371055448-31316-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1371055448-31316-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C9297265038
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 18:53:47 +0200 (CEST)
In-Reply-To: <1371055448-31316-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Certain use cases may require specific DRE settings so expose control
of these.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 842adfd..e723ac0 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -816,6 +816,19 @@ SOC_VALUE_ENUM("HPOUT1 OSR", wm5102_hpout_osr[0]),
 SOC_VALUE_ENUM("HPOUT2 OSR", wm5102_hpout_osr[1]),
 SOC_VALUE_ENUM("EPOUT OSR", wm5102_hpout_osr[2]),
 
+SOC_DOUBLE("HPOUT1 DRE Switch", ARIZONA_DRE_ENABLE,
+	   ARIZONA_DRE1L_ENA_SHIFT, ARIZONA_DRE1R_ENA_SHIFT, 1, 0),
+SOC_DOUBLE("HPOUT2 DRE Switch", ARIZONA_DRE_ENABLE,
+	   ARIZONA_DRE2L_ENA_SHIFT, ARIZONA_DRE2R_ENA_SHIFT, 1, 0),
+SOC_SINGLE("EPOUT DRE Switch", ARIZONA_DRE_ENABLE,
+	   ARIZONA_DRE3L_ENA_SHIFT, 1, 0),
+
+SOC_SINGLE("DRE Threshold", ARIZONA_DRE_CONTROL_2,
+	   ARIZONA_DRE_T_LOW_SHIFT, 63, 0),
+
+SOC_SINGLE("DRE Low Level ABS", ARIZONA_DRE_CONTROL_3,
+	   ARIZONA_DRE_LOW_LEVEL_ABS_SHIFT, 15, 0),
+
 SOC_ENUM("Output Ramp Up", arizona_out_vi_ramp),
 SOC_ENUM("Output Ramp Down", arizona_out_vd_ramp),
 
-- 
1.7.2.5
