From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/4] ASoC: davinci-mcasp: Implement configurable dismod handling
Date: Fri, 16 Nov 2018 15:41:41 +0200
Message-ID: <20181116134141.17396-5-peter.ujfalusi@ti.com>
References: <20181116134141.17396-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116134141.17396-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If the dismod is specified in the DT node, use the specified custom value
to configure the drive on state of the inactive TX slots.

If the dismod is not present or booted in legacy mode, the dismod is set
to low as it was the original behavior.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/platform_data/davinci_asp.h |  1 +
 sound/soc/davinci/davinci-mcasp.c         | 19 ++++++++++++++++++-
 sound/soc/davinci/davinci-mcasp.h         |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
index 85ad68f9206a..7fe80f1c7e08 100644
--- a/include/linux/platform_data/davinci_asp.h
+++ b/include/linux/platform_data/davinci_asp.h
@@ -79,6 +79,7 @@ struct davinci_mcasp_pdata {
 	/* McASP specific fields */
 	int tdm_slots;
 	u8 op_mode;
+	u8 dismod;
 	u8 num_serializer;
 	u8 *serial_dir;
 	u8 version;
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 0f3911be1c8e..40d3a916fb74 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -85,6 +85,7 @@ struct davinci_mcasp {
 	u32	tdm_mask[2];
 	int	slot_width;
 	u8	op_mode;
+	u8	dismod;
 	u8	num_serializer;
 	u8	*serial_dir;
 	u8	version;
@@ -834,7 +835,7 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 		if (mcasp->serial_dir[i] == TX_MODE &&
 					tx_ser < max_active_serializers) {
 			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
-				       DISMOD_LOW, DISMOD_MASK);
+				       mcasp->dismod, DISMOD_MASK);
 			set_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 			tx_ser++;
 		} else if (mcasp->serial_dir[i] == RX_MODE &&
@@ -847,6 +848,8 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 		} else if (mcasp->serial_dir[i] == TX_MODE) {
 			/* Unused TX pins, clear PDIR  */
+			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
+				       mcasp->dismod, DISMOD_MASK);
 			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 		}
 	}
@@ -1709,6 +1712,7 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 
 	if (pdev->dev.platform_data) {
 		pdata = pdev->dev.platform_data;
+		pdata->dismod = DISMOD_LOW;
 		return pdata;
 	} else if (match) {
 		pdata = devm_kmemdup(&pdev->dev, match->data, sizeof(*pdata),
@@ -1798,6 +1802,18 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 	if (ret >= 0)
 		pdata->sram_size_capture = val;
 
+	ret = of_property_read_u32(np, "dismod", &val);
+	if (ret >= 0) {
+		if (val == 0 || val == 2 || val == 3) {
+			pdata->dismod = DISMOD_VAL(val);
+		} else {
+			dev_warn(&pdev->dev, "Invalid dismod value: %u\n", val);
+			pdata->dismod = DISMOD_LOW;
+		}
+	} else {
+		pdata->dismod = DISMOD_LOW;
+	}
+
 	return  pdata;
 
 nodata:
@@ -1973,6 +1989,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	mcasp->version = pdata->version;
 	mcasp->txnumevt = pdata->txnumevt;
 	mcasp->rxnumevt = pdata->rxnumevt;
+	mcasp->dismod = pdata->dismod;
 
 	mcasp->dev = &pdev->dev;
 
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index acb024ab6a9d..5e4060d8fe56 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -209,6 +209,7 @@
 #define DISMOD_3STATE	(0x0)
 #define DISMOD_LOW	(0x2 << 2)
 #define DISMOD_HIGH	(0x3 << 2)
+#define DISMOD_VAL(x)	((x) << 2)
 #define DISMOD_MASK	DISMOD_HIGH
 #define TXSTATE		BIT(4)
 #define RXSTATE		BIT(5)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
