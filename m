From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/6] ASoC: davinci-mcasp: Validate tdm_slots
	parameter at probe time
Date: Mon, 10 Nov 2014 12:32:15 +0200
Message-ID: <1415615540-28981-2-git-send-email-peter.ujfalusi@ti.com>
References: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 026EF2614CE
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 11:32:28 +0100 (CET)
In-Reply-To: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Instead of validating the tdm_slots parameter every time at hw_params we
can do it once during probe. If the parameter is not valid (<2 or >32)
print an error and fix it up.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 6b1bfd9de57d..10c264738a0b 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -632,13 +632,7 @@ static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream)
 	u32 mask = 0;
 	u32 busel = 0;
 
-	if ((mcasp->tdm_slots < 2) || (mcasp->tdm_slots > 32)) {
-		dev_err(mcasp->dev, "tdm slot %d not supported\n",
-			mcasp->tdm_slots);
-		return -EINVAL;
-	}
-
-	active_slots = (mcasp->tdm_slots > 31) ? 32 : mcasp->tdm_slots;
+	active_slots = mcasp->tdm_slots;
 	for (i = 0; i < active_slots; i++)
 		mask |= (1 << i);
 
@@ -650,12 +644,12 @@ static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream)
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXTDM_REG, mask);
 	mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, busel | TXORD);
 	mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG,
-		       FSXMOD(mcasp->tdm_slots), FSXMOD(0x1FF));
+		       FSXMOD(active_slots), FSXMOD(0x1FF));
 
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXTDM_REG, mask);
 	mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMT_REG, busel | RXORD);
 	mcasp_mod_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG,
-		       FSRMOD(mcasp->tdm_slots), FSRMOD(0x1FF));
+		       FSRMOD(active_slots), FSRMOD(0x1FF));
 
 	return 0;
 }
@@ -1237,7 +1231,21 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	}
 
 	mcasp->op_mode = pdata->op_mode;
-	mcasp->tdm_slots = pdata->tdm_slots;
+	/* sanity check for tdm slots parameter */
+	if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE) {
+		if (pdata->tdm_slots < 2) {
+			dev_err(&pdev->dev, "invalid tdm slots: %d\n",
+				pdata->tdm_slots);
+			mcasp->tdm_slots = 2;
+		} else if (pdata->tdm_slots > 32) {
+			dev_err(&pdev->dev, "invalid tdm slots: %d\n",
+				pdata->tdm_slots);
+			mcasp->tdm_slots = 32;
+		} else {
+			mcasp->tdm_slots = pdata->tdm_slots;
+		}
+	}
+
 	mcasp->num_serializer = pdata->num_serializer;
 #ifdef CONFIG_PM_SLEEP
 	mcasp->context.xrsr_regs = devm_kzalloc(&pdev->dev,
-- 
2.1.3
