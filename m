From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/9] ASoC: TWL4030: Change the Master volume
	control to TLV
Date: Mon, 24 Nov 2008 13:49:35 +0200
Message-ID: <1227527383-22516-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E71424368
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 12:49:56 +0100 (CET)
In-Reply-To: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
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

TWL4030 FGAIN volume control has a range:
-62 to 0 dB in 1 dB steps, 0 in the FGAIN means mute.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 49c7da3..498c42f 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -33,6 +33,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
+#include <sound/tlv.h>
 
 #include "twl4030.h"
 
@@ -189,10 +190,16 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 }
 
+/*
+ * FGAIN volume control:
+ * from -62 to 0 dB in 1 dB steps (mute instead of -63 dB)
+ */
+static DECLARE_TLV_DB_SCALE(master_tlv, -6300, 100, 1);
+
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
-	SOC_DOUBLE_R("Master Playback Volume",
+	SOC_DOUBLE_R_TLV("Master Playback Volume",
 		 TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
-		0, 0x3f, 0),
+		0, 0x3f, 0, master_tlv),
 	SOC_DOUBLE_R("Capture Volume",
 		 TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
 		0, 0x1f, 0),
-- 
1.6.0.3
