From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5110: Add support for ASRC RATE 1
Date: Thu, 19 Dec 2013 09:30:13 +0000
Message-ID: <1387445413-28475-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1387445413-28475-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 15EDC261A96
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 10:37:17 +0100 (CET)
In-Reply-To: <1387445413-28475-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Add support for configuring the sample rate on the SYSCLK side of the
ASRC.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    7 +++++++
 sound/soc/codecs/arizona.h |    1 +
 sound/soc/codecs/wm5110.c  |    1 +
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 56d3ff5..e4295fe 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -530,6 +530,13 @@ const struct soc_enum arizona_isrc_fsl[] = {
 };
 EXPORT_SYMBOL_GPL(arizona_isrc_fsl);
 
+const struct soc_enum arizona_asrc_rate1 =
+	SOC_VALUE_ENUM_SINGLE(ARIZONA_ASRC_RATE1,
+			      ARIZONA_ASRC_RATE1_SHIFT, 0xf,
+			      ARIZONA_RATE_ENUM_SIZE - 1,
+			      arizona_rate_text, arizona_rate_val);
+EXPORT_SYMBOL_GPL(arizona_asrc_rate1);
+
 static const char *arizona_vol_ramp_text[] = {
 	"0ms/6dB", "0.5ms/6dB", "1ms/6dB", "2ms/6dB", "4ms/6dB", "8ms/6dB",
 	"15ms/6dB", "30ms/6dB",
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 99a97c0..10b3984 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -187,6 +187,7 @@ extern const int arizona_rate_val[ARIZONA_RATE_ENUM_SIZE];
 
 extern const struct soc_enum arizona_isrc_fsl[];
 extern const struct soc_enum arizona_isrc_fsh[];
+extern const struct soc_enum arizona_asrc_rate1;
 
 extern const struct soc_enum arizona_in_vi_ramp;
 extern const struct soc_enum arizona_in_vd_ramp;
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 18c7e1f..b0ed2e6 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -283,6 +283,7 @@ SOC_VALUE_ENUM("ISRC3 FSL", arizona_isrc_fsl[2]),
 SOC_VALUE_ENUM("ISRC1 FSH", arizona_isrc_fsh[0]),
 SOC_VALUE_ENUM("ISRC2 FSH", arizona_isrc_fsh[1]),
 SOC_VALUE_ENUM("ISRC3 FSH", arizona_isrc_fsh[2]),
+SOC_VALUE_ENUM("ASRC RATE 1", arizona_asrc_rate1),
 
 ARIZONA_MIXER_CONTROLS("DSP1L", ARIZONA_DSP1LMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("DSP1R", ARIZONA_DSP1RMIX_INPUT_1_SOURCE),
-- 
1.7.2.5
