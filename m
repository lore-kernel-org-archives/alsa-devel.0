From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: ti: davinci-mcasp: Set unused
	serializers as INACTIVE
Date: Thu, 20 Jun 2019 12:20:01 +0300
Message-ID: <20190620092002.13766-2-peter.ujfalusi@ti.com>
References: <20190620092002.13766-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03B5DF80C15
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2019 11:19:32 +0200 (CEST)
In-Reply-To: <20190620092002.13766-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Unused serializers needs to be configured as INACTIVE, otherwise they will
underflow/overflow when multiple serializers are connected, but some are
not needed for the given stream.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index a8378d223a9e..8bec0dc4f754 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -848,14 +848,15 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 					rx_ser < max_active_serializers) {
 			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 			rx_ser++;
-		} else if (mcasp->serial_dir[i] == INACTIVE_MODE) {
+		} else {
+			/* Inactive or unused pin, set it to inactive */
 			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
 				       SRMOD_INACTIVE, SRMOD_MASK);
-			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
-		} else if (mcasp->serial_dir[i] == TX_MODE) {
-			/* Unused TX pins, clear PDIR  */
-			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
-				       mcasp->dismod, DISMOD_MASK);
+			/* If unused, set DISMOD for the pin */
+			if (mcasp->serial_dir[i] != INACTIVE_MODE)
+				mcasp_mod_bits(mcasp,
+					       DAVINCI_MCASP_XRSRCTL_REG(i),
+					       mcasp->dismod, DISMOD_MASK);
 			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 		}
 	}
@@ -965,6 +966,7 @@ static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream,
 		for (i = 0; i < active_slots; i++)
 			mask |= (1 << i);
 	}
+
 	mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, TX_ASYNC);
 
 	if (!mcasp->dat_port)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
