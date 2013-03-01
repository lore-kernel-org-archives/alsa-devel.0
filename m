From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm8960: Add input boost volume
	control
Date: Fri,  1 Mar 2013 18:15:35 +0800
Message-ID: <1362132936-31597-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1362132936-31597-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 57914265DE3
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2013 11:16:37 +0100 (CET)
In-Reply-To: <1362132936-31597-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8960.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 4cb49eb..c737a5b 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -204,6 +204,7 @@ static const DECLARE_TLV_DB_SCALE(adc_tlv, -9700, 50, 0);
 static const DECLARE_TLV_DB_SCALE(dac_tlv, -12700, 50, 1);
 static const DECLARE_TLV_DB_SCALE(bypass_tlv, -2100, 300, 0);
 static const DECLARE_TLV_DB_SCALE(out_tlv, -12100, 100, 1);
+static const DECLARE_TLV_DB_SCALE(boost_tlv, -1200, 300, 1);
 
 static const struct snd_kcontrol_new wm8960_snd_controls[] = {
 SOC_DOUBLE_R_TLV("Capture Volume", WM8960_LINVOL, WM8960_RINVOL,
@@ -213,6 +214,15 @@ SOC_DOUBLE_R("Capture Volume ZC Switch", WM8960_LINVOL, WM8960_RINVOL,
 SOC_DOUBLE_R("Capture Switch", WM8960_LINVOL, WM8960_RINVOL,
 	7, 1, 0),
 
+SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT3 Volume",
+	       WM8960_INBMIX1, 4, 7, 0, boost_tlv),
+SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT2 Volume",
+	       WM8960_INBMIX1, 1, 7, 0, boost_tlv),
+SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT3 Volume",
+	       WM8960_INBMIX2, 4, 7, 0, boost_tlv),
+SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT2 Volume",
+	       WM8960_INBMIX2, 1, 7, 0, boost_tlv),
+
 SOC_DOUBLE_R_TLV("Playback Volume", WM8960_LDAC, WM8960_RDAC,
 		 0, 255, 0, dac_tlv),
 
-- 
1.7.10.4
