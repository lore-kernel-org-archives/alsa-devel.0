From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH] ASoC: add more sample rate for pxa-ssp
Date: Thu,  8 Mar 2012 10:02:36 +0800
Message-ID: <1331172156-27358-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67]) by alsa0.perex.cz (Postfix) with SMTP id B80DB104130
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 03:03:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, perex@perex.cz, lrg@ti.com, haojian.zhuang@marvell.com, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Qiao Zhou <zhouqiao@marvell.com>
List-Id: alsa-devel@alsa-project.org

add more sample rate for pxa-ssp, which are supported, such as 32KHz,
64KHz.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 sound/soc/pxa/pxa-ssp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index a57cfbc..a16df0f 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -764,7 +764,8 @@ static int pxa_ssp_remove(struct snd_soc_dai *dai)
 
 #define PXA_SSP_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
 			  SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |	\
-			  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |	\
+			  SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |	\
+			  SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_64000 |	\
 			  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 
 #define PXA_SSP_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
-- 
1.7.4.1
