From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: [PATCH] ASoC: davinci: bug fixes for DM365 voice codec
	driver
Date: Wed, 20 Jul 2011 16:15:30 +0530
Message-ID: <1311158730-12412-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BB6E245AA
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 12:59:32 +0200 (CEST)
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6KAxRD1026290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2011 05:59:30 -0500
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
Cc: davinci-linux-open-source@linux.davincidsp.com, "Rajashekhara,
	Sudhakar" <sudhakar.raj@ti.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes the following bugs found in DaVinci voice codec driver.

a. According to DM365 voice codec data sheet at [1], before starting
   recording or playback, ADC/DAC modules should follow a reset and
   enable cycle. Writing a 1 to the ADC/DAC bit in the register resets
   the module and clearing the bit to 0 will enable the module. But the
   driver seems to be doing the reverse of it.

b. In davinci_vcif_trigger() function, a break() statement was missing
   causing the davinci_vcif_stop() function to be called as a fallback
   after calling davinci_vcif_start().

[1] http://focus.ti.com/lit/ug/sprufi9b/sprufi9b.pdf

Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
---
 sound/soc/davinci/davinci-vcif.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index 9259f1f..1f11525 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -62,9 +62,9 @@ static void davinci_vcif_start(struct snd_pcm_substream *substream)
 	w = readl(davinci_vc->base + DAVINCI_VC_CTRL);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTDAC, 1);
+		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTDAC, 0);
 	else
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTADC, 1);
+		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTADC, 0);
 
 	writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
 }
@@ -80,9 +80,9 @@ static void davinci_vcif_stop(struct snd_pcm_substream *substream)
 	/* Reset transmitter/receiver and sample rate/frame sync generators */
 	w = readl(davinci_vc->base + DAVINCI_VC_CTRL);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTDAC, 0);
+		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTDAC, 1);
 	else
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTADC, 0);
+		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTADC, 1);
 
 	writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
 }
@@ -159,6 +159,7 @@ static int davinci_vcif_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		davinci_vcif_start(substream);
+		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-- 
1.7.1
