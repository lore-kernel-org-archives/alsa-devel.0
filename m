From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix widgets for WM8994/58 AIF2 source
	control
Date: Wed,  8 Dec 2010 13:50:25 +0000
Message-ID: <1291816225-21214-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E374103851
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 14:50:33 +0100 (CET)
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

The compiler really ought to have been warning about unreferenced
variables...

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index da48802..b599616 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -780,13 +780,13 @@ SOC_DOUBLE_R_TLV("AIF2ADC Volume", WM8994_AIF2_ADC_LEFT_VOLUME,
 
 SOC_ENUM("AIF1ADCL Source", aif1adcl_src),
 SOC_ENUM("AIF1ADCR Source", aif1adcr_src),
-SOC_ENUM("AIF2ADCL Source", aif1adcl_src),
-SOC_ENUM("AIF2ADCR Source", aif1adcr_src),
+SOC_ENUM("AIF2ADCL Source", aif2adcl_src),
+SOC_ENUM("AIF2ADCR Source", aif2adcr_src),
 
 SOC_ENUM("AIF1DACL Source", aif1dacl_src),
 SOC_ENUM("AIF1DACR Source", aif1dacr_src),
-SOC_ENUM("AIF2DACL Source", aif1dacl_src),
-SOC_ENUM("AIF2DACR Source", aif1dacr_src),
+SOC_ENUM("AIF2DACL Source", aif2dacl_src),
+SOC_ENUM("AIF2DACR Source", aif2dacr_src),
 
 SOC_DOUBLE_R_TLV("AIF1DAC1 Volume", WM8994_AIF1_DAC1_LEFT_VOLUME,
 		 WM8994_AIF1_DAC1_RIGHT_VOLUME, 1, 96, 0, digital_tlv),
-- 
1.7.1
