From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: ASoC: McASP: treat
	SNDRV_PCM_FORMAT_U24_* as 32 bit words
Date: Tue,  9 Oct 2012 11:56:40 +0200
Message-ID: <1349776600-7849-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FB00264EEC
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 11:56:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
---
 sound/soc/davinci/davinci-mcasp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 501f8b4..82877a9 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -868,12 +868,12 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 
 	case SNDRV_PCM_FORMAT_U24_3LE:
 	case SNDRV_PCM_FORMAT_S24_3LE:
-	case SNDRV_PCM_FORMAT_U24_LE:
-	case SNDRV_PCM_FORMAT_S24_LE:
 		dma_params->data_type = 3;
 		word_length = DAVINCI_AUDIO_WORD_24;
 		break;
 
+	case SNDRV_PCM_FORMAT_U24_LE:
+	case SNDRV_PCM_FORMAT_S24_LE:
 	case SNDRV_PCM_FORMAT_U32_LE:
 	case SNDRV_PCM_FORMAT_S32_LE:
 		dma_params->data_type = 4;
-- 
1.7.11.4
