From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/3] ASoC: TWL4030: Small cleanup
Date: Wed, 10 Dec 2008 12:51:47 +0200
Message-ID: <1228906308-17374-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1228906308-17374-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228906308-17374-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F2BC2440D
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 11:51:58 +0100 (CET)
In-Reply-To: <1228906308-17374-2-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

The mux switch related texts fits to on line, no need to wrap
them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index df9f2ce..e3a7115 100644
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
1.6.0.4
