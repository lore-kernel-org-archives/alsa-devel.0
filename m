From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH 3/7] snd-atmel-ac97c: do not overwrite OCA and
	ICA when assigning channels
Date: Tue, 24 Mar 2009 13:47:46 +0100
Message-ID: <1237898870-15780-4-git-send-email-hans-christian.egtvedt@atmel.com>
References: <1237898870-15780-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-3-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id EEF76103827
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 13:47:52 +0100 (CET)
In-Reply-To: <1237898870-15780-3-git-send-email-hans-christian.egtvedt@atmel.com>
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
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch will take care not to overwrite OCA and ICA registers when
assigning input and output channels. It will also make sure the
registers are at a known state when enabling a channel and clean up
properly in case of an error.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 sound/atmel/ac97c.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 21be9c9..4e8f66d 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -1,5 +1,5 @@
 /*
- * Driver for the Atmel AC97C controller
+ * Driver for Atmel AC97C
  *
  * Copyright (C) 2005-2009 Atmel Corporation
  *
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/bitmap.h>
+#include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
@@ -297,9 +298,11 @@ static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned long word = 0;
+	unsigned long word = ac97c_readl(chip, OCA);
 	int retval;
 
+	word &= ~(AC97C_CH_MASK(PCM_LEFT) | AC97C_CH_MASK(PCM_RIGHT));
+
 	/* assign channels to AC97C channel A */
 	switch (runtime->channels) {
 	case 1:
@@ -323,9 +326,13 @@ static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
 		word |= AC97C_CMR_CEM_LITTLE;
 		break;
 	case SNDRV_PCM_FORMAT_S16_BE: /* fall through */
-	default:
 		word &= ~(AC97C_CMR_CEM_LITTLE);
 		break;
+	default:
+		word = ac97c_readl(chip, OCA);
+		word &= ~(AC97C_CH_MASK(PCM_LEFT) | AC97C_CH_MASK(PCM_RIGHT));
+		ac97c_writel(chip, OCA, word);
+		return -EINVAL;
 	}
 
 	ac97c_writel(chip, CAMR, word);
@@ -358,9 +365,11 @@ static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned long word = 0;
+	unsigned long word = ac97c_readl(chip, ICA);
 	int retval;
 
+	word &= ~(AC97C_CH_MASK(PCM_LEFT) | AC97C_CH_MASK(PCM_RIGHT));
+
 	/* assign channels to AC97C channel A */
 	switch (runtime->channels) {
 	case 1:
@@ -384,9 +393,13 @@ static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
 		word |= AC97C_CMR_CEM_LITTLE;
 		break;
 	case SNDRV_PCM_FORMAT_S16_BE: /* fall through */
-	default:
 		word &= ~(AC97C_CMR_CEM_LITTLE);
 		break;
+	default:
+		word = ac97c_readl(chip, ICA);
+		word &= ~(AC97C_CH_MASK(PCM_LEFT) | AC97C_CH_MASK(PCM_RIGHT));
+		ac97c_writel(chip, ICA, word);
+		return -EINVAL;
 	}
 
 	ac97c_writel(chip, CAMR, word);
-- 
1.5.6.3
