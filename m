From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix WM8994/58 3D stereo control
	definitions
Date: Mon, 20 Dec 2010 14:48:48 +0000
Message-ID: <1292856528-19435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4B4124388
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 15:48:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Cut'n'paste in the register names.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index af104ac..e1a775b 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -869,15 +869,15 @@ SOC_SINGLE_TLV("SPKR DAC1 Volume", WM8994_SPKMIXR_ATTENUATION,
 
 SOC_SINGLE_TLV("AIF1DAC1 3D Stereo Volume", WM8994_AIF1_DAC1_FILTERS_2,
 	       10, 15, 0, wm8994_3d_tlv),
-SOC_SINGLE("AIF1DAC1 3D Stereo Switch", WM8994_AIF1_DAC2_FILTERS_2,
+SOC_SINGLE("AIF1DAC1 3D Stereo Switch", WM8994_AIF1_DAC1_FILTERS_2,
 	   8, 1, 0),
 SOC_SINGLE_TLV("AIF1DAC2 3D Stereo Volume", WM8994_AIF1_DAC2_FILTERS_2,
 	       10, 15, 0, wm8994_3d_tlv),
 SOC_SINGLE("AIF1DAC2 3D Stereo Switch", WM8994_AIF1_DAC2_FILTERS_2,
 	   8, 1, 0),
-SOC_SINGLE_TLV("AIF2DAC 3D Stereo Volume", WM8994_AIF1_DAC1_FILTERS_2,
+SOC_SINGLE_TLV("AIF2DAC 3D Stereo Volume", WM8994_AIF2_DAC_FILTERS_2,
 	       10, 15, 0, wm8994_3d_tlv),
-SOC_SINGLE("AIF2DAC 3D Stereo Switch", WM8994_AIF1_DAC2_FILTERS_2,
+SOC_SINGLE("AIF2DAC 3D Stereo Switch", WM8994_AIF2_DAC_FILTERS_2,
 	   8, 1, 0),
 };
 
-- 
1.7.1
