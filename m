From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 2/3] ASoC: mxs-saif: Store saif state
Date: Fri, 11 Oct 2013 12:11:03 +0200
Message-ID: <1381486264-1672-3-git-send-email-mpa@pengutronix.de>
References: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 108AF265670
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 12:11:56 +0200 (CEST)
In-Reply-To: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Trigger commands may be passed multiple times. To avoid errors with
clk_enable/disable, store the saif state and return if saif is already
running/stopped.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/mxs/mxs-saif.c | 8 ++++++++
 sound/soc/mxs/mxs-saif.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index b56b8a0..c8ead01 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -503,6 +503,9 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (saif->state == MXS_SAIF_STATE_RUNNING)
+			return 0;
+
 		dev_dbg(cpu_dai->dev, "start\n");
 
 		clk_enable(master_saif->clk);
@@ -543,6 +546,7 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 		}
 
 		master_saif->ongoing = 1;
+		saif->state = MXS_SAIF_STATE_RUNNING;
 
 		dev_dbg(saif->dev, "CTRL 0x%x STAT 0x%x\n",
 			__raw_readl(saif->base + SAIF_CTRL),
@@ -555,6 +559,9 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (saif->state == MXS_SAIF_STATE_STOPPED)
+			return 0;
+
 		dev_dbg(cpu_dai->dev, "stop\n");
 
 		/* wait a while for the current sample to complete */
@@ -575,6 +582,7 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 		}
 
 		master_saif->ongoing = 0;
+		saif->state = MXS_SAIF_STATE_STOPPED;
 
 		break;
 	default:
diff --git a/sound/soc/mxs/mxs-saif.h b/sound/soc/mxs/mxs-saif.h
index 53eaa4b..fbaf7ba 100644
--- a/sound/soc/mxs/mxs-saif.h
+++ b/sound/soc/mxs/mxs-saif.h
@@ -124,6 +124,11 @@ struct mxs_saif {
 
 	u32 fifo_underrun;
 	u32 fifo_overrun;
+
+	enum {
+		MXS_SAIF_STATE_STOPPED,
+		MXS_SAIF_STATE_RUNNING,
+	} state;
 };
 
 extern int mxs_saif_put_mclk(unsigned int saif_id);
-- 
1.8.4.rc3
