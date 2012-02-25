From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH] ASoC: Samsung: Merge two identical if-else
	clauses
Date: Sat, 25 Feb 2012 16:42:34 +0530
Message-ID: <1330168354-3197-1-git-send-email-jaswinder.singh@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4A46524426
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 12:12:45 +0100 (CET)
Received: by pbcxa12 with SMTP id xa12so2131997pbc.38
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 03:12:44 -0800 (PST)
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
Cc: sbkim73@samsung.com, Jassi Brar <jaswinder.singh@linaro.org>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Saves two lines and a hell of a lot of embarrassment looking at the code.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 sound/soc/samsung/i2s.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 7ccb075..6553b19 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -761,15 +761,13 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		local_irq_save(flags);
 
-		if (capture)
+		if (capture) {
 			i2s_rxctrl(i2s, 0);
-		else
-			i2s_txctrl(i2s, 0);
-
-		if (capture)
 			i2s_fifo(i2s, FIC_RXFLUSH);
-		else
+		} else {
+			i2s_txctrl(i2s, 0);
 			i2s_fifo(i2s, FIC_TXFLUSH);
+		}
 
 		local_irq_restore(flags);
 		break;
-- 
1.7.4.1
