From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/8] ASoC: TWL4030: Small cleanup
Date: Wed, 10 Dec 2008 20:01:10 +0000
Message-ID: <1228939275-7768-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081210195858.GA4062@rakim.wolfsonmicro.main>
	<1228939275-7768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B7CC243BD
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 21:01:17 +0100 (CET)
In-Reply-To: <1228939275-7768-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The mux switch related texts fits to on line, no need to wrap
them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 13d5a12..b321928 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -192,8 +192,7 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 /* Earpiece */
 static const char *twl4030_earpiece_texts[] =
-		{"Off", "DACL1", "DACL2", "Invalid",
-		"DACR1"};
+		{"Off", "DACL1", "DACL2", "Invalid", "DACR1"};
 
 static const struct soc_enum twl4030_earpiece_enum =
 	SOC_ENUM_SINGLE(TWL4030_REG_EAR_CTL, 1,
@@ -205,8 +204,7 @@ SOC_DAPM_ENUM("Route", twl4030_earpiece_enum);
 
 /* PreDrive Left */
 static const char *twl4030_predrivel_texts[] =
-		{"Off", "DACL1", "DACL2", "Invalid",
-		"DACR2"};
+		{"Off", "DACL1", "DACL2", "Invalid", "DACR2"};
 
 static const struct soc_enum twl4030_predrivel_enum =
 	SOC_ENUM_SINGLE(TWL4030_REG_PREDL_CTL, 1,
@@ -218,8 +216,7 @@ SOC_DAPM_ENUM("Route", twl4030_predrivel_enum);
 
 /* PreDrive Right */
 static const char *twl4030_predriver_texts[] =
-		{"Off", "DACR1", "DACR2", "Invalid",
-		"DACL2"};
+		{"Off", "DACR1", "DACR2", "Invalid", "DACL2"};
 
 static const struct soc_enum twl4030_predriver_enum =
 	SOC_ENUM_SINGLE(TWL4030_REG_PREDR_CTL, 1,
-- 
1.5.6.5
