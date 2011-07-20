From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: [PATCH v2 2/2] ASoC: davinci: add missing break
	statement
Date: Wed, 20 Jul 2011 17:37:18 +0530
Message-ID: <1311163638-24712-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id C3F91243A8
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 14:20:20 +0200 (CEST)
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
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com, "Rajashekhara,
	Sudhakar" <sudhakar.raj@ti.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

In davinci_vcif_trigger() function, a break() statement was missing
causing the davinci_vcif_stop() function to be called as a fallback
after calling davinci_vcif_start().

Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
---
 sound/soc/davinci/davinci-vcif.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index c957e9e..1f11525 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
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
