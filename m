From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/6] ASoC: davinci-mcasp: Simplify and clean up
	the AFIFO configuration code
Date: Tue, 1 Apr 2014 15:55:09 +0300
Message-ID: <1396356912-30466-4-git-send-email-peter.ujfalusi@ti.com>
References: <1396356912-30466-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id A556C2652EE
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 14:55:25 +0200 (CEST)
In-Reply-To: <1396356912-30466-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: detheridge@ti.com, alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

We can have more linear code flow by using variables in
mcasp_common_hw_param() related to the AFIFO configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 48 +++++++++++++++++++--------------------
 sound/soc/davinci/davinci-mcasp.h |  1 +
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 4007b1f3141b..9620d0165133 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -38,6 +38,8 @@
 #include "davinci-pcm.h"
 #include "davinci-mcasp.h"
 
+#define MCASP_MAX_AFIFO_DEPTH	64
+
 struct davinci_mcasp_context {
 	u32	txfmtctl;
 	u32	rxfmtctl;
@@ -461,9 +463,9 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	int i;
 	u8 tx_ser = 0;
 	u8 rx_ser = 0;
-	u8 ser;
 	u8 slots = mcasp->tdm_slots;
 	u8 max_active_serializers = (channels + slots - 1) / slots;
+	u8 active_serializers, numevt;
 	u32 reg;
 	/* Default configuration */
 	if (mcasp->version != MCASP_VERSION_4)
@@ -497,36 +499,34 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 		}
 	}
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		ser = tx_ser;
-	else
-		ser = rx_ser;
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		active_serializers = tx_ser;
+		numevt = mcasp->txnumevt;
+		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+	} else {
+		active_serializers = rx_ser;
+		numevt = mcasp->rxnumevt;
+		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
+	}
 
-	if (ser < max_active_serializers) {
+	if (active_serializers < max_active_serializers) {
 		dev_warn(mcasp->dev, "stream has more channels (%d) than are "
-			"enabled in mcasp (%d)\n", channels, ser * slots);
+			 "enabled in mcasp (%d)\n", channels,
+			 active_serializers * slots);
 		return -EINVAL;
 	}
 
-	if (mcasp->txnumevt && stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (mcasp->txnumevt * tx_ser > 64)
-			mcasp->txnumevt = 1;
-
-		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
-		mcasp_mod_bits(mcasp, reg, tx_ser, NUMDMA_MASK);
-		mcasp_mod_bits(mcasp, reg, ((mcasp->txnumevt * tx_ser) << 8),
-			       NUMEVT_MASK);
-	}
+	/* AFIFO is not in use */
+	if (!numevt)
+		return 0;
 
-	if (mcasp->rxnumevt && stream == SNDRV_PCM_STREAM_CAPTURE) {
-		if (mcasp->rxnumevt * rx_ser > 64)
-			mcasp->rxnumevt = 1;
+	if (numevt * active_serializers > MCASP_MAX_AFIFO_DEPTH)
+		numevt = active_serializers;
 
-		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
-		mcasp_mod_bits(mcasp, reg, rx_ser, NUMDMA_MASK);
-		mcasp_mod_bits(mcasp, reg, ((mcasp->rxnumevt * rx_ser) << 8),
-			       NUMEVT_MASK);
-	}
+	/* Configure the AFIFO */
+	numevt *= active_serializers;
+	mcasp_mod_bits(mcasp, reg, active_serializers, NUMDMA_MASK);
+	mcasp_mod_bits(mcasp, reg, NUMEVT(numevt), NUMEVT_MASK);
 
 	return 0;
 }
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 53243c22818d..9737108f0305 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -289,6 +289,7 @@
  */
 #define FIFO_ENABLE	BIT(16)
 #define NUMEVT_MASK	(0xFF << 8)
+#define NUMEVT(x)	(((x) & 0xFF) << 8)
 #define NUMDMA_MASK	(0xFF)
 
 #endif	/* DAVINCI_MCASP_H */
-- 
1.9.1
