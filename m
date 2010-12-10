From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Implement WM8903 high pass filter support
Date: Fri, 10 Dec 2010 18:42:58 +0000
Message-ID: <1292006578-24325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 01CD9245CB
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 19:43:01 +0100 (CET)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 620793e..797992c 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -474,6 +474,13 @@ static const DECLARE_TLV_DB_SCALE(drc_tlv_min, 0, 600, 0);
 static const DECLARE_TLV_DB_SCALE(drc_tlv_max, 1200, 600, 0);
 static const DECLARE_TLV_DB_SCALE(drc_tlv_startup, -300, 50, 0);
 
+static const char *hpf_mode_text[] = {
+	"Hi-fi", "Voice 1", "Voice 2", "Voice 3"
+};
+
+static const struct soc_enum hpf_mode =
+	SOC_ENUM_SINGLE(WM8903_ADC_DIGITAL_0, 5, 4, hpf_mode_text);
+
 static const char *drc_slope_text[] = {
 	"1", "1/2", "1/4", "1/8", "1/16", "0"
 };
@@ -612,6 +619,8 @@ SOC_SINGLE("Right Input PGA Common Mode Switch", WM8903_ANALOGUE_RIGHT_INPUT_1,
 	   6, 1, 0),
 
 /* ADCs */
+SOC_SINGLE("HPF Switch", WM8903_ADC_DIGITAL_0, 4, 1, 0),
+SOC_ENUM("HPF Mode", hpf_mode),
 SOC_SINGLE("DRC Switch", WM8903_DRC_0, 15, 1, 0),
 SOC_ENUM("DRC Compressor Slope R0", drc_slope_r0),
 SOC_ENUM("DRC Compressor Slope R1", drc_slope_r1),
-- 
1.7.1
