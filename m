From: Michal Bachraty <michal.bachraty@streamunlimited.com>
Subject: [PATCH] ALSA: ASoC: McASP: Fix data rotation for playback. Enables 24bit audio playback
Date: Tue, 15 Jan 2013 15:41:00 +0100
Message-ID: <1358260860-10370-1-git-send-email-michal.bachraty@streamunlimited.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, perex@perex.cz
Cc: lrg@ti.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Michal Bachraty <michal.bachraty@streamunlimited.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Michal Bachraty <michal.bachraty@streamunlimited.com>
---
 sound/soc/davinci/davinci-mcasp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 13f8d73..a03bece 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -626,7 +626,7 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 				       int word_length)
 {
 	u32 fmt;
-	u32 rotate = (32 - word_length) / 4;
+	u32 rotate = (word_length / 4) & 0x7;
 	u32 mask = (1ULL << word_length) - 1;
 
 	/*
-- 
1.7.9.5
