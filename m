From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 1/2] ASoC: pcm1792a: Add 88200 frequency
Date: Mon, 28 Jul 2014 14:26:48 +0200
Message-ID: <1406550409-13798-1-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 05035261B1B
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 14:26:55 +0200 (CEST)
Received: by mail-wi0-f172.google.com with SMTP id n3so4322750wiv.17
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 05:26:53 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 sound/soc/codecs/pcm1792a.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm1792a.h b/sound/soc/codecs/pcm1792a.h
index 7a83d1f..51d5470 100644
--- a/sound/soc/codecs/pcm1792a.h
+++ b/sound/soc/codecs/pcm1792a.h
@@ -18,7 +18,8 @@
 #define __PCM1792A_H__
 
 #define PCM1792A_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_8000_48000 | \
-			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000)
+			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | \
+			SNDRV_PCM_RATE_192000)
 
 #define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
 			  SNDRV_PCM_FMTBIT_S16_LE)
-- 
1.8.1.2
