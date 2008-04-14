From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] soc - Fix s3c24xx-i2s LR sync while timer
	ticks are disabled
Date: Mon, 14 Apr 2008 12:01:42 +0100
Message-ID: <1208170903-27159-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C302244E6
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 13:01:45 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Werner Almesberger <werner@openmoko.org>
List-Id: alsa-devel@alsa-project.org

From: Werner Almesberger <werner@openmoko.org>

When timer ticks are disabled when calling
sound/soc/s3c24xx/s3c24xx-i2s.c:s3c24xx_snd_lrsync
and the LR signal never happens, we loop forever.

This has been observed in the following call chain:
snd_pcm_common_ioctl1 -> snd_pcm_action_lock_irq ->
snd_pcm_action_single
  -> snd_pcm_do_resume -> soc_pcm_trigger -> s3c24xx_i2s_trigger

The patch below changes the timeout mechanism to use udelay, which
doesn't need timer ticks.

Signed-off-by: Werner Almesberger <werner@openmoko.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c24xx-i2s.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 0a3c630..6b3cbbf 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -180,7 +180,7 @@ static void s3c24xx_snd_rxctrl(int on)
 static int s3c24xx_snd_lrsync(void)
 {
 	u32 iiscon;
-	unsigned long timeout = jiffies + msecs_to_jiffies(5);
+	int timeout = 50; /* 5ms */
 
 	DBG("Entered %s\n", __FUNCTION__);
 
@@ -189,8 +189,9 @@ static int s3c24xx_snd_lrsync(void)
 		if (iiscon & S3C2410_IISCON_LRINDEX)
 			break;
 
-		if (time_after(jiffies, timeout))
+		if (!timeout--)
 			return -ETIMEDOUT;
+		udelay(100);
 	}
 
 	return 0;
-- 
1.5.5
