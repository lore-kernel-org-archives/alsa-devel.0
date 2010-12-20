From: Jassi@alsa-project.org, "Brar <jassisinghbrar"@gmail.com
Subject: [PATCH 02/10] ASoC: Samsung: I2S: Flush FIFO after stop
Date: Mon, 20 Dec 2010 11:05:47 +0900
Message-ID: <1292810747-29968-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292810667-29773-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id ECB56245B1
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 03:27:06 +0100 (CET)
In-Reply-To: <1292810667-29773-1-git-send-email-jassisinghbrar@gmail.com>
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
Cc: lrg@slimlogic.co.uk, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Flush the FIFO while stopping the channel rather than starting.
This saves time during stream start and keeps the FIFOs clean
when the channel is idling.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/samsung/i2s.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 26b4bdf..d00ac3a 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -843,11 +843,6 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		local_irq_save(flags);
 
-		if (capture)
-			i2s_fifo(i2s, FIC_RXFLUSH);
-		else
-			i2s_fifo(i2s, FIC_TXFLUSH);
-
 		if (config_setup(i2s)) {
 			local_irq_restore(flags);
 			return -EINVAL;
@@ -870,6 +865,11 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
 		else
 			i2s_txctrl(i2s, 0);
 
+		if (capture)
+			i2s_fifo(i2s, FIC_RXFLUSH);
+		else
+			i2s_fifo(i2s, FIC_TXFLUSH);
+
 		local_irq_restore(flags);
 		break;
 	}
-- 
1.6.2.5
