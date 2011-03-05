From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: [PATCH] ASoC: Enable 192kHz sample rate for EP92xx.
Date: Sat, 05 Mar 2011 03:57:17 +0300
Message-ID: <1299286637.27359.107.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward8.mail.yandex.net (forward8.mail.yandex.net
	[77.88.61.38]) by alsa0.perex.cz (Postfix) with ESMTP id 4B80C24372
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2011 01:57:20 +0100 (CET)
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
Cc: Ryan Mallon <ryan@bluewatersys.com>, Chase Douglas <chasedouglas@gmail.com>, Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: alsa-devel@alsa-project.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Enable 192kHz sample rate for EP92xx.

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 sound/soc/ep93xx/ep93xx-i2s.c |    4 ++--
 sound/soc/ep93xx/ep93xx-pcm.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
index e1a58d3..87dc1ee 100644
--- a/sound/soc/ep93xx/ep93xx-i2s.c
+++ b/sound/soc/ep93xx/ep93xx-i2s.c
@@ -351,13 +351,13 @@ static struct snd_soc_dai_driver ep93xx_i2s_dai = {
 	.playback	= {
 		.channels_min	= 2,
 		.channels_max	= 2,
-		.rates		= SNDRV_PCM_RATE_8000_96000,
+		.rates		= SNDRV_PCM_RATE_8000_192000,
 		.formats	= EP93XX_I2S_FORMATS,
 	},
 	.capture	= {
 		 .channels_min	= 2,
 		 .channels_max	= 2,
-		 .rates		= SNDRV_PCM_RATE_8000_96000,
+		 .rates		= SNDRV_PCM_RATE_8000_192000,
 		 .formats	= EP93XX_I2S_FORMATS,
 	},
 	.ops		= &ep93xx_i2s_dai_ops,
diff --git a/sound/soc/ep93xx/ep93xx-pcm.c b/sound/soc/ep93xx/ep93xx-pcm.c
index 0667077..a456e49 100644
--- a/sound/soc/ep93xx/ep93xx-pcm.c
+++ b/sound/soc/ep93xx/ep93xx-pcm.c
@@ -35,9 +35,9 @@ static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
 				   SNDRV_PCM_INFO_INTERLEAVED	|
 				   SNDRV_PCM_INFO_BLOCK_TRANSFER),
 				   
-	.rates			= SNDRV_PCM_RATE_8000_96000,
+	.rates			= SNDRV_PCM_RATE_8000_192000,
 	.rate_min		= SNDRV_PCM_RATE_8000,
-	.rate_max		= SNDRV_PCM_RATE_96000,
+	.rate_max		= SNDRV_PCM_RATE_192000,
 	
 	.formats		= (SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE |
