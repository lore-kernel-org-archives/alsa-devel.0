From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 5/6] ASoC: TWL4030: Add constraints for 4
	channel mode
Date: Mon,  6 Apr 2009 15:19:31 +0300
Message-ID: <1239020372-8457-6-git-send-email-peter.ujfalusi@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-2-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-3-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-4-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id E7EA524359
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 14:19:45 +0200 (CEST)
In-Reply-To: <1239020372-8457-5-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

Constrain #1: The TDM mode only available in Option1
Constrain #2: The second stream has to have the same
              number of channels

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 927b876..a1ae6e7 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1244,9 +1244,22 @@ static int twl4030_startup(struct snd_pcm_substream *substream)
 					     master_runtime->sample_bits,
 					     master_runtime->sample_bits);
 
+		snd_pcm_hw_constraint_minmax(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_CHANNELS,
+					     master_runtime->channels,
+					     master_runtime->channels);
+
 		twl4030->slave_substream = substream;
-	} else
+	} else {
+		if (!(twl4030_read_reg_cache(codec, TWL4030_REG_CODEC_MODE) &
+			TWL4030_OPT_MODE))
+			/* In option2 4 channel is not supported */
+			snd_pcm_hw_constraint_minmax(substream->runtime,
+						SNDRV_PCM_HW_PARAM_CHANNELS,
+						2, 2);
+
 		twl4030->master_substream = substream;
+	}
 
 	return 0;
 }
-- 
1.6.2.2
