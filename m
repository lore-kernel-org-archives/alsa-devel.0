From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: [PATCH] ASoC: Remove warnings in ep93xx-i2s.c
Date: Sat, 05 Mar 2011 03:57:32 +0300
Message-ID: <1299286652.27359.108.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward6.mail.yandex.net (forward6.mail.yandex.net
	[77.88.60.125]) by alsa0.perex.cz (Postfix) with ESMTP id 0D0712439F
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2011 01:57:35 +0100 (CET)
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
Cc: Ryan Mallon <ryan@bluewatersys.com>
List-Id: alsa-devel@alsa-project.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Remove warnings in ep93xx-i2s.c

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 sound/soc/ep93xx/ep93xx-i2s.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
index 3d4c086..042f4e9 100644
--- a/sound/soc/ep93xx/ep93xx-i2s.c
+++ b/sound/soc/ep93xx/ep93xx-i2s.c
@@ -313,10 +313,12 @@ static int ep93xx_i2s_suspend(struct snd_soc_dai *dai)
 	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
 
 	if (!dai->active)
-		return;
+		return 0;
 
 	ep93xx_i2s_disable(info, SNDRV_PCM_STREAM_PLAYBACK);
 	ep93xx_i2s_disable(info, SNDRV_PCM_STREAM_CAPTURE);
+
+	return 0;
 }
 
 static int ep93xx_i2s_resume(struct snd_soc_dai *dai)
@@ -324,10 +326,12 @@ static int ep93xx_i2s_resume(struct snd_soc_dai *dai)
 	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
 
 	if (!dai->active)
-		return;
+		return 0;
 
 	ep93xx_i2s_enable(info, SNDRV_PCM_STREAM_PLAYBACK);
 	ep93xx_i2s_enable(info, SNDRV_PCM_STREAM_CAPTURE);
+
+	return 0;
 }
 #else
 #define ep93xx_i2s_suspend	NULL
