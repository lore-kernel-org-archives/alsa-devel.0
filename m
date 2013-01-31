From: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm2200: Add ANC source select for outputs
Date: Thu, 31 Jan 2013 17:45:14 +0000
Message-ID: <1359654314-32183-1-git-send-email-crattray@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BFF6426163F
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 18:52:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Chris Rattray <crattray@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Chris Rattray <crattray@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2200.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 0181444..a850d88 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1162,6 +1162,14 @@ SOC_DOUBLE_R_TLV("OUT2 Digital Volume", WM2200_DAC_DIGITAL_VOLUME_2L,
 		 digital_tlv),
 SOC_DOUBLE("OUT2 Switch", WM2200_PDM_1, WM2200_SPK1L_MUTE_SHIFT,
 	   WM2200_SPK1R_MUTE_SHIFT, 1, 1),
+SOC_SINGLE("OUT1L ANC Switch", WM2200_DAC_VOLUME_LIMIT_1L,
+	   WM2200_OUT1L_ANC_SRC_SHIFT, 1, 0),
+SOC_SINGLE("OUT1R ANC Switch", WM2200_DAC_VOLUME_LIMIT_1R,
+	   WM2200_OUT1R_ANC_SRC_SHIFT, 1, 0),
+SOC_SINGLE("OUT2L ANC Switch", WM2200_DAC_VOLUME_LIMIT_2L,
+	   WM2200_OUT2L_ANC_SRC_SHIFT, 1, 0),
+SOC_SINGLE("OUT2R ANC Switch", WM2200_DAC_VOLUME_LIMIT_2R,
+	   WM2200_OUT2R_ANC_SRC_SHIFT, 1, 0),
 };
 
 WM2200_MIXER_ENUMS(OUT1L, WM2200_OUT1LMIX_INPUT_1_SOURCE);
-- 
1.7.2.5
