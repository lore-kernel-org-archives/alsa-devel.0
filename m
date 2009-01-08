From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/7] ASoC: TWL4030: Change the soc_value_enum
	back to soc_enum
Date: Thu,  8 Jan 2009 19:37:57 +0000
Message-ID: <1231443481-29352-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090108193718.GA29183@sirena.org.uk>
	<1231443481-29352-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1231443481-29352-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CFF72436B
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 20:38:08 +0100 (CET)
In-Reply-To: <1231443481-29352-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

The soc_value_enum has been merged to soc_enum.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index fd0f338..db24f83 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -197,7 +197,7 @@ static const char *twl4030_earpiece_texts[] =
 static const unsigned int twl4030_earpiece_values[] =
 		{0x0, 0x1, 0x2, 0x4};
 
-static const struct soc_value_enum twl4030_earpiece_enum =
+static const struct soc_enum twl4030_earpiece_enum =
 	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_EAR_CTL, 1, 0x7,
 			ARRAY_SIZE(twl4030_earpiece_texts),
 			twl4030_earpiece_texts,
@@ -213,7 +213,7 @@ static const char *twl4030_predrivel_texts[] =
 static const unsigned int twl4030_predrivel_values[] =
 		{0x0, 0x1, 0x2, 0x4};
 
-static const struct soc_value_enum twl4030_predrivel_enum =
+static const struct soc_enum twl4030_predrivel_enum =
 	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_PREDL_CTL, 1, 0x7,
 			ARRAY_SIZE(twl4030_predrivel_texts),
 			twl4030_predrivel_texts,
@@ -229,7 +229,7 @@ static const char *twl4030_predriver_texts[] =
 static const unsigned int twl4030_predriver_values[] =
 		{0x0, 0x1, 0x2, 0x4};
 
-static const struct soc_value_enum twl4030_predriver_enum =
+static const struct soc_enum twl4030_predriver_enum =
 	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_PREDR_CTL, 1, 0x7,
 			ARRAY_SIZE(twl4030_predriver_texts),
 			twl4030_predriver_texts,
@@ -317,7 +317,7 @@ static const char *twl4030_analoglmic_texts[] =
 static const unsigned int twl4030_analoglmic_values[] =
 		{0x0, 0x1, 0x2, 0x4, 0x8};
 
-static const struct soc_value_enum twl4030_analoglmic_enum =
+static const struct soc_enum twl4030_analoglmic_enum =
 	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_ANAMICL, 0, 0xf,
 			ARRAY_SIZE(twl4030_analoglmic_texts),
 			twl4030_analoglmic_texts,
@@ -333,7 +333,7 @@ static const char *twl4030_analogrmic_texts[] =
 static const unsigned int twl4030_analogrmic_values[] =
 		{0x0, 0x1, 0x4};
 
-static const struct soc_value_enum twl4030_analogrmic_enum =
+static const struct soc_enum twl4030_analogrmic_enum =
 	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_ANAMICR, 0, 0x5,
 			ARRAY_SIZE(twl4030_analogrmic_texts),
 			twl4030_analogrmic_texts,
-- 
1.5.6.5
