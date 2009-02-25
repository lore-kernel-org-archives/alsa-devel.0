From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/7] ASoC: Report I/O errors from WM8753 reset
Date: Wed, 25 Feb 2009 10:48:16 +0000
Message-ID: <1235558902-20314-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090225104701.GA20221@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 34BA124441
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
 sound/soc/codecs/wm8753.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 31ff337..180ec94 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1561,7 +1561,11 @@ static int wm8753_init(struct snd_soc_device *socdev)
 
 	wm8753_set_dai_mode(codec, 0);
 
-	wm8753_reset(codec);
+	ret = wm8753_reset(codec);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8753: failed to reset device\n");
+		return ret;
+	}
 
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-- 
1.6.1.3
