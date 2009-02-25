From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/7] ASoC: Improve WM9713 voice DAC shutdown
	procedure
Date: Wed, 25 Feb 2009 10:48:18 +0000
Message-ID: <1235558902-20314-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090225104701.GA20221@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C98E2443E
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 11:48:24 +0100 (CET)
In-Reply-To: <20090225104701.GA20221@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9713.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 54db9c5..a93aea5 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -940,13 +940,14 @@ static void wm9713_voiceshutdown(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 status;
+	u16 status, rate;
 
 	/* Gracefully shut down the voice interface. */
 	status = ac97_read(codec, AC97_EXTENDED_STATUS) | 0x1000;
-	ac97_write(codec, AC97_HANDSET_RATE, 0x0280);
+	rate = ac97_read(codec, AC97_HANDSET_RATE) & 0xF0FF;
+	ac97_write(codec, AC97_HANDSET_RATE, rate | 0x0200);
 	schedule_timeout_interruptible(msecs_to_jiffies(1));
-	ac97_write(codec, AC97_HANDSET_RATE, 0x0F80);
+	ac97_write(codec, AC97_HANDSET_RATE, rate | 0x0F00);
 	ac97_write(codec, AC97_EXTENDED_MID, status);
 }
 
-- 
1.6.1.3
