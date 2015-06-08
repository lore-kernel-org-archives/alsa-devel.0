From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Logic low for inactive
	output slots
Date: Mon, 8 Jun 2015 16:03:47 +0300
Message-ID: <1433768627-30041-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 55411260476
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 15:03:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: misael.lopez@ti.com, alsa-devel@alsa-project.org, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

The default state when serializers are in inactive slots is Hi-Z.
In some cases, there are no additional components driving the data
lines to a safe state so they might have noise.

While in inactive slots, the McASP AXR pins configured as outputs
can be driven low through the serializer pin drive mode setting
(DISMOD) to prevent such noise.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 2 ++
 sound/soc/davinci/davinci-mcasp.h | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index d79349434a9a..26cbc213b8cf 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -686,6 +686,8 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 		if (mcasp->serial_dir[i] == TX_MODE &&
 					tx_ser < max_active_serializers) {
 			mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AXR(i));
+			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
+				       DISMOD_LOW, DISMOD_MASK);
 			tx_ser++;
 		} else if (mcasp->serial_dir[i] == RX_MODE &&
 					rx_ser < max_active_serializers) {
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 79dc511180bf..a3be108a8c17 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -215,7 +215,10 @@
  * DAVINCI_MCASP_XRSRCTL_BASE_REG -  Serializer Control Register Bits
  */
 #define MODE(val)	(val)
-#define DISMOD		(val)(val<<2)
+#define DISMOD_3STATE	(0x0)
+#define DISMOD_LOW	(0x2 << 2)
+#define DISMOD_HIGH	(0x3 << 2)
+#define DISMOD_MASK	DISMOD_HIGH
 #define TXSTATE		BIT(4)
 #define RXSTATE		BIT(5)
 #define SRMOD_MASK	3
-- 
2.4.2
