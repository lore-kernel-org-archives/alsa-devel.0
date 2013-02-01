From: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm2200: correct IN2L and IN3L digital
	mute
Date: Fri,  1 Feb 2013 15:51:41 +0000
Message-ID: <1359733901-26807-1-git-send-email-crattray@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC75426522D
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2013 16:57:55 +0100 (CET)
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
 sound/soc/codecs/wm2200.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index a915c76..f5410ec 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1136,9 +1136,9 @@ SOC_DOUBLE_R_TLV("IN3 Volume", WM2200_IN3L_CONTROL, WM2200_IN3R_CONTROL,
 
 SOC_DOUBLE_R("IN1 Digital Switch", WM2200_ADC_DIGITAL_VOLUME_1L,
 	     WM2200_ADC_DIGITAL_VOLUME_1R, WM2200_IN1L_MUTE_SHIFT, 1, 1),
-SOC_DOUBLE_R("IN2 Digital Switch", WM2200_ADC_DIGITAL_VOLUME_1L,
+SOC_DOUBLE_R("IN2 Digital Switch", WM2200_ADC_DIGITAL_VOLUME_2L,
 	     WM2200_ADC_DIGITAL_VOLUME_2R, WM2200_IN2L_MUTE_SHIFT, 1, 1),
-SOC_DOUBLE_R("IN3 Digital Switch", WM2200_ADC_DIGITAL_VOLUME_1L,
+SOC_DOUBLE_R("IN3 Digital Switch", WM2200_ADC_DIGITAL_VOLUME_3L,
 	     WM2200_ADC_DIGITAL_VOLUME_3R, WM2200_IN3L_MUTE_SHIFT, 1, 1),
 
 SOC_DOUBLE_R_TLV("IN1 Digital Volume", WM2200_ADC_DIGITAL_VOLUME_1L,
-- 
1.7.2.5
