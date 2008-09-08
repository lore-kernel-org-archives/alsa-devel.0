From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ALSA: ASoC: Fix indentation in WM9713
Date: Mon,  8 Sep 2008 16:13:52 +0100
Message-ID: <1220886834-14504-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080908151250.GA14434@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3232A243CB
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 17:13:55 +0200 (CEST)
In-Reply-To: <20080908151250.GA14434@rakim.wolfsonmicro.main>
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
 sound/soc/codecs/wm9713.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 38d1fe0..c10f8a3 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -949,17 +949,17 @@ static int wm9713_pcm_hw_params(struct snd_pcm_substream *substream,
 
 static void wm9713_voiceshutdown(struct snd_pcm_substream *substream)
 {
-    struct snd_soc_pcm_runtime *rtd = substream->private_data;
-    struct snd_soc_device *socdev = rtd->socdev;
-    struct snd_soc_codec *codec = socdev->codec;
-    u16 status;
-
-    /* Gracefully shut down the voice interface. */
-    status = ac97_read(codec, AC97_EXTENDED_STATUS) | 0x1000;
-    ac97_write(codec, AC97_HANDSET_RATE, 0x0280);
-    schedule_timeout_interruptible(msecs_to_jiffies(1));
-    ac97_write(codec, AC97_HANDSET_RATE, 0x0F80);
-    ac97_write(codec, AC97_EXTENDED_MID, status);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	u16 status;
+
+	/* Gracefully shut down the voice interface. */
+	status = ac97_read(codec, AC97_EXTENDED_STATUS) | 0x1000;
+	ac97_write(codec, AC97_HANDSET_RATE, 0x0280);
+	schedule_timeout_interruptible(msecs_to_jiffies(1));
+	ac97_write(codec, AC97_HANDSET_RATE, 0x0F80);
+	ac97_write(codec, AC97_EXTENDED_MID, status);
 }
 
 static int ac97_hifi_prepare(struct snd_pcm_substream *substream)
-- 
1.5.6.5
