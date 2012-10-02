From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm2200: Fix non-inverted OUT2 mute
	control
Date: Tue,  2 Oct 2012 19:13:40 +0100
Message-ID: <1349201620-12217-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E1FA226163F
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2012 20:13:44 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2200.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 664067c..6ca9bcc 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1028,7 +1028,7 @@ SOC_DOUBLE_R_TLV("OUT2 Digital Volume", WM2200_DAC_DIGITAL_VOLUME_2L,
 		 WM2200_DAC_DIGITAL_VOLUME_2R, WM2200_OUT2L_VOL_SHIFT, 0x9f, 0,
 		 digital_tlv),
 SOC_DOUBLE("OUT2 Switch", WM2200_PDM_1, WM2200_SPK1L_MUTE_SHIFT,
-	   WM2200_SPK1R_MUTE_SHIFT, 1, 0),
+	   WM2200_SPK1R_MUTE_SHIFT, 1, 1),
 };
 
 WM2200_MIXER_ENUMS(OUT1L, WM2200_OUT1LMIX_INPUT_1_SOURCE);
-- 
1.7.10.4
