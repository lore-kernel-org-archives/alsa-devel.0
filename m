From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: mxs-saif: Fix channel swap for 24-bit
	format
Date: Tue, 30 Oct 2012 21:07:09 -0200
Message-ID: <1351638429-13865-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
 [209.85.160.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A73BD2608E7
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 00:07:23 +0100 (CET)
Received: by mail-gh0-f179.google.com with SMTP id g20so171983ghb.38
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 16:07:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dong.aisheng@linaro.org, DWinner@tc-helicon.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Playing 24-bit format file leads to channel swap on mx28 and the reason is that
the current driver performs one write/read to/from the SAIF_DATA register to 
trigger the transfer.

This approach works fine for S16_LE case because SAIF_DATA is a 32-bit register 
and thus is capable of storing the 16-bit left and right channels, but for the 
S24_LE case it can only store one channel, so in order to not lose the FIFO sync
an extra read/write is needed.

Reported-by: Dan Winner <DWinner@tc-helicon.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Tested-by: Dan Winner <DWinner@tc-helicon.com>
---
 sound/soc/mxs/mxs-saif.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index aa037b2..05a875c 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -523,16 +523,22 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			/*
-			 * write a data to saif data register to trigger
-			 * the transfer
+			 * write data to saif data register to trigger
+			 * the transfer.
+			 * For 24-bit format the 32-bit FIFO register stores
+			 * only one channel, so we need to write twice.
 			 */
 			__raw_writel(0, saif->base + SAIF_DATA);
+			__raw_writel(0, saif->base + SAIF_DATA);
 		} else {
 			/*
-			 * read a data from saif data register to trigger
-			 * the receive
+			 * read data from saif data register to trigger
+			 * the receive.
+			 * For 24-bit format the 32-bit FIFO register stores
+			 * only one channel, so we need to read twice.
 			 */
 			__raw_readl(saif->base + SAIF_DATA);
+			__raw_readl(saif->base + SAIF_DATA);
 		}
 
 		master_saif->ongoing = 1;
-- 
1.7.9.5
