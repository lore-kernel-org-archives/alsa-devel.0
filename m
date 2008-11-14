From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: Fix for master playback/capture volume
	range for TWL4030 codec
Date: Fri, 14 Nov 2008 08:57:28 +0200
Message-ID: <1226645848-32080-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 932E6243AF
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 07:57:47 +0100 (CET)
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com
	[10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mAE6vR5K022429
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 08:57:45 +0200
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

FGAIN for playback is in range of 0-0x3f, while for capture GAIN it
is in the range of 0-0x1f.
The original value of 128 (0x7f) would modify the CGAIN also for
playback.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 90f3b4d..65aeabe 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -192,10 +192,10 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	SOC_DOUBLE_R("Master Playback Volume",
 		 TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
-		0, 127, 0),
+		0, 0x3f, 0),
 	SOC_DOUBLE_R("Capture Volume",
 		 TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
-		0, 127, 0),
+		0, 0x1f, 0),
 };
 
 /* add non dapm controls */
-- 
1.6.0.3
