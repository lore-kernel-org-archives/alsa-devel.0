From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/5] ALSA: ASoC: McASP: add support for 24 bit
	samples
Date: Thu,  4 Oct 2012 15:08:40 +0200
Message-ID: <1349356122-14794-4-git-send-email-zonque@gmail.com>
References: <1349356122-14794-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 59663261631
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 15:09:12 +0200 (CEST)
In-Reply-To: <1349356122-14794-1-git-send-email-zonque@gmail.com>
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
Cc: Matt Porter <mporter@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Cc: Matt Porter <mporter@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 1252bad..ab9773d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -839,6 +839,14 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		word_length = DAVINCI_AUDIO_WORD_16;
 		break;
 
+	case SNDRV_PCM_FORMAT_U24_3LE:
+	case SNDRV_PCM_FORMAT_S24_3LE:
+	case SNDRV_PCM_FORMAT_U24_LE:
+	case SNDRV_PCM_FORMAT_S24_LE:
+		dma_params->data_type = 3;
+		word_length = DAVINCI_AUDIO_WORD_24;
+		break;
+
 	case SNDRV_PCM_FORMAT_U32_LE:
 	case SNDRV_PCM_FORMAT_S32_LE:
 		dma_params->data_type = 4;
-- 
1.7.11.4
