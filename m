From: pascal.huerst@gmail.com
Subject: [PATCH] ASoC: adau1701: Add 44.1 KHz to supported
	sample rates
Date: Thu, 15 Oct 2015 13:16:06 +0200
Message-ID: <1444907766-9892-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C904260453
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 13:16:17 +0200 (CEST)
Received: by wicll6 with SMTP id ll6so35645186wic.0
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 04:16:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lars@metafoo.de
Cc: alsa-devel@alsa-project.org, Pascal Huerst <pascal.huerst@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Pascal Huerst <pascal.huerst@gmail.com>

According to the datasheet, this device does also support 44.1 KHz
as sample rate. This adds the necessary changes to support this.

See Datasheet: Rev. B / page 39 / SR[1:0]

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
---
 sound/soc/codecs/adau1701.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index de53c0d..8b3ba51 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -459,6 +459,7 @@ static int adau1701_hw_params(struct snd_pcm_substream *substream,
 	case 96000:
 		val = ADAU1701_DSPCTRL_SR_96;
 		break;
+	case 44100:
 	case 48000:
 		val = ADAU1701_DSPCTRL_SR_48;
 		break;
@@ -623,8 +624,8 @@ static int adau1701_startup(struct snd_pcm_substream *substream,
 	return sigmadsp_restrict_params(adau1701->sigmadsp, substream);
 }
 
-#define ADAU1701_RATES (SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 | \
-	SNDRV_PCM_RATE_192000)
+#define ADAU1701_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
+	SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000)
 
 #define ADAU1701_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE)
-- 
2.4.3
