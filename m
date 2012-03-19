From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: ASoC: pxa-ssp: atomically set stream
	active masks
Date: Mon, 19 Mar 2012 09:12:53 +0100
Message-ID: <1332144773-3263-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 89685103B38
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 09:13:12 +0100 (CET)
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
Cc: Eric Miao <eric.y.miao@gmail.com>, stable@kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, s.neumann@raumfeld.com, Haojian Zhuang <haojian.zhuang@marvell.com>, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

PXA's SSP engine fails to take its current channel phase into account
when enabling a stream while the engine is already running. This
results in randomly swapped left/right channels on either the record
or the playback side, depending on which one was enabled first.

The following patch fixes this by factoring out the bit field
modifications in question to a separate function that pauses the
engine temporarily, modifies the bits and kicks it off again
afterwards. Appearantly, a transition of SSCR0_SSE syncs both
directions properly.

The patch has been rolled out to quite a number of devices over the
last weeks and seems to fix the issue reliably.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-and-tested-by: Sven Neumann <s.neumann@raumfeld.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Johannes Stezenbach <js@sig21.net>
Cc: stable@kernel.org
---
 sound/soc/pxa/pxa-ssp.c |   61 +++++++++++++++++++++++++++-------------------
 1 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index a16df0f..fd04ce1 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -668,6 +668,38 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static void pxa_ssp_set_running_bit(struct snd_pcm_substream *substream,
+				    struct ssp_device *ssp, int value)
+{
+	uint32_t sscr0 = pxa_ssp_read_reg(ssp, SSCR0);
+	uint32_t sscr1 = pxa_ssp_read_reg(ssp, SSCR1);
+	uint32_t sspsp = pxa_ssp_read_reg(ssp, SSPSP);
+	uint32_t sssr = pxa_ssp_read_reg(ssp, SSSR);
+
+	if (value && (sscr0 & SSCR0_SSE))
+		pxa_ssp_write_reg(ssp, SSCR0, sscr0 & ~SSCR0_SSE);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (value)
+			sscr1 |= SSCR1_TSRE;
+		else
+			sscr1 &= ~SSCR1_TSRE;
+	} else {
+		if (value)
+			sscr1 |= SSCR1_RSRE;
+		else
+			sscr1 &= ~SSCR1_RSRE;
+	}
+
+	pxa_ssp_write_reg(ssp, SSCR1, sscr1);
+
+	if (value) {
+		pxa_ssp_write_reg(ssp, SSSR, sssr);
+		pxa_ssp_write_reg(ssp, SSPSP, sspsp);
+		pxa_ssp_write_reg(ssp, SSCR0, sscr0 | SSCR0_SSE);
+	}
+}
+
 static int pxa_ssp_trigger(struct snd_pcm_substream *substream, int cmd,
 			   struct snd_soc_dai *cpu_dai)
 {
@@ -681,42 +713,21 @@ static int pxa_ssp_trigger(struct snd_pcm_substream *substream, int cmd,
 		pxa_ssp_enable(ssp);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		val = pxa_ssp_read_reg(ssp, SSCR1);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			val |= SSCR1_TSRE;
-		else
-			val |= SSCR1_RSRE;
-		pxa_ssp_write_reg(ssp, SSCR1, val);
+		pxa_ssp_set_running_bit(substream, ssp, 1);
 		val = pxa_ssp_read_reg(ssp, SSSR);
 		pxa_ssp_write_reg(ssp, SSSR, val);
 		break;
 	case SNDRV_PCM_TRIGGER_START:
-		val = pxa_ssp_read_reg(ssp, SSCR1);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			val |= SSCR1_TSRE;
-		else
-			val |= SSCR1_RSRE;
-		pxa_ssp_write_reg(ssp, SSCR1, val);
-		pxa_ssp_enable(ssp);
+		pxa_ssp_set_running_bit(substream, ssp, 1);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		val = pxa_ssp_read_reg(ssp, SSCR1);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			val &= ~SSCR1_TSRE;
-		else
-			val &= ~SSCR1_RSRE;
-		pxa_ssp_write_reg(ssp, SSCR1, val);
+		pxa_ssp_set_running_bit(substream, ssp, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		pxa_ssp_disable(ssp);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		val = pxa_ssp_read_reg(ssp, SSCR1);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			val &= ~SSCR1_TSRE;
-		else
-			val &= ~SSCR1_RSRE;
-		pxa_ssp_write_reg(ssp, SSCR1, val);
+		pxa_ssp_set_running_bit(substream, ssp, 0);
 		break;
 
 	default:
-- 
1.7.7.6
