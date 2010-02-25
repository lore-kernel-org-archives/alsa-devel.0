From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: [PATCH] [patch 2/2] AC97: add full duplex support for
	atmel AT91 and AVR.
Date: Thu, 25 Feb 2010 18:59:40 +0100
Message-ID: <1267120780-1788-1-git-send-email-sedji.gaouaou@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id A20181039D1
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 17:47:16 +0100 (CET)
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
Cc: sedji.gaouaou@atmel.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch add full duplex support on AT91 and AVR.
It was a bug: we needed to check first if there are some chips opened so we
could enable both reception and sending of the data.

Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
---
 sound/atmel/ac97c.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index d48a59a..6f5e22c 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -339,7 +339,11 @@ static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
 	ac97c_writel(chip, OCA, word);
 
 	/* configure sample format and size */
-	word = AC97C_CMR_DMAEN | AC97C_CMR_SIZE_16;
+	word = ac97c_readl(chip, CAMR);
+	if (chip->opened <= 1)
+		word = AC97C_CMR_DMAEN | AC97C_CMR_SIZE_16;
+	else
+		word |= AC97C_CMR_DMAEN | AC97C_CMR_SIZE_16;
 
 	switch (runtime->format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -426,7 +430,11 @@ static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
 	ac97c_writel(chip, ICA, word);
 
 	/* configure sample format and size */
-	word = AC97C_CMR_DMAEN | AC97C_CMR_SIZE_16;
+	word = ac97c_readl(chip, CAMR);
+	if (chip->opened <= 1)
+		word = AC97C_CMR_DMAEN | AC97C_CMR_SIZE_16;
+	else
+		word |= AC97C_CMR_DMAEN | AC97C_CMR_SIZE_16;
 
 	switch (runtime->format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -506,7 +514,7 @@ atmel_ac97c_playback_trigger(struct snd_pcm_substream *substream, int cmd)
 		} else {
 			ptcr = ATMEL_PDC_TXTEN;
 		}
-		camr |= AC97C_CMR_CENA;
+		camr |= AC97C_CMR_CENA | AC97C_CSR_ENDTX;
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: /* fall through */
 	case SNDRV_PCM_TRIGGER_SUSPEND: /* fall through */
@@ -551,7 +559,7 @@ atmel_ac97c_capture_trigger(struct snd_pcm_substream *substream, int cmd)
 		} else {
 			ptcr = ATMEL_PDC_RXTEN;
 		}
-		camr |= AC97C_CMR_CENA;
+		camr |= AC97C_CMR_CENA | AC97C_CSR_ENDRX;
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: /* fall through */
 	case SNDRV_PCM_TRIGGER_SUSPEND: /* fall through */
-- 
1.5.6.5
