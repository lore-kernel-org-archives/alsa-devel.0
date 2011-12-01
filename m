From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/6] ASoC: Ensure we reconfigure WM8958
	microphone detection on rate changes
Date: Thu,  1 Dec 2011 14:16:44 +0000
Message-ID: <1322749006-371-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322749006-371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 74E57103BF1
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 15:17:09 +0100 (CET)
In-Reply-To: <1322749006-371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We don't need to rerun DAPM if the clock source is the same but we do
need to adjust the microphone detection rate in case we are moving from
an audio to a non-audio rate.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 5c042de..72282da 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -208,10 +208,8 @@ static int configure_clock(struct snd_soc_codec *codec)
 
 	change = snd_soc_update_bits(codec, WM8994_CLOCKING_1,
 				     WM8994_SYSCLK_SRC, new);
-	if (!change)
-		return 0;
-
-	snd_soc_dapm_sync(&codec->dapm);
+	if (change)
+		snd_soc_dapm_sync(&codec->dapm);
 
 	wm8958_micd_set_rate(codec);
 
-- 
1.7.7.3
