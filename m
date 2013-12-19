From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm5110: Add FSH for ISRCs
Date: Thu, 19 Dec 2013 09:30:12 +0000
Message-ID: <1387445413-28475-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0DA91261A8F
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 10:37:17 +0100 (CET)
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

Currently, the driver only supports configuration of the lower sample
rate (FSL) on the ISRCs. With the higher rate being fixed a SYSCLK, this
patch adds support for configuring the higher sample rate (FSH).

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   16 ++++++++++++++++
 sound/soc/codecs/arizona.h |    1 +
 sound/soc/codecs/wm5110.c  |    3 +++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 6bfd803..56d3ff5 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -498,6 +498,22 @@ const int arizona_rate_val[ARIZONA_RATE_ENUM_SIZE] = {
 EXPORT_SYMBOL_GPL(arizona_rate_val);
 
 
+const struct soc_enum arizona_isrc_fsh[] = {
+	SOC_VALUE_ENUM_SINGLE(ARIZONA_ISRC_1_CTRL_1,
+			      ARIZONA_ISRC1_FSH_SHIFT, 0xf,
+			      ARIZONA_RATE_ENUM_SIZE,
+			      arizona_rate_text, arizona_rate_val),
+	SOC_VALUE_ENUM_SINGLE(ARIZONA_ISRC_2_CTRL_1,
+			      ARIZONA_ISRC2_FSH_SHIFT, 0xf,
+			      ARIZONA_RATE_ENUM_SIZE,
+			      arizona_rate_text, arizona_rate_val),
+	SOC_VALUE_ENUM_SINGLE(ARIZONA_ISRC_3_CTRL_1,
+			      ARIZONA_ISRC3_FSH_SHIFT, 0xf,
+			      ARIZONA_RATE_ENUM_SIZE,
+			      arizona_rate_text, arizona_rate_val),
+};
+EXPORT_SYMBOL_GPL(arizona_isrc_fsh);
+
 const struct soc_enum arizona_isrc_fsl[] = {
 	SOC_VALUE_ENUM_SINGLE(ARIZONA_ISRC_1_CTRL_2,
 			      ARIZONA_ISRC1_FSL_SHIFT, 0xf,
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 6641f3d..99a97c0 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -186,6 +186,7 @@ extern const char *arizona_rate_text[ARIZONA_RATE_ENUM_SIZE];
 extern const int arizona_rate_val[ARIZONA_RATE_ENUM_SIZE];
 
 extern const struct soc_enum arizona_isrc_fsl[];
+extern const struct soc_enum arizona_isrc_fsh[];
 
 extern const struct soc_enum arizona_in_vi_ramp;
 extern const struct soc_enum arizona_in_vd_ramp;
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 7fb8599..18c7e1f 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -280,6 +280,9 @@ SOC_ENUM("LHPF4 Mode", arizona_lhpf4_mode),
 SOC_VALUE_ENUM("ISRC1 FSL", arizona_isrc_fsl[0]),
 SOC_VALUE_ENUM("ISRC2 FSL", arizona_isrc_fsl[1]),
 SOC_VALUE_ENUM("ISRC3 FSL", arizona_isrc_fsl[2]),
+SOC_VALUE_ENUM("ISRC1 FSH", arizona_isrc_fsh[0]),
+SOC_VALUE_ENUM("ISRC2 FSH", arizona_isrc_fsh[1]),
+SOC_VALUE_ENUM("ISRC3 FSH", arizona_isrc_fsh[2]),
 
 ARIZONA_MIXER_CONTROLS("DSP1L", ARIZONA_DSP1LMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("DSP1R", ARIZONA_DSP1RMIX_INPUT_1_SOURCE),
-- 
1.7.2.5
