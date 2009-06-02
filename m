From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 1/5] ASoC codec: SSM2602: remove unsupported
	sample rates
Date: Tue,  2 Jun 2009 00:18:53 -0400
Message-ID: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A6CD2415F
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 06:19:07 +0200 (CEST)
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ssm2602.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 87f606c..d6af069 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -497,11 +497,9 @@ static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-#define SSM2602_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
-		SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
-		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
-		SNDRV_PCM_RATE_96000)
+#define SSM2602_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_32000 |\
+		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
+		SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 
 #define SSM2602_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
-- 
1.6.3.1
