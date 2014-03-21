From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 1/4] ASoC: core: remove the 'of_' prefix of
	of_xlate_tdm_slot_mask.
Date: Fri, 21 Mar 2014 14:17:12 +0800
Message-ID: <1395382635-16349-2-git-send-email-Li.Xiubo@freescale.com>
References: <1395382635-16349-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 by alsa0.perex.cz (Postfix) with ESMTP id A0774265316
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 08:01:30 +0100 (CET)
In-Reply-To: <1395382635-16349-1-git-send-email-Li.Xiubo@freescale.com>
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
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, Xiubo Li <Li.Xiubo@freescale.com>, Guangyu.Chen@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

The 'of_' is not appropriate here for there hasn't any DT parsing.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 include/sound/soc-dai.h |  2 +-
 sound/soc/soc-core.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 2f66d5e..fad7676 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -142,7 +142,7 @@ struct snd_soc_dai_ops {
 	 * Called by soc_card drivers, normally in their hw_params.
 	 */
 	int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);
-	int (*of_xlate_tdm_slot_mask)(unsigned int slots,
+	int (*xlate_tdm_slot_mask)(unsigned int slots,
 		unsigned int *tx_mask, unsigned int *rx_mask);
 	int (*set_tdm_slot)(struct snd_soc_dai *dai,
 		unsigned int tx_mask, unsigned int rx_mask,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b322cf2..318fee8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3625,14 +3625,14 @@ int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
 
 /**
- * snd_soc_of_xlate_tdm_slot - generate tx/rx slot mask.
+ * snd_soc_xlate_tdm_slot - generate tx/rx slot mask.
  * @slots: Number of slots in use.
  * @tx_mask: bitmask representing active TX slots.
  * @rx_mask: bitmask representing active RX slots.
  *
  * Generates the TDM tx and rx slot default masks for DAI.
  */
-static int snd_soc_of_xlate_tdm_slot_mask(unsigned int slots,
+static int snd_soc_xlate_tdm_slot_mask(unsigned int slots,
 					  unsigned int *tx_mask,
 					  unsigned int *rx_mask)
 {
@@ -3662,11 +3662,11 @@ static int snd_soc_of_xlate_tdm_slot_mask(unsigned int slots,
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
-	if (dai->driver && dai->driver->ops->of_xlate_tdm_slot_mask)
-		dai->driver->ops->of_xlate_tdm_slot_mask(slots,
+	if (dai->driver && dai->driver->ops->xlate_tdm_slot_mask)
+		dai->driver->ops->xlate_tdm_slot_mask(slots,
 						&tx_mask, &rx_mask);
 	else
-		snd_soc_of_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
+		snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
 
 	if (dai->driver && dai->driver->ops->set_tdm_slot)
 		return dai->driver->ops->set_tdm_slot(dai, tx_mask, rx_mask,
-- 
1.8.4
