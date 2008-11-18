From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 01/17] ASoC: Fix for master playback/capture
	volume range for TWL4030 codec
Date: Tue, 18 Nov 2008 12:38:07 +0000
Message-ID: <1227011903-2825-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1AB0B1037ED
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 13:38:25 +0100 (CET)
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

FGAIN for playback is in range of 0-0x3f, while for capture GAIN it
is in the range of 0-0x1f.
The original value of 128 (0x7f) would modify the CGAIN also for
playback.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index c1893d2..c778eb4 100644
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
1.5.6.5
